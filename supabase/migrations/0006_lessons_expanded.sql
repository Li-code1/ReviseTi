-- ============================================================
-- ReviseTI — PROMPT 12: aprofundamento do conteúdo das 25 aulas
-- Rode DEPOIS de 0001-0005. Só faz UPDATE no campo content de
-- study_contents (por slug) — não toca em tópicos, perguntas,
-- progresso ou qualquer outra tabela. Idempotente (pode rodar
-- mais de uma vez com segurança).
-- Total de aulas atualizadas: 25
-- ============================================================

update public.study_contents set
  content = $md$# Core Python & POO

## Objetivo desta aula

Dominar as estruturas de dados nativas do Python e os quatro pilares da Programação Orientada a Objetos — a base sobre a qual tudo o resto (FastAPI, SQLAlchemy, testes) é construído. Sem isso bem consolidado, frameworks viram "receita decorada" em vez de ferramenta compreendida.

## Estruturas de dados

### Listas, tuplas, dicionários e sets

- **Listas** (`list`): coleção **mutável** e ordenada. Ótima para quando você precisa adicionar, remover ou alterar itens ao longo da execução.
- **Tuplas** (`tuple`): coleção **imutável** e ordenada. Use quando os dados não devem mudar (coordenadas, configurações fixas, valores de retorno agrupados).
- **Dicionários** (`dict`): pares chave-valor, mutáveis. A estrutura mais usada para representar um "registro" (um usuário, uma configuração, um resultado de API).
- **Sets** (`set`): coleção não ordenada de itens **únicos** — ideal para eliminar duplicatas e testar pertencimento (`in`) rapidamente.

```python
nomes = ["Ana", "João", "Maria"]        # lista: mutável
ponto = (10, 20)                          # tupla: imutável
usuario = {"nome": "Ana", "idade": 28}    # dict
ids_unicos = {1, 2, 2, 3}                 # set -> {1, 2, 3}

# Operações comuns
nomes.append("Duda")                      # ['Ana', 'João', 'Maria', 'Duda']
nomes.remove("João")                      # remove por valor
primeiro, *resto = nomes                  # desempacotamento
```

### Complexidade (Big O, na prática)

Pense em quanto tempo uma operação leva conforme os dados crescem:

| Estrutura | Buscar por valor | Buscar por chave/índice | Inserir no fim |
|---|---|---|---|
| Lista | O(n) — percorre tudo | O(1) por índice | O(1) amortizado |
| Dict/Set | — | O(1) em média (hashing) | O(1) em média |

Isso importa na prática: se você tem uma lista de 10.000 IDs e faz `if id in lista` repetidamente dentro de um loop, seu código fica O(n²). Trocar a lista por um `set` resolve isso para O(n).

```python
# Lento para listas grandes: O(n) por checagem
ids_processados = []
if usuario_id in ids_processados:  # percorre a lista inteira
    ...

# Rápido, independente do tamanho: O(1) por checagem
ids_processados = set()
if usuario_id in ids_processados:  # hashing direto
    ...
```

### Mutabilidade e imutabilidade

Objetos mutáveis (listas, dicts, sets) podem ser alterados depois de criados; objetos imutáveis (tuplas, strings, números, `frozenset`) não. Isso afeta como o Python lida com referências:

```python
def adicionar_item(item, lista):
    lista.append(item)  # muta a lista ORIGINAL, não uma cópia

carrinho = ["maçã"]
adicionar_item("pera", carrinho)
print(carrinho)  # ['maçã', 'pera'] — a função alterou o objeto original
```

Isso é uma fonte clássica de bugs: passar uma lista para uma função e a função alterá-la sem que isso fique óbvio no código que chamou. Quando não quiser esse efeito colateral, copie explicitamente (`lista.copy()` ou `list(lista)`).

## Pilares da Programação Orientada a Objetos

- **Encapsulamento**: esconder detalhes internos de implementação, expondo só o necessário através de uma interface clara (métodos públicos).
- **Herança**: uma classe filha reaproveita atributos e comportamento de uma classe pai, podendo estendê-los ou sobrescrevê-los.
- **Polimorfismo**: objetos de classes diferentes respondem ao mesmo método de formas diferentes.
- **Abstração**: modelar o essencial de um conceito para o contexto atual, ignorando detalhes irrelevantes.

```python
class Animal:
    def __init__(self, nome):
        self._nome = nome  # convenção: "protegido", uso interno

    def emitir_som(self):
        raise NotImplementedError("Subclasses devem implementar isso")

class Cachorro(Animal):
    def emitir_som(self):
        return f"{self._nome} diz: Woof!"

class Gato(Animal):
    def emitir_som(self):
        return f"{self._nome} diz: Miau!"

animais = [Cachorro("Rex"), Gato("Mimi")]
for a in animais:
    print(a.emitir_som())  # polimorfismo: mesmo método, comportamentos diferentes
```

### Quando usar herança vs. composição

Herança é poderosa, mas usada em excesso cria hierarquias rígidas e difíceis de manter. Uma regra prática: prefira **composição** ("tem um") quando a relação não é realmente "é um tipo de". Exemplo: um `RelatorioPDF` não deveria herdar de `GeradorDeArquivo` só para reusar um método — é melhor ele *ter* um gerador de arquivo como dependência.

## Decoradores, geradores e yield

Decoradores envolvem uma função para adicionar comportamento sem alterar seu código-fonte — é assim que `@app.get("/rota")` funciona no FastAPI.

```python
import time

def medir_tempo(func):
    def wrapper(*args, **kwargs):
        inicio = time.time()
        resultado = func(*args, **kwargs)
        print(f"{func.__name__} levou {time.time() - inicio:.2f}s")
        return resultado
    return wrapper

@medir_tempo
def processar_dados():
    time.sleep(1)

processar_dados()  # processar_dados levou 1.00s
```

Geradores, criados com `yield`, produzem valores um de cada vez, sob demanda — essencial para trabalhar com sequências grandes sem carregar tudo na memória de uma vez.

```python
def ler_linhas_grandes(caminho):
    with open(caminho) as f:
        for linha in f:
            yield linha.strip()  # produz uma linha por vez, não o arquivo inteiro

# Sem yield, ler_linhas_grandes(arquivo_de_10gb) tentaria carregar tudo na RAM.
```

## Ambientes virtuais

Um ambiente virtual (`venv`) isola as dependências de um projeto Python das demais instalações do sistema, evitando conflitos de versão entre projetos diferentes.

```bash
python -m venv .venv
source .venv/bin/activate      # Linux/Mac
.venv\Scripts\activate         # Windows
pip install -r requirements.txt
deactivate                     # sair do ambiente
```

## Erros comuns

- **Usar valor padrão mutável em função** (`def f(lista=[])`) — o valor é criado uma única vez e reaproveitado entre chamadas, causando bugs sutis de estado compartilhado.
- **Confundir `==` com `is`** — `==` compara valor, `is` compara identidade (mesmo objeto na memória).
- **Modificar uma lista enquanto itera sobre ela** — remove itens e pula posições inesperadamente. Prefira iterar sobre uma cópia (`for x in lista.copy()`) ou construir uma nova lista com `list comprehension`.
- **Herança profunda demais** — cadeias de 4-5 níveis de herança ficam difíceis de entender e testar; geralmente é sinal de que composição seria melhor.

## Checklist rápido

- [ ] Sei quando usar lista vs. tupla vs. dict vs. set
- [ ] Entendo por que buscar em um set é mais rápido que em uma lista
- [ ] Sei explicar mutabilidade com um exemplo prático
- [ ] Consigo explicar os 4 pilares da POO com exemplos, não só definição
- [ ] Sei quando um decorador ou gerador resolve um problema real$md$,
  updated_at = now()
where slug = 'semana-1-core-python-poo';

update public.study_contents set
  content = $md$# Assincronismo & FastAPI

## Objetivo desta aula

Entender por que e quando usar código assíncrono, e como o FastAPI usa isso (junto com Pydantic) para construir APIs modernas, validadas e bem organizadas.

## Concorrência vs. paralelismo

**Concorrência** é lidar com várias tarefas "ao mesmo tempo" alternando entre elas — útil quando a maior parte do tempo é gasta esperando (rede, disco, banco). **Paralelismo** é executar tarefas literalmente ao mesmo tempo, em núcleos de CPU diferentes — útil para processamento pesado.

Uma API web passa a maior parte do tempo esperando I/O (banco, chamadas externas), não fazendo cálculo pesado de CPU — por isso o assincronismo (concorrência) rende tanto ali, sem precisar de paralelismo de verdade.

## Event Loop, async e await

O **Event Loop** é o mecanismo que permite ao Python alternar entre tarefas assíncronas sem bloquear a thread principal. Uma função `async def` retorna uma *coroutine*; `await` pausa aquela função até o resultado estar pronto, liberando o Event Loop para atender outra requisição nesse meio-tempo.

```python
import asyncio

async def buscar_usuario(id: int):
    print(f"Buscando usuário {id}...")
    await asyncio.sleep(1)  # simula uma chamada de I/O (ex: consulta ao banco)
    return {"id": id, "nome": "Ana"}

async def main():
    # Sequencial: 2 segundos no total
    u1 = await buscar_usuario(1)
    u2 = await buscar_usuario(2)

    # Concorrente: ~1 segundo no total (as duas esperas acontecem "juntas")
    u1, u2 = await asyncio.gather(buscar_usuario(1), buscar_usuario(2))
```

`asyncio.gather` é a forma idiomática de rodar múltiplas coroutines concorrentemente e esperar todas terminarem — extremamente útil quando você precisa buscar dados de várias fontes independentes.

## FastAPI

FastAPI é um framework para construir APIs em Python, construído sobre Starlette (assíncrono) e Pydantic (validação), com documentação automática (Swagger/OpenAPI) gerada a partir do próprio código.

### Organizando rotas com APIRouter

```python
from fastapi import APIRouter

router = APIRouter(prefix="/reviews", tags=["reviews"])

@router.get("/")
async def listar_revisoes():
    return {"reviews": []}

@router.post("/")
async def criar_revisao(dados: dict):
    return {"created": True}
```

Isso evita um único arquivo `main.py` gigante com centenas de rotas — cada domínio (reviews, questions, users) tem seu próprio router, incluído depois com `app.include_router(router)`.

### Depends (injeção de dependências)

`Depends` permite reaproveitar lógica (autenticação, conexão de banco, paginação) entre várias rotas sem repetir código.

```python
from fastapi import Depends, HTTPException

async def get_current_user(token: str) -> dict:
    usuario = decodificar_token(token)
    if not usuario:
        raise HTTPException(status_code=401, detail="Token inválido")
    return usuario

@router.get("/me")
async def meu_perfil(user: dict = Depends(get_current_user)):
    return user

@router.get("/me/reviews")
async def minhas_revisoes(user: dict = Depends(get_current_user)):
    return buscar_revisoes(user["id"])
```

Dependências podem ser aninhadas (uma dependência pode depender de outra), o que permite construir cadeias reutilizáveis (ex: `get_current_user` → `require_admin`).

### Pydantic e validação automática

Pydantic define o formato esperado dos dados usando classes Python tipadas. O FastAPI valida automaticamente o corpo da requisição contra esse modelo, antes mesmo do seu código de rota executar.

```python
from pydantic import BaseModel, Field

class ReviewCreate(BaseModel):
    title: str = Field(min_length=1, max_length=200)
    minutes: int = Field(ge=0)
    difficulty: str

@router.post("/")
async def criar_revisao(review: ReviewCreate):
    # Se chegou até aqui, os dados já foram validados
    return {"title": review.title}
```

Se `minutes` vier negativo ou `title` vier vazio, o FastAPI recusa a requisição automaticamente com **422 Unprocessable Entity**, sem que você precise escrever `if` de validação manual.

## Erros comuns

- **Misturar código síncrono bloqueante dentro de uma rota `async def`** — chamar uma biblioteca síncrona pesada (ex: uma lib de imagem sem versão async) dentro de uma função `async` bloqueia o Event Loop inteiro, travando todas as outras requisições simultâneas.
- **Usar `async` "porque sim"** — declarar `async def` em uma função que só faz cálculo de CPU não traz ganho nenhum e adiciona complexidade desnecessária.
- **Esquecer `await`** — chamar uma coroutine sem `await` não executa a função, apenas cria um objeto coroutine "pendurado" (o Python geralmente avisa com um warning, mas o bug pode passar despercebido).
- **`Depends` para tudo** — nem toda lógica precisa virar uma dependência; usá-las em excesso deixa o fluxo de dados difícil de rastrear.

## Quando usar async e quando não

**Use quando**: a rota faz I/O (banco, chamada HTTP externa, leitura de arquivo) e você quer que o servidor continue atendendo outras requisições enquanto espera.

**Evite (ou use com cuidado) quando**: a operação é CPU-bound (processamento de imagem, cálculo matemático pesado) — nesses casos, considere rodar em um processo separado (`multiprocessing` ou uma fila como Celery, vista na próxima aula) em vez de `async`.

## Checklist rápido

- [ ] Sei explicar a diferença entre concorrência e paralelismo com um exemplo
- [ ] Entendo o papel do Event Loop e por que `await` não bloqueia o servidor
- [ ] Sei usar `Depends` para reaproveitar lógica entre rotas
- [ ] Sei por que o FastAPI retorna 422 automaticamente com Pydantic
- [ ] Sei identificar quando `async` realmente ajuda e quando não faz diferença$md$,
  updated_at = now()
where slug = 'semana-1-assincronismo-fastapi';

update public.study_contents set
  content = $md$# Persistência de Dados & SQLAlchemy

## Objetivo desta aula

Entender como um ORM traduz objetos Python em tabelas relacionais, modelar relacionamentos corretamente, e evitar o problema de performance mais comum em aplicações com banco de dados: o N+1 queries.

## O que é um ORM e por que usar um

Um **ORM** (Object-Relational Mapper) traduz tabelas do banco relacional em classes Python, e linhas em instâncias dessas classes — você manipula objetos Python em vez de escrever SQL cru para cada operação. O SQLAlchemy é o ORM mais usado no ecossistema Python.

```python
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column
from sqlalchemy import ForeignKey

class Base(DeclarativeBase):
    pass

class User(Base):
    __tablename__ = "users"
    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str]
    email: Mapped[str] = mapped_column(unique=True)

class Review(Base):
    __tablename__ = "reviews"
    id: Mapped[int] = mapped_column(primary_key=True)
    title: Mapped[str]
    user_id: Mapped[int] = mapped_column(ForeignKey("users.id"))
```

### Por que não escrever SQL puro sempre?

SQL puro funciona, mas: (1) fica repetitivo para operações CRUD básicas, (2) é mais fácil de errar tipos e nomes de coluna sem checagem em tempo de desenvolvimento, e (3) migrations e relacionamentos ficam mais difíceis de manter organizados. Em contrapartida, o ORM adiciona uma camada de abstração que, se mal compreendida, pode gerar queries ineficientes sem que você perceba — daí a importância de entender o que ele faz "por baixo dos panos".

## Relacionamentos

- **1:1** — um registro se relaciona com exatamente um outro (ex: um usuário e seu perfil estendido).
- **1:N** — um registro se relaciona com vários outros (ex: um usuário tem várias revisões).
- **N:N** — vários registros de um lado se relacionam com vários do outro, via tabela associativa (ex: aulas e tags).

```python
from sqlalchemy.orm import relationship

class User(Base):
    __tablename__ = "users"
    id: Mapped[int] = mapped_column(primary_key=True)
    reviews: Mapped[list["Review"]] = relationship(back_populates="user")

class Review(Base):
    __tablename__ = "reviews"
    id: Mapped[int] = mapped_column(primary_key=True)
    user_id: Mapped[int] = mapped_column(ForeignKey("users.id"))
    user: Mapped["User"] = relationship(back_populates="reviews")

# N:N precisa de uma tabela associativa:
tag_review = Table(
    "tag_review", Base.metadata,
    Column("review_id", ForeignKey("reviews.id"), primary_key=True),
    Column("tag_id", ForeignKey("tags.id"), primary_key=True),
)
```

## Lazy loading vs. eager loading (e o problema N+1)

**Lazy loading** busca os dados relacionados só quando você acessa o atributo. Isso parece conveniente, mas pode gerar o famoso **problema N+1**: uma query para buscar N registros, mais uma query EXTRA para cada um deles ao acessar um relacionamento — totalizando N+1 consultas em vez de 1 ou 2.

```python
# PROBLEMA: N+1 queries
usuarios = session.query(User).all()          # 1 query
for u in usuarios:
    print(len(u.reviews))                      # +1 query POR usuário (lazy)
# Para 100 usuários: 101 queries!
```

**Eager loading** já antecipa a busca dos relacionados na mesma operação:

```python
from sqlalchemy.orm import selectinload, joinedload

# selectinload: 2 queries no total (uma para users, uma "IN (...)" para reviews)
usuarios = session.query(User).options(selectinload(User.reviews)).all()

# joinedload: 1 query com JOIN (cuidado: pode duplicar linhas em listas grandes)
usuarios = session.query(User).options(joinedload(User.reviews)).all()
```

**Quando usar cada um**: `selectinload` é geralmente mais seguro para relacionamentos 1:N com muitos itens (evita duplicação de linhas do JOIN); `joinedload` é bom para relacionamentos 1:1 ou N:1, onde não há risco de multiplicar linhas.

## Sessões

A `Session` do SQLAlchemy gerencia a "unidade de trabalho": rastreia os objetos que você carrega e manipula, e agrupa as mudanças em uma transação enviada ao banco com `commit()`.

```python
with Session(engine) as session:
    novo_usuario = User(name="Ana", email="ana@ex.com")
    session.add(novo_usuario)
    session.commit()  # só aqui a mudança é persistida de fato
```

Se algo der errado antes do `commit()`, um `session.rollback()` desfaz as mudanças pendentes — essencial para manter consistência quando várias operações precisam acontecer "tudo ou nada".

## Alembic e migrations

Alembic gera e versiona scripts que alteram o schema do banco de forma incremental e reversível, mantendo o banco sincronizado com os modelos Python ao longo do tempo.

```bash
alembic revision --autogenerate -m "cria tabela reviews"
alembic upgrade head     # aplica migrations pendentes
alembic downgrade -1     # reverte a última migration
```

## Erros comuns

- **Não perceber o N+1** até o app estar lento em produção com dados reais (em desenvolvimento, com poucos registros, o problema é invisível).
- **Usar `joinedload` em uma lista grande com múltiplos relacionamentos** — pode multiplicar exponencialmente o número de linhas retornadas pelo JOIN.
- **Fazer `ALTER TABLE` manual direto no banco de produção**, sem migration — quebra a sincronia entre ambientes e não é reversível de forma limpa.
- **Esquecer `session.commit()`** e assumir que os dados foram salvos.

## Checklist rápido

- [ ] Sei explicar o que é o problema N+1 com um exemplo concreto
- [ ] Sei quando usar `selectinload` vs. `joinedload`
- [ ] Entendo a diferença entre 1:1, 1:N e N:N e sei modelar cada um
- [ ] Sei por que migrations versionadas são melhores que ALTER manual$md$,
  updated_at = now()
where slug = 'semana-1-persistencia-sqlalchemy';

update public.study_contents set
  content = $md$# Mensageria, Cache & Performance

## Objetivo desta aula

Entender três ferramentas centrais de performance em sistemas reais: cache (evitar recalcular o que já se sabe), mensageria (processar trabalho pesado fora do caminho crítico) e as métricas básicas para saber onde investigar quando algo está lento.

## Cache

### O que é e por que existe

Cache guarda o resultado de uma operação custosa (query pesada, chamada a API externa, cálculo complexo) para responder quase instantaneamente em acessos repetidos. Redis é a ferramenta mais comum para isso — um banco de dados em memória, extremamente rápido para leitura e escrita.

```python
import redis
r = redis.Redis()

def get_dashboard(user_id: int):
    chave = f"dashboard:{user_id}"
    cache = r.get(chave)
    if cache:
        return cache  # cache hit: resposta quase instantânea

    dados = calcular_dashboard_caro(user_id)  # cache miss: recalcula
    r.set(chave, dados, ex=300)  # guarda com expiração de 5 minutos
    return dados
```

### Cache hit, cache miss e TTL

- **Cache hit**: o dado foi encontrado no cache — resposta rápida, sem tocar a fonte original.
- **Cache miss**: o dado não estava no cache — precisa buscar na fonte e (geralmente) guardar para a próxima vez.
- **TTL** (Time To Live): por quanto tempo o dado permanece válido antes de expirar automaticamente — a forma mais simples de invalidação.

### O verdadeiro desafio: invalidação

Guardar dados em cache é fácil. O difícil é saber **quando invalidar** — ou seja, garantir que o cache não sirva dados desatualizados depois que a fonte original mudou. Estratégias comuns:

1. **TTL curto**: aceita-se que o dado fique "levemente desatualizado" por alguns minutos, em troca de simplicidade.
2. **Invalidação explícita**: ao alterar o dado original, o código explicitamente apaga a chave de cache correspondente (`r.delete(chave)`).
3. **Versionamento de chave**: em vez de invalidar, muda-se a chave (ex: incluir um número de versão), e chaves antigas simplesmente expiram sozinhas.

### Quando cachear (e quando não)

**Cachear**: dados lidos com frequência, caros de calcular, que não mudam a cada requisição (dashboards agregados, resultados de relatórios, respostas de APIs externas lentas).

**Não cachear (ou cachear com muito cuidado)**: dados que precisam estar sempre corretos no instante da leitura (saldo de uma transação financeira em andamento, por exemplo) — ali, a inconsistência de um cache mal invalidado pode causar problemas reais.

## Mensageria e processamento assíncrono

### Producer, consumer, broker e fila

Em um sistema de mensageria: um **producer** publica uma mensagem (ex: "processar pagamento X"), um **broker** (como RabbitMQ ou Redis) guarda essa mensagem em uma **fila**, e um ou mais **consumers** processam as mensagens da fila, um worker separado do processo que recebeu a requisição HTTP original.

### Celery na prática

```python
from celery import Celery

app = Celery("tasks", broker="redis://localhost:6379/0")

@app.task
def enviar_email_boas_vindas(usuario_id: int):
    usuario = buscar_usuario(usuario_id)
    enviar_email(usuario.email, "Bem-vindo!")

# Na rota da API, em vez de chamar a função diretamente:
@router.post("/register")
async def register(data: UserCreate):
    usuario = criar_usuario(data)
    enviar_email_boas_vindas.delay(usuario.id)  # enfileira, não bloqueia a resposta
    return {"ok": True}
```

O `.delay()` enfileira a tarefa para um worker Celery processar em background — o endpoint responde imediatamente ao cliente, sem esperar o email ser enviado.

### Retries e dead-letter queue

Filas de mensageria geralmente suportam **retry automático**: se o processamento de uma mensagem falhar (ex: API de email fora do ar), o broker tenta novamente depois de um tempo. Se falhar repetidamente, a mensagem pode ser movida para uma **dead-letter queue** — uma fila separada para mensagens problemáticas, permitindo investigação manual sem perder o registro nem travar o processamento das demais.

### Idempotência

Uma operação é **idempotente** quando pode ser executada múltiplas vezes com o mesmo resultado final, sem efeito colateral duplicado. Isso importa porque filas podem, em certos cenários (falha de rede, reprocessamento manual), entregar a mesma mensagem mais de uma vez. Um exemplo de tarefa NÃO idempotente perigosa: "cobrar R$ 50 do cartão" — se processada duas vezes, cobra R$ 100. A correção geralmente envolve verificar antes de agir (ex: "esse pagamento já foi processado? Se sim, ignore.").

## Performance: latência, throughput e onde procurar gargalos

- **Latência**: quanto tempo uma única requisição leva para ser respondida.
- **Throughput**: quantas requisições o sistema processa por unidade de tempo.
- Um sistema pode ter baixa latência mas baixo throughput (rápido para poucos, não escala) — são métricas complementares.

Ao investigar lentidão, os suspeitos mais comuns, nessa ordem, costumam ser: queries de banco sem índice adequado, N+1 queries (aula anterior), ausência de cache em um cálculo repetido, e falta de paralelismo/fila para tarefas pesadas bloqueando o caminho principal.

## Erros comuns

- Cachear um dado sem nenhuma estratégia de invalidação, criando bugs de "dado desatualizado" difíceis de rastrear.
- Colocar tarefas lentas (envio de email, geração de relatório) direto no caminho da requisição HTTP, deixando o usuário esperando sem necessidade.
- Ignorar idempotência em tarefas de fila que lidam com dinheiro, estoque ou qualquer efeito que não pode ser duplicado.
- Usar Celery para tudo, mesmo tarefas triviais que uma `BackgroundTasks` simples do FastAPI já resolveria sem a complexidade operacional extra de um broker.

## Checklist rápido

- [ ] Sei explicar cache hit/miss e pelo menos duas estratégias de invalidação
- [ ] Sei quando uma tarefa deveria ir para uma fila em vez de rodar na requisição
- [ ] Entendo por que idempotência importa em processamento assíncrono
- [ ] Sei diferenciar latência de throughput com um exemplo$md$,
  updated_at = now()
where slug = 'semana-1-mensageria-cache';

update public.study_contents set
  content = $md$# Testes Automatizados com Pytest

## Objetivo desta aula

Construir confiança no código através de testes bem estruturados — sabendo a diferença entre tipos de teste, usando fixtures e mocks corretamente, e testando os cenários de erro, não só o caminho feliz.

## Testes unitários vs. testes de integração

**Testes unitários** verificam uma unidade isolada de código (uma função, um método), geralmente sem tocar banco de dados ou rede real. **Testes de integração** verificam como várias partes trabalham juntas — por exemplo, uma rota completa da API, do request até a resposta, passando por um banco de teste de verdade.

```python
# Teste unitário: isolado, rápido, sem dependências externas
def calcular_desconto(preco: float, percentual: float) -> float:
    return preco * (1 - percentual / 100)

def test_calcular_desconto():
    assert calcular_desconto(100, 10) == 90
    assert calcular_desconto(100, 0) == 100
```

## Fixtures

Fixtures preparam um contexto reutilizável entre vários testes — um client de teste, uma sessão de banco limpa, dados iniciais.

```python
import pytest
from fastapi.testclient import TestClient
from main import app

@pytest.fixture
def client():
    return TestClient(app)

@pytest.fixture
def usuario_autenticado(client):
    client.post("/register", json={"email": "a@a.com", "password": "senha123"})
    resp = client.post("/login", json={"email": "a@a.com", "password": "senha123"})
    token = resp.json()["access_token"]
    return {"Authorization": f"Bearer {token}"}

def test_listar_revisoes(client, usuario_autenticado):
    response = client.get("/reviews", headers=usuario_autenticado)
    assert response.status_code == 200
```

Fixtures podem depender de outras fixtures (como `usuario_autenticado` depende de `client`), formando cadeias reutilizáveis que evitam repetir setup em cada teste.

## Mocking

Mocking substitui uma dependência real (API externa, envio de email, relógio do sistema) por uma versão controlada, isolando o teste de sistemas instáveis, lentos ou com efeitos colaterais reais.

```python
from unittest.mock import patch

@patch("app.services.enviar_email")
def test_cadastro_dispara_email(mock_email, client):
    client.post("/register", json={"email": "a@a.com", "password": "senha123"})
    mock_email.assert_called_once()  # confirma que o email seria enviado, sem enviar de verdade
    mock_email.assert_called_with("a@a.com", "Bem-vindo!")  # confirma os argumentos exatos
```

Sem o mock, o teste dependeria de um serviço de email real estar disponível e funcionando — tornando o teste lento, instável e potencialmente custoso (envio real de emails a cada execução da suíte).

## Status HTTP em testes de API

- **200 OK** — sucesso em uma leitura (GET).
- **201 Created** — sucesso ao criar um recurso (POST).
- **400 Bad Request** — requisição malformada.
- **401 Unauthorized** — não autenticado.
- **404 Not Found** — recurso não existe.
- **422 Unprocessable Entity** — dados não passaram na validação (comum com Pydantic/FastAPI).

```python
def test_criar_revisao_sem_titulo_falha(client, usuario_autenticado):
    response = client.post("/reviews", json={"minutes": 30}, headers=usuario_autenticado)
    assert response.status_code == 422  # título é obrigatório

def test_acessar_revisao_de_outro_usuario_falha(client, usuario_autenticado, outro_usuario_token):
    review = client.post("/reviews", json={"title": "X"}, headers=usuario_autenticado).json()
    response = client.get(f"/reviews/{review['id']}", headers=outro_usuario_token)
    assert response.status_code in (403, 404)  # não deve conseguir acessar
```

## Testando o caminho feliz E os casos de erro

Um erro muito comum é testar só que "tudo funciona quando os dados estão certos". Mas o valor real dos testes está em capturar como o sistema se comporta quando as coisas dão errado: dado ausente, tipo errado, usuário sem permissão, recurso inexistente. Um sistema bem testado tem, para cada endpoint importante, pelo menos: um teste de sucesso, um teste de validação (dado inválido) e um teste de autorização (acesso negado quando deveria ser negado).

## Estratégia de testes (pirâmide)

Uma boa estratégia combina: muitos testes unitários rápidos na base (segundos para rodar a suíte inteira), um número moderado de testes de integração no meio, e poucos testes end-to-end mais lentos no topo (simulando o fluxo completo de um usuário real). Essa distribuição equilibra velocidade de execução com confiança de que o sistema funciona de ponta a ponta.

## Erros comuns

- Testar só o `status_code`, sem verificar se o **conteúdo** da resposta está correto — um endpoint pode retornar 201 com dados errados e o teste passa mesmo assim.
- Não isolar testes: um teste que depende da ordem de execução de outro, ou que deixa dados "sujos" no banco de teste para o próximo teste.
- Mockar demais, a ponto do teste não verificar mais nada de real (testando o mock, não o comportamento do sistema).
- Ignorar testes de autorização — testar que um usuário A não acessa dados de um usuário B é tão importante quanto testar que A acessa os próprios dados.

## Checklist rápido

- [ ] Sei a diferença prática entre teste unitário e de integração
- [ ] Sei criar e encadear fixtures
- [ ] Sei quando e por que usar mock em vez de uma dependência real
- [ ] Testo status code E conteúdo da resposta, não só um dos dois
- [ ] Incluo testes de erro/autorização, não só o caminho feliz$md$,
  updated_at = now()
where slug = 'semana-1-testes-pytest';

update public.study_contents set
  content = $md$# HTML5 Semântico & Acessibilidade

## Objetivo desta aula

Construir páginas que comunicam sua estrutura corretamente — para leitores de tela, motores de busca e outros desenvolvedores — usando as tags certas para cada função, não `<div>` para tudo.

## Por que HTML semântico importa

Tags semânticas descrevem o **papel** do conteúdo, não só sua aparência visual. Isso tem três benefícios concretos: acessibilidade (leitores de tela anunciam a estrutura corretamente), SEO (motores de busca entendem melhor do que trata a página) e manutenibilidade (outro desenvolvedor entende a estrutura sem precisar ler classes CSS).

```html
<header>
  <nav>...</nav>
</header>
<main>
  <section>
    <h2>Artigos recentes</h2>
    <article>
      <h3>Título do post</h3>
      <p>Conteúdo...</p>
    </article>
  </section>
  <aside>Conteúdo relacionado</aside>
</main>
<footer>...</footer>
```

- **header**: cabeçalho da página ou de uma seção.
- **nav**: bloco de navegação principal.
- **main**: conteúdo principal e único da página (só deve haver um por página).
- **section**: agrupamento temático de conteúdo, geralmente com um heading.
- **article**: conteúdo independente, que faz sentido sozinho (um post, uma notícia, um card de produto).
- **aside**: conteúdo relacionado mas não essencial (barra lateral, anúncio, "veja também").
- **footer**: rodapé da página ou seção.

### Quando usar section vs. article vs. div

Regra prática: se o conteúdo faria sentido sendo extraído e republicado sozinho (um post de blog, um comentário), use `<article>`. Se é um agrupamento temático dentro da página (uma seção "Sobre nós"), use `<section>`. Se é só um contêiner de estilização sem significado semântico próprio, `<div>` continua sendo apropriado — o problema não é a `<div>` existir, é usá-la quando uma tag semântica se encaixaria melhor.

## Formulários acessíveis

Todo campo de formulário deve ter um `<label>` associado — leitores de tela usam isso para anunciar o propósito do campo, e clicar no texto do label foca automaticamente o input.

```html
<label for="email">Email</label>
<input id="email" type="email" required aria-describedby="email-hint" />
<p id="email-hint" class="hint">Usaremos para enviar a confirmação.</p>
```

`aria-describedby` conecta um texto de ajuda ao campo, que leitores de tela também anunciam. Isso é diferente de `placeholder`, que desaparece ao digitar e não é lido de forma confiável por todos os leitores de tela — placeholder complementa o label, nunca o substitui.

## Acessibilidade (a11y) na prática

Acessibilidade significa construir interfaces que qualquer pessoa consiga usar — incluindo quem usa leitor de tela, navega só por teclado, ou tem baixa visão/daltonismo. Pontos centrais:

- Contraste de cor adequado entre texto e fundo (existem ferramentas que calculam a razão de contraste automaticamente).
- Foco visível em elementos interativos ao navegar por Tab (nunca remover o `outline` de foco sem substituir por algo igualmente visível).
- Texto alternativo (`alt`) em imagens que carregam informação — imagens puramente decorativas podem ter `alt=""` vazio, para o leitor de tela pular.
- Hierarquia correta de headings (`h1` → `h2` → `h3`), sem pular níveis só por causa do tamanho visual desejado (isso é resolvido com CSS, não trocando a tag).

## SEO e a relação com semântica

Motores de busca leem a estrutura semântica para entender do que trata a página: um único `<h1>` claro, headings hierárquicos, `<nav>` identificando a navegação, `<meta name="description">` resumindo o conteúdo. Uma página toda feita de `<div>`s genéricas não dá pistas estruturais claras — o rastreador precisa "adivinhar" a partir do texto puro.

## DOM e ordem de carregamento

O **DOM** (Document Object Model) é a árvore de elementos que o navegador constrói a partir do HTML, e que o JavaScript manipula. O navegador processa o HTML de cima para baixo — por isso scripts que manipulam elementos costumam ficar no fim do `<body>`, ou usar o atributo `defer`, garantindo que o DOM já exista quando o script rodar.

```html
<head>
  <script src="app.js" defer></script>  <!-- roda só depois do HTML ser parseado -->
</head>
```

## Erros comuns

- Usar `<div onclick="...">` em vez de `<button>` para uma ação clicável — perde foco por teclado, semântica de "isso é um botão" e ativação por Enter/Espaço automaticamente.
- Pular níveis de heading só por causa do tamanho visual (usar `<h4>` porque "parece do tamanho certo", quebrando a hierarquia real da página).
- Depender só de cor para transmitir informação (ex: "campos em vermelho têm erro", sem nenhum texto ou ícone adicional) — invisível para quem tem daltonismo.
- Colocar `alt` genérico ou vazio em imagens que carregam informação real (ex: um gráfico), impedindo quem usa leitor de tela de entender o conteúdo.

## Checklist rápido

- [ ] Sei escolher a tag semântica certa em vez de `<div>` para cada situação
- [ ] Todo input do meu formulário tem `<label>` associado
- [ ] Sei explicar por que `alt=""` vazio é diferente de omitir o atributo
- [ ] Entendo por que scripts no fim do body (ou com `defer`) evitam bugs de DOM$md$,
  updated_at = now()
where slug = 'semana-2-html5-acessibilidade';

update public.study_contents set
  content = $md$# CSS3 Avançado & Layouts

## Objetivo desta aula

Entender como o navegador calcula tamanho e posição de elementos (Box Model, cascata, especificidade) e dominar os dois sistemas modernos de layout: Flexbox e Grid.

## Cascata e especificidade

CSS significa "Cascading Style Sheets" — quando várias regras se aplicam ao mesmo elemento, a **cascata** decide qual vence, considerando origem, especificidade e ordem no código. **Especificidade** é calculada por tipo de seletor:

| Seletor | Peso relativo |
|---|---|
| Estilo inline (`style="..."`) | Mais alto |
| ID (`#id`) | Alto |
| Classe, atributo, pseudo-classe (`.classe`, `[type]`, `:hover`) | Médio |
| Elemento (`div`, `p`) | Baixo |

```css
div { color: blue; }           /* especificidade baixa */
.destaque { color: red; }      /* especificidade média — esta vence */
#titulo { color: green; }      /* especificidade alta — esta venceria sobre as duas acima */
```

Entender isso evita a armadilha de usar `!important` para "forçar" um estilo — isso mascara o problema real (organização de CSS) em vez de resolvê-lo, e dificulta manutenção futura.

## Box Model

Todo elemento é uma caixa composta, nessa ordem: **conteúdo** → **padding** (espaço interno) → **border** (borda) → **margin** (espaço externo).

```css
.card {
  width: 200px;
  padding: 20px;
  border: 2px solid #ccc;
  margin-bottom: 12px;
  box-sizing: border-box;  /* padding e border passam a contar DENTRO do width */
}
```

Sem `box-sizing: border-box`, o tamanho final do elemento seria 200 + 20×2 (padding) + 2×2 (border) = 244px de largura real, não os 200px esperados. Por isso `border-box` é aplicado quase universalmente como reset padrão em projetos modernos.

## Display, Flexbox e Grid

`display` define o modelo de layout de um elemento (`block`, `inline`, `flex`, `grid`, `none`...).

### Flexbox — layout em uma dimensão

Flexbox organiza itens em uma única dimensão (linha OU coluna) — ideal para barras de navegação, alinhamento de itens, cards em fileira.

```css
.navbar {
  display: flex;
  justify-content: space-between;  /* espaço distribuído entre os itens */
  align-items: center;             /* centraliza verticalmente */
  gap: 16px;
}

.coluna {
  display: flex;
  flex-direction: column;
  gap: 8px;
}
```

`flex-grow`, `flex-shrink` e `flex-basis` controlam como os itens crescem/encolhem para preencher o espaço disponível — útil para, por exemplo, fazer um item ocupar todo o espaço restante (`flex: 1`).

### Grid — layout em duas dimensões

Grid controla linhas e colunas simultaneamente — ideal para estruturar a página inteira ou um layout de cards responsivo.

```css
.pagina {
  display: grid;
  grid-template-columns: 250px 1fr;  /* sidebar fixa + conteúdo flexível */
  grid-template-rows: 64px 1fr;      /* header fixo + resto */
  min-height: 100vh;
}

.cards {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 16px;
}
```

`repeat(auto-fill, minmax(200px, 1fr))` é um padrão muito usado: cria quantas colunas de no mínimo 200px couberem no espaço disponível, distribuindo o espaço restante igualmente — um grid responsivo sem precisar de media queries.

### Quando usar cada um

Regra prática: se você está alinhando itens em uma linha ou coluna (menu, lista de botões), use Flexbox. Se está estruturando uma área com linhas E colunas ao mesmo tempo (o layout geral da página, uma grade de cards), use Grid. Os dois podem — e geralmente devem — ser combinados no mesmo projeto.

## Position

- `static` (padrão): segue o fluxo normal do documento.
- `relative`: desloca o elemento em relação à sua própria posição original, sem tirá-lo do fluxo.
- `absolute`: posiciona em relação ao ancestral posicionado mais próximo (`position` diferente de `static`); se nenhum existir, usa o `<html>`.
- `fixed`: fixo em relação à janela do navegador, ignora o scroll.
- `sticky`: comporta-se como `relative` até atingir um limite de scroll, aí "gruda" como `fixed`.

```css
.modal-overlay {
  position: fixed;
  inset: 0;  /* atalho para top/right/bottom/left: 0 */
}

.card {
  position: relative;  /* necessário para o badge absoluto funcionar corretamente */
}
.badge {
  position: absolute;
  top: -8px;
  right: -8px;
}
```

## Responsividade com Media Queries

```css
.sidebar { display: none; }

@media (min-width: 1024px) {
  .sidebar { display: block; }
}
```

A abordagem recomendada é **mobile-first**: escrever o estilo base para telas pequenas, e usar `min-width` para adicionar/ajustar estilos conforme a tela cresce — em vez do caminho inverso.

## Erros comuns

- Esquecer `position: relative` no elemento pai ao usar `position: absolute` no filho, fazendo o filho se posicionar em relação ao `<html>` em vez do container esperado.
- Usar `!important` para resolver conflitos de especificidade em vez de reorganizar os seletores.
- Misturar `px` fixo em larguras que deveriam ser flexíveis, quebrando a responsividade.
- Usar `joinedload`-style thinking em CSS: tentar resolver tudo com Flexbox quando Grid resolveria de forma mais direta (ou vice-versa).

## Checklist rápido

- [ ] Sei calcular por que um elemento ficou maior que o `width` definido
- [ ] Sei decidir entre Flexbox e Grid para um layout específico
- [ ] Entendo a diferença entre `absolute` e `fixed` na prática
- [ ] Escrevo CSS mobile-first, com `min-width` para telas maiores$md$,
  updated_at = now()
where slug = 'semana-2-css3-layouts';

update public.study_contents set
  content = $md$# Tailwind CSS & Responsividade

## Objetivo desta aula

Usar Tailwind de forma produtiva e consistente — entendendo a filosofia utility-first, a abordagem mobile-first dos breakpoints, e quando extrair um componente em vez de duplicar classes.

## Utility-first: a filosofia por trás do Tailwind

Em vez de escrever CSS customizado com nomes de classe semânticos (`.card-title`), você compõe classes utilitárias pequenas e específicas diretamente na marcação (`flex`, `px-4`, `text-sm`, `rounded-xl`). Isso elimina a necessidade de inventar nomes de classe e manter arquivos CSS separados sincronizados com o HTML/JSX.

```html
<button class="rounded-xl bg-brand-600 px-4 py-2.5 text-sm font-semibold text-white hover:bg-brand-700 disabled:opacity-60">
  Salvar
</button>
```

### Vantagens e trade-offs

**Vantagens**: consistência automática (a escala de espaçamento/cores é predefinida), não precisa "caçar" onde um estilo está definido, refatoração de HTML não deixa CSS órfão.

**Trade-offs**: HTML/JSX fica mais verboso, e sem organização (componentização) o mesmo conjunto de classes acaba duplicado em vários lugares.

## Mobile-first e breakpoints

Tailwind é mobile-first por padrão: classes sem prefixo valem para qualquer tamanho de tela; prefixos (`sm:`, `md:`, `lg:`, `xl:`, `2xl:`) aplicam a partir daquele breakpoint **para cima**.

```html
<div class="flex flex-col gap-4 lg:flex-row lg:gap-8">
  <!-- empilhado no mobile; lado a lado, com mais espaço, a partir de "lg" -->
</div>

<h1 class="text-xl sm:text-2xl lg:text-4xl">
  <!-- cresce progressivamente conforme a tela aumenta -->
</h1>
```

| Prefixo | Largura mínima |
|---|---|
| `sm:` | 640px |
| `md:` | 768px |
| `lg:` | 1024px |
| `xl:` | 1280px |
| `2xl:` | 1536px |

## Grid e Flexbox no Tailwind

As mesmas ideias do CSS puro, como classes utilitárias:

```html
<div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
  <!-- 1 coluna no mobile, 2 no tablet, 3 no desktop -->
</div>

<div class="flex items-center justify-between">
  <!-- alinhamento horizontal, espaço distribuído -->
</div>
```

## Escala consistente de espaçamento e tipografia

Tailwind usa uma escala numérica para espaçamento (`p-1` = 0.25rem, `p-2` = 0.5rem, até `p-96`) e nomes para tipografia (`text-xs` até `text-9xl`). Isso evita que cada desenvolvedor escolha valores arbitrários (`padding: 13px`), mantendo consistência visual no projeto inteiro sem esforço extra de coordenação.

## Estados com classes condicionais

```html
<input class="border border-slate-200 focus:border-brand-500 focus:ring-2 focus:ring-brand-100 disabled:opacity-60 disabled:cursor-not-allowed" />

<div class="dark:bg-slate-900 dark:text-slate-100">
  <!-- estilos diferentes em dark mode, sem JavaScript -->
</div>
```

Prefixos de estado (`hover:`, `focus:`, `disabled:`, `dark:`, `group-hover:`) aplicam estilos condicionalmente direto na marcação, sem precisar de CSS separado ou lógica em JavaScript para alternar classes.

## Quando extrair um componente

Quando a mesma combinação longa de classes se repete em vários lugares (ex: o estilo de todos os botões primários do app), é hora de extrair um componente reutilizável (`<Button variant="primary">`) em vez de copiar a string de classes repetidamente. Isso concentra a "fonte da verdade" visual em um lugar — mudar o estilo do botão primário vira uma alteração em um arquivo, não uma busca-e-substitui em dezenas de arquivos.

```jsx
// Em vez de repetir isso em 20 lugares diferentes:
<button className="rounded-xl bg-brand-600 px-4 py-2.5 text-sm font-semibold text-white hover:bg-brand-700">

// Extraia um componente:
function Button({ children, ...props }) {
  return (
    <button className="rounded-xl bg-brand-600 px-4 py-2.5 text-sm font-semibold text-white hover:bg-brand-700" {...props}>
      {children}
    </button>
  );
}
```

## Erros comuns

- Escrever a versão desktop primeiro e "consertar" para mobile depois — vai contra a filosofia mobile-first do próprio framework e geralmente resulta em mais media queries do que o necessário.
- Duplicar uma combinação longa de classes em dezenas de componentes em vez de extrair um componente reutilizável.
- Usar valores arbitrários (`w-[327px]`) com frequência, fugindo da escala consistente do design system sem necessidade real.
- Esquecer estados de foco (`focus:`) em elementos interativos, prejudicando navegação por teclado.

## Checklist rápido

- [ ] Escrevo a versão mobile (sem prefixo) primeiro, depois adiciono `sm:`/`lg:` conforme necessário
- [ ] Sei quando extrair um componente em vez de duplicar classes
- [ ] Uso classes de estado (`hover:`, `focus:`, `disabled:`) em vez de JS para isso
- [ ] Entendo a diferença entre a escala consistente do Tailwind e valores arbitrários$md$,
  updated_at = now()
where slug = 'semana-2-tailwind-responsividade';

update public.study_contents set
  content = $md$# Core do JavaScript

## Objetivo desta aula

Consolidar os fundamentos que sustentam todo o resto do JavaScript moderno (e o React, na Semana 3): declaração de variáveis, escopo, closures e manipulação do DOM.

## var, let e const

```javascript
console.log(x); // undefined (hoisting: var é "içada", mas sem valor ainda)
var x = 10;

console.log(y); // ReferenceError: y ainda não foi declarada neste ponto
let y = 10;

const PI = 3.14;
PI = 3; // TypeError: não é possível reatribuir uma const
```

- **`var`**: escopo de **função**, sofre hoisting completo. Evite em código novo.
- **`let`**: escopo de **bloco** (`{ }`), pode ser reatribuída.
- **`const`**: escopo de bloco, **não pode ser reatribuída** — mas se for um objeto/array, o conteúdo interno ainda pode ser alterado.

```javascript
const usuario = { nome: "Ana" };
usuario.nome = "Beatriz";  // válido: o conteúdo do objeto mudou, a referência não
usuario = {};              // TypeError: isso reatribuiria a variável
```

### Por que `var` causa bugs em loops

```javascript
// Problema: todas as 3 funções compartilham a MESMA variável i (escopo de função)
for (var i = 0; i < 3; i++) {
  setTimeout(() => console.log(i), 0);
}
// Imprime: 3, 3, 3 (todas leem o valor final de i)

// Solução: let cria uma nova i a cada iteração (escopo de bloco)
for (let i = 0; i < 3; i++) {
  setTimeout(() => console.log(i), 0);
}
// Imprime: 0, 1, 2 (o esperado)
```

## Scope (escopo)

Escopo define onde uma variável é visível. Com `let`/`const`, variáveis declaradas dentro de um bloco (`if`, `for`, função) só existem ali — diferente de `var`, que "vaza" para fora do bloco (mas não da função).

## Closures

Uma closure acontece quando uma função "lembra" e continua acessando variáveis do escopo onde foi criada, mesmo depois que esse escopo já terminou de executar.

```javascript
function criarContador() {
  let contagem = 0;
  return {
    incrementar: () => ++contagem,
    valor: () => contagem,
  };
}

const contador = criarContador();
contador.incrementar();
contador.incrementar();
console.log(contador.valor()); // 2

const outroContador = criarContador();
console.log(outroContador.valor()); // 0 — cada closure tem seu próprio estado isolado
```

Closures são a base de padrões extremamente comuns: contadores privados, debounce/throttle, memoização, e — de forma direta — os hooks do React (`useState` funciona graças a closures capturando o estado entre renderizações).

### Debounce: um uso prático de closure

```javascript
function debounce(fn, delay) {
  let timer;
  return (...args) => {
    clearTimeout(timer);
    timer = setTimeout(() => fn(...args), delay);
  };
}

const buscarComDebounce = debounce((termo) => buscarNaAPI(termo), 300);
input.addEventListener("input", (e) => buscarComDebounce(e.target.value));
// Só dispara a busca 300ms depois que o usuário parar de digitar
```

## DOM, querySelector e eventos

```javascript
const botao = document.querySelector("#salvar");         // primeiro elemento correspondente
const todosOsCards = document.querySelectorAll(".card"); // todos os elementos correspondentes

botao.addEventListener("click", (evento) => {
  evento.preventDefault();  // impede comportamento padrão (ex: submit de formulário)
  botao.textContent = "Salvo!";
  botao.classList.add("salvo");
});
```

### Event delegation

Em vez de adicionar um listener em cada item de uma lista (custoso se a lista for grande ou mudar dinamicamente), aproveita-se que eventos "borbulham" (propagam) para o elemento pai:

```javascript
document.querySelector("#lista").addEventListener("click", (evento) => {
  if (evento.target.matches(".item-excluir")) {
    const item = evento.target.closest(".item");
    item.remove();
  }
});
// Um único listener no pai cobre todos os itens, presentes e futuros
```

## Erros comuns

- Usar `var` em código novo, sujeito a bugs de escopo em loops e condicionais.
- Esquecer que `const` não torna objetos/arrays imutáveis — só impede reatribuir a variável em si.
- Adicionar um listener a cada item de uma lista dinâmica em vez de usar event delegation, gerando vazamento de memória quando itens são removidos sem remover o listener.
- Não usar `debounce`/`throttle` em eventos de alta frequência (scroll, resize, input de busca), sobrecarregando o navegador com execuções desnecessárias.

## Checklist rápido

- [ ] Sei explicar por que `var` em loops com `setTimeout` causa bugs
- [ ] Consigo escrever uma closure e explicar por que ela "lembra" o estado
- [ ] Sei usar event delegation para listas dinâmicas
- [ ] Sei quando `const` é suficiente e quando `let` é necessário$md$,
  updated_at = now()
where slug = 'semana-2-core-javascript';

update public.study_contents set
  content = $md$# JavaScript Assíncrono

## Objetivo desta aula

Dominar os métodos funcionais de array mais usados no dia a dia, entender como o Event Loop prioriza microtasks e macrotasks, e escrever código assíncrono robusto com tratamento de erro adequado.

## Métodos funcionais de array

Esses métodos percorrem um array sem alterá-lo (não mutam), retornando um novo resultado — a base de um estilo de código mais previsível e testável.

```javascript
const numeros = [1, 2, 3, 4, 5];

numeros.map(n => n * 2);              // [2, 4, 6, 8, 10] — transforma cada item
numeros.filter(n => n % 2 === 0);     // [2, 4] — mantém só os que passam no teste
numeros.reduce((soma, n) => soma + n, 0);  // 15 — acumula um único valor
numeros.find(n => n > 3);             // 4 — primeiro item que satisfaz a condição
numeros.some(n => n > 4);             // true — existe pelo menos um?
numeros.every(n => n > 0);            // true — todos satisfazem?
numeros.forEach(n => console.log(n)); // sem retorno, só efeito colateral
```

### Encadeando métodos

```javascript
const revisoesPendentes = revisoes
  .filter(r => !r.completed)
  .map(r => ({ ...r, atrasada: new Date(r.data) < new Date() }))
  .sort((a, b) => new Date(a.data) - new Date(b.data));
```

Encadear é legível, mas cada método percorre o array inteiro — para arrays muito grandes (dezenas de milhares de itens) e código sensível a performance, um único loop manual pode ser mais eficiente. Na prática, isso raramente importa até haver um gargalo medido de verdade.

## Event Loop: microtasks e macrotasks

O JavaScript é single-threaded, mas lida com assincronismo através do **Event Loop**. Tarefas assíncronas entram em filas diferentes: **microtasks** (callbacks de Promises, `queueMicrotask`) têm prioridade sobre **macrotasks** (`setTimeout`, eventos de I/O, eventos de UI) — todas as microtasks pendentes são processadas antes da próxima macrotask.

```javascript
console.log("1");
setTimeout(() => console.log("2 (macrotask)"), 0);
Promise.resolve().then(() => console.log("3 (microtask)"));
console.log("4");

// Ordem real de execução: 1, 4, 3, 2
// Mesmo com delay 0, o setTimeout (macrotask) espera todas as microtasks pendentes
```

Entender essa ordem evita surpresas ao depurar código que mistura Promises com `setTimeout`.

## Promise

Uma `Promise` representa um valor que estará disponível no futuro — em sucesso (`resolve`) ou erro (`reject`).

```javascript
function buscarComTimeout(url, ms) {
  return Promise.race([
    fetch(url),
    new Promise((_, reject) => setTimeout(() => reject(new Error("Timeout")), ms)),
  ]);
}
```

`Promise.all` espera todas resolverem (ou falha no primeiro erro); `Promise.allSettled` espera todas terminarem, sucesso ou erro, sem interromper as demais; `Promise.race` resolve/rejeita assim que a primeira Promise terminar.

## async/await e tratamento de erro robusto

```javascript
async function carregarRevisoes() {
  try {
    const res = await fetch("/api/reviews");
    if (!res.ok) {
      throw new Error(`Erro HTTP ${res.status}`);
    }
    return await res.json();
  } catch (erro) {
    console.error("Não foi possível carregar revisões:", erro);
    return []; // valor de fallback, para a UI não quebrar
  }
}
```

Pontos essenciais de um tratamento de erro completo:

1. **Verificar `response.ok`** antes de fazer parsing — `fetch` só rejeita a Promise em falha de rede, NÃO em respostas HTTP de erro (404, 500). Um `fetch` para uma URL que retorna 500 ainda "resolve" a Promise normalmente.
2. **Sempre ter um `try/catch`** ao redor de código assíncrono que pode falhar.
3. **Decidir o que fazer no erro**: propagar para quem chamou, retornar um valor de fallback, ou mostrar uma mensagem ao usuário — nunca deixar a exceção "sumir" silenciosamente em um catch vazio.

### Executando promessas em paralelo corretamente

```javascript
// Lento: sequencial, uma espera depois da outra
const usuario = await buscarUsuario(id);
const revisoes = await buscarRevisoes(id);

// Rápido: as duas buscas acontecem ao mesmo tempo
const [usuario, revisoes] = await Promise.all([
  buscarUsuario(id),
  buscarRevisoes(id),
]);
```

## Erros comuns

- Assumir que `fetch` rejeita em respostas de erro HTTP (404, 500) — ele só rejeita em falha de rede real; é preciso checar `response.ok` manualmente.
- Encadear `await` sequencialmente quando as operações são independentes e poderiam rodar em paralelo com `Promise.all`.
- Catch vazio (`catch (e) {}`) escondendo erros reais, dificultando debug depois.
- Esquecer que `map`/`filter`/`reduce` retornam um NOVO array — tentar usá-los para mutar o original não funciona como esperado.

## Checklist rápido

- [ ] Sei explicar por que microtasks rodam antes de macrotasks com um exemplo
- [ ] Sei quando usar `Promise.all` para paralelizar chamadas independentes
- [ ] Todo `fetch` no meu código verifica `response.ok` antes de processar a resposta
- [ ] Nunca deixo um `catch` vazio sem pelo menos logar o erro$md$,
  updated_at = now()
where slug = 'semana-2-javascript-assincrono';

update public.study_contents set
  content = $md$# Fundamentos do React

## Objetivo desta aula

Entender como o React realmente funciona por baixo — Virtual DOM, reconciliation — e dominar o fluxo unidirecional de dados via props e estado, a base para tudo que vem depois (hooks, Context, integração com API).

## Virtual DOM e Reconciliation

O React mantém uma representação em memória da UI (o **Virtual DOM**). Quando o estado muda, o React calcula a diferença entre a versão anterior e a nova (**reconciliation**, usando um algoritmo de "diffing") e atualiza no DOM real **só o que mudou** — muito mais rápido do que recriar a página inteira a cada mudança.

```jsx
// Antes: <p>Contagem: 0</p>
// Depois de um clique: <p>Contagem: 1</p>
// O React atualiza SÓ o texto do nó, não recria o <p> inteiro
```

## JSX

JSX é uma extensão de sintaxe que permite escrever marcação parecida com HTML dentro do JavaScript, compilada para chamadas de função (`React.createElement`).

```jsx
function Saudacao({ nome }) {
  return <h1>Olá, {nome}!</h1>;
  // Compilado para: React.createElement('h1', null, 'Olá, ', nome, '!')
}
```

Dentro de `{ }`, qualquer expressão JavaScript válida pode ser usada — variáveis, chamadas de função, operadores ternários. Estruturas como `if`/`for` não funcionam diretamente dentro do JSX (são statements, não expressões) — por isso o padrão é usar `.map()` para listas e ternário/`&&` para renderização condicional.

```jsx
function Lista({ itens }) {
  if (itens.length === 0) return <p>Nenhum item.</p>;  // if fica FORA do JSX
  return (
    <ul>
      {itens.map(item => <li key={item.id}>{item.nome}</li>)}
    </ul>
  );
}
```

## Componentes, props e o fluxo unidirecional

Componentes são funções que recebem **props** (do componente pai) e retornam JSX. O fluxo de dados é **unidirecional**: sempre de pai para filho.

```jsx
function Card({ titulo, children }) {
  return (
    <div className="card">
      <h2>{titulo}</h2>
      {children}
    </div>
  );
}

function Pagina() {
  return (
    <Card titulo="Progresso">
      <p>60% concluído</p>
    </Card>
  );
}
```

`children` é uma prop especial que representa o conteúdo passado entre as tags de abertura e fechamento do componente — muito usado para componentes "container" (Card, Modal, Layout) que não sabem antecipadamente o que vão renderizar dentro.

### Como um filho "avisa" o pai (comunicação de baixo para cima)

Já que dados só fluem de cima para baixo via props, a forma idiomática de um filho comunicar algo ao pai é o pai passar uma **função callback** como prop:

```jsx
function ListaDeTarefas({ tarefas, onConcluir }) {
  return (
    <ul>
      {tarefas.map(t => (
        <li key={t.id}>
          {t.titulo}
          <button onClick={() => onConcluir(t.id)}>Concluir</button>
        </li>
      ))}
    </ul>
  );
}

function Pagina() {
  const [tarefas, setTarefas] = useState([...]);
  function handleConcluir(id) {
    setTarefas(prev => prev.map(t => t.id === id ? { ...t, feito: true } : t));
  }
  return <ListaDeTarefas tarefas={tarefas} onConcluir={handleConcluir} />;
}
```

## Estado e imutabilidade

Estado é dado interno que, quando alterado, faz o componente re-renderizar (`useState`). O React espera que você **nunca mute o estado diretamente** — sempre crie uma nova referência.

```jsx
// ERRADO: muta o array original, o React pode não perceber a mudança
function adicionar(item) {
  lista.push(item);
  setLista(lista); // mesma referência — React pode pular a re-renderização
}

// CERTO: cria uma nova referência
function adicionar(item) {
  setLista(prev => [...prev, item]);
}

// Para objetos, o mesmo princípio:
setUsuario(prev => ({ ...prev, nome: "Novo nome" }));
```

### Por que isso importa tecnicamente

O React usa comparação de referência (`Object.is`) para decidir se um valor mudou. Se você mutar o objeto original e passar a mesma referência para `setState`, o React pode concluir "nada mudou" e pular a re-renderização — um bug sutil e frustrante de depurar, porque o dado *parece* ter mudado quando você inspeciona no console (já que o objeto original foi de fato alterado em memória).

## Fluxo de dados e renderização

Sempre que o estado ou as props de um componente mudam, o React re-renderiza aquele componente e, por padrão, todos os seus filhos — mesmo que as props dos filhos não tenham mudado. Isso é intencional (simplicidade do modelo mental) mas pode ser otimizado quando necessário com `React.memo`, `useMemo` e `useCallback` (temas da próxima aula).

## Erros comuns

- Mutar estado diretamente (`.push`, `.splice`, atribuição direta de propriedade) em vez de criar uma nova referência.
- Usar o índice do array como `key` em listas que podem reordenar ou filtrar, causando bugs de estado "grudado" no item errado.
- Esquecer que `children` é só mais uma prop — tentar acessá-la de formas não convencionais quando `props.children` já resolve.
- Tentar usar `if`/`for` diretamente dentro do JSX (statements não são expressões válidas ali).

## Checklist rápido

- [ ] Sei explicar reconciliation com minhas próprias palavras
- [ ] Sei por que mutar estado diretamente é um problema, com um exemplo
- [ ] Sei implementar comunicação de filho para pai via callback
- [ ] Uso um identificador estável (não o índice) como `key` em listas dinâmicas$md$,
  updated_at = now()
where slug = 'semana-3-fundamentos-react';

update public.study_contents set
  content = $md$# Hooks Avançados

## Objetivo desta aula

Usar `useEffect` corretamente (incluindo cleanup), e saber quando `useMemo`/`useCallback` realmente ajudam — evitando tanto o "efeito colateral esquecido" quanto a memoização desnecessária.

## useEffect e efeitos colaterais

`useEffect` executa código fora do fluxo de renderização — chamadas de API, subscriptions, manipulação direta do DOM, timers. Ele roda **depois** que o componente renderiza.

```jsx
useEffect(() => {
  fetchReviews(userId).then(setReviews);
}, [userId]); // roda de novo só quando userId mudar
```

### O array de dependências, com precisão

| Array de dependências | Quando o efeito roda |
|---|---|
| Omitido (sem array) | A cada renderização — raramente é o que se quer |
| `[]` (vazio) | Só uma vez, na montagem do componente |
| `[valor]` | Na montagem, e sempre que `valor` mudar entre renderizações |

Um erro sutil e comum: declarar `[userId]` mas usar dentro do efeito uma variável `filtro` que também deveria disparar a reexecução — o efeito passa a rodar com um `filtro` desatualizado ("stale") sempre que ele mudar sem `userId` mudar junto. O linter de hooks do React geralmente aponta dependências faltando exatamente para prevenir isso.

## Cleanup: por que e quando

Se o efeito cria algo que "continua vivo" além da execução da função (um timer, uma subscription, um event listener), é preciso desfazer isso — seja quando o componente é desmontado, seja antes do efeito rodar de novo.

```jsx
useEffect(() => {
  const id = setInterval(() => tick(), 1000);
  return () => clearInterval(id); // cleanup: roda antes do próximo efeito e ao desmontar
}, []);

useEffect(() => {
  function handleResize() { setLargura(window.innerWidth); }
  window.addEventListener("resize", handleResize);
  return () => window.removeEventListener("resize", handleResize);
}, []);
```

Sem cleanup, cada montagem/desmontagem do componente (por exemplo, navegar para a tela e voltar várias vezes) acumula listeners/timers duplicados — um vazamento de memória e uma fonte de bugs difíceis de rastrear (código "duplicado" rodando sem motivo aparente).

### Cleanup em requisições assíncronas (evitar "setState em componente desmontado")

```jsx
useEffect(() => {
  let cancelado = false;
  fetchReviews(userId).then(data => {
    if (!cancelado) setReviews(data); // só atualiza se o componente ainda existir
  });
  return () => { cancelado = true; };
}, [userId]);
```

Isso evita o aviso clássico "Can't perform a React state update on an unmounted component" quando uma requisição demora mais que o tempo que o usuário passou naquela tela.

## useMemo: memoizando valores calculados

```jsx
const revisoesConcluidas = useMemo(
  () => reviews.filter(r => r.completed),
  [reviews]
);
```

`useMemo` guarda em cache o resultado de um cálculo, recalculando só quando as dependências mudam. **Vale a pena** quando o cálculo é genuinamente custoso (filtrar/ordenar listas grandes, cálculos matemáticos pesados) — para operações triviais, o overhead de gerenciar a memoização pode superar o ganho.

## useCallback: memoizando funções

```jsx
const handleSalvar = useCallback(() => {
  salvarRevisao(id);
}, [id]);

// Útil especificamente quando passado para um filho memoizado:
const ListaMemo = React.memo(Lista);
<ListaMemo onSalvar={handleSalvar} items={items} />
```

Sem `useCallback`, uma nova função é criada a cada renderização do componente pai — o que invalidaria a memoização de `React.memo` no filho (já que a prop `onSalvar` "mudaria" a cada vez, mesmo fazendo a mesma coisa). `useCallback` só faz diferença real quando combinado com `React.memo` no componente que recebe a função.

## Quando memoização NÃO ajuda

Aplicar `useMemo`/`useCallback` em todo lugar, "por precaução", tem um custo real: a cada renderização o React ainda precisa comparar o array de dependências, e o código fica mais difícil de ler. Memoização vale a pena especificamente quando: (1) o cálculo é comprovadamente caro, ou (2) evita re-renderização desnecessária de um componente filho memoizado que, sem isso, re-renderizaria com frequência real.

```jsx
// Desnecessário: somar dois números não é um cálculo caro
const soma = useMemo(() => a + b, [a, b]); // overhead sem benefício real
```

## Erros comuns

- Omitir dependências reais do `useEffect` para "fazer o aviso do linter sumir", introduzindo bugs de dados desatualizados.
- Esquecer cleanup em timers, subscriptions e listeners.
- Fazer `setState` depois de uma requisição assíncrona sem verificar se o componente ainda está montado.
- Memoizar tudo indiscriminadamente, sem medir se há um ganho real de performance.

## Checklist rápido

- [ ] Meus `useEffect` sempre declaram TODAS as dependências usadas dentro deles
- [ ] Todo efeito que cria um timer/listener/subscription tem cleanup
- [ ] Sei explicar quando `useMemo`/`useCallback` realmente fazem diferença
- [ ] Trato o caso de uma requisição assíncrona terminar depois do componente desmontar$md$,
  updated_at = now()
where slug = 'semana-3-hooks-avancados';

update public.study_contents set
  content = $md$# Estado Global & Next.js

## Objetivo desta aula

Resolver o "prop drilling" com Context API de forma consciente sobre seus limites, e entender o modelo de Server/Client Components do App Router do Next.js.

## Context API: o problema que ela resolve

Quando várias partes distantes da árvore de componentes precisam do mesmo dado (usuário autenticado, tema, idioma), passar props manualmente por cada nível intermediário ("**prop drilling**") vira insustentável — componentes no meio do caminho recebem e repassam props que nem usam diretamente.

```jsx
const AuthContext = createContext(null);

function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const login = async (email, senha) => {
    const usuario = await autenticar(email, senha);
    setUser(usuario);
  };
  return (
    <AuthContext.Provider value={{ user, login }}>
      {children}
    </AuthContext.Provider>
  );
}

function Perfil() {
  const { user } = useContext(AuthContext); // lê direto, sem prop drilling
  return <p>{user?.name}</p>;
}
```

### O limite real da Context API

Toda mudança no `value` passado ao Provider re-renderiza **todos** os componentes que consomem aquele Context — mesmo os que usam só uma parte do valor. Para estado que muda com pouca frequência (usuário logado, tema), isso não é problema. Para estado de alta frequência (por exemplo, a posição do mouse, ou o texto de um campo de busca digitado letra a letra), Context pode causar re-renderizações excessivas — nesses casos, soluções mais granulares (estado local, ou bibliotecas de state management com seletores) tendem a performar melhor.

## Next.js e o App Router

Next.js adiciona ao React: roteamento baseado em arquivos, renderização no servidor, e otimizações de build. O **App Router** (pasta `app/`) organiza rotas por pastas, cada uma com um `page.tsx`.

```
app/
  layout.tsx          <- layout raiz, envolve tudo
  page.tsx            <- rota "/"
  contents/
    page.tsx          <- rota "/contents"
    [slug]/
      page.tsx        <- rota dinâmica "/contents/qualquer-coisa"
```

## Server Components vs. Client Components

No App Router, componentes são **Server Components** por padrão: renderizam no servidor, não enviam JavaScript extra ao navegador, e podem acessar banco de dados ou arquivos diretamente. Um componente vira **Client Component** ao declarar `"use client"` no topo do arquivo.

```jsx
// Server Component (padrão) — pode buscar dados direto de um banco
async function ListaDeAulas() {
  const aulas = await db.query("SELECT * FROM lessons");
  return <ul>{aulas.map(a => <li key={a.id}>{a.title}</li>)}</ul>;
}
```

```jsx
"use client"; // necessário para usar hooks e interatividade no navegador
import { useState } from "react";

export function Contador() {
  const [n, setN] = useState(0);
  return <button onClick={() => setN(n + 1)}>{n}</button>;
}
```

### Quando um componente PRECISA ser Client Component

Sempre que usar: `useState`, `useEffect`, `useContext`, event handlers de interação (`onClick`, `onChange`), ou qualquer API exclusiva do navegador (`window`, `localStorage`). Componentes puramente de exibição de dados (que só recebem props e renderizam) geralmente podem continuar como Server Components.

### Composição: misturando os dois

Um padrão comum é ter um Server Component pai que busca os dados, e passa esses dados como props para um Client Component filho, responsável só pela parte interativa:

```jsx
// page.tsx (Server Component) — busca os dados
async function Pagina() {
  const revisoes = await buscarRevisoes();
  return <ListaInterativa revisoesIniciais={revisoes} />;
}

// ListaInterativa.tsx (Client Component) — cuida da interatividade
"use client";
function ListaInterativa({ revisoesIniciais }) {
  const [revisoes, setRevisoes] = useState(revisoesIniciais);
  // ... lógica de filtro, ordenação, etc.
}
```

## Layouts e rotas dinâmicas

Um `layout.tsx` envolve várias páginas com uma UI compartilhada (sidebar, header) **sem perder o estado dela** ao navegar entre páginas — diferente de renderizar a sidebar dentro de cada `page.tsx` separadamente, o que a remontaria a cada navegação.

Rotas dinâmicas usam colchetes no nome da pasta: `app/contents/[slug]/page.tsx` captura qualquer valor de `slug` presente na URL, disponível como parâmetro na página.

## Erros comuns

- Marcar componentes inteiros como Client Component "por garantia", perdendo os benefícios de performance dos Server Components sem necessidade real.
- Usar Context para estado de alta frequência de mudança, causando re-renderizações em cascata desnecessárias.
- Tentar usar `useState` ou `onClick` em um Server Component sem a diretiva `"use client"`, o que gera erro.
- Recriar a sidebar dentro de cada página em vez de usar um `layout.tsx` compartilhado, perdendo estado (ex: um menu expandido) a cada navegação.

## Checklist rápido

- [ ] Sei quando Context é a ferramenta certa e quando não é
- [ ] Sei decidir se um componente deve ser Server ou Client Component
- [ ] Entendo como compor Server Components (dados) com Client Components (interatividade)
- [ ] Sei o que um `layout.tsx` resolve que repetir a UI em cada página não resolveria$md$,
  updated_at = now()
where slug = 'semana-3-estado-global-nextjs';

update public.study_contents set
  content = $md$# TypeScript

## Objetivo desta aula

Usar tipagem estática para pegar erros antes da execução, dominar os utility types mais usados no dia a dia (`Partial`, `Pick`, `Omit`), e aplicar generics e type narrowing em código real.

## Interfaces e type aliases

Ambos descrevem o formato de um objeto. `interface` pode ser reaberta/estendida (`extends`); `type` é mais flexível para uniões e tipos compostos. Para props de componente, os dois funcionam bem — a escolha costuma ser convenção de equipe.

```typescript
interface ReviewProps {
  title: string;
  minutes: number;
  completed?: boolean; // "?" = propriedade opcional
}

type Difficulty = "easy" | "medium" | "hard"; // union type
type ID = string | number;                     // outro union type
```

## Tipando props, state e eventos no React

```tsx
interface ReviewCardProps {
  title: string;
  minutes: number;
  onComplete: (id: string) => void;
}

function ReviewCard({ title, minutes, onComplete }: ReviewCardProps) {
  const [completed, setCompleted] = useState<boolean>(false);

  function handleClick(e: React.MouseEvent<HTMLButtonElement>) {
    setCompleted(true);
    onComplete("123");
  }

  return <button onClick={handleClick}>{title} — {minutes}min</button>;
}
```

## Generics

Generics permitem escrever código reutilizável que funciona com vários tipos, sem perder a segurança de tipo (diferente de usar `any`, que perde toda a checagem).

```typescript
function primeiro<T>(lista: T[]): T | undefined {
  return lista[0];
}

const a = primeiro<string>(["x", "y"]);  // a: string | undefined
const b = primeiro([1, 2, 3]);           // TypeScript infere T = number automaticamente

interface ApiResponse<T> {
  data: T;
  error: string | null;
}

function buscarUsuario(): Promise<ApiResponse<Usuario>> { ... }
// O código que chama já sabe que `data` será do tipo Usuario, sem type assertion manual
```

## Utility types: Partial, Pick, Omit

```typescript
interface Review {
  id: string;
  title: string;
  minutes: number;
  completed: boolean;
}

type ReviewUpdate = Partial<Review>;                // todas as propriedades opcionais — ideal para PATCH
type ReviewSummary = Pick<Review, "id" | "title">;  // só id e title
type NewReview = Omit<Review, "id">;                // tudo, exceto id (que o banco gera)

function atualizarReview(id: string, updates: Partial<Review>) {
  // updates pode ter só { minutes: 45 }, sem precisar de todos os campos
}
```

### Por que derivar em vez de duplicar

Sem esses utility types, seria necessário criar manualmente uma segunda interface parecida (`ReviewUpdateManual { title？: string; minutes?: number; ... }`) e mantê-la sincronizada manualmente com `Review` para sempre. `Partial<Review>` deriva automaticamente — se `Review` ganhar um campo novo, `Partial<Review>` já reflete isso sem nenhuma alteração adicional.

## Union types, Intersection types e Type Narrowing

```typescript
type Resultado = { sucesso: true; dados: string } | { sucesso: false; erro: string };

function processar(resultado: Resultado) {
  if (resultado.sucesso) {
    console.log(resultado.dados); // TS sabe que "dados" existe aqui
  } else {
    console.log(resultado.erro);  // TS sabe que "erro" existe aqui
  }
}
```

Esse padrão (um campo comum, como `sucesso`, que "discrimina" qual variante da união está ativa) é chamado de **discriminated union** — extremamente útil para modelar resultados de operações que podem ter formatos diferentes em sucesso vs. erro, com segurança total de tipo.

Intersection types (`A & B`) combinam dois tipos em um só, exigindo todas as propriedades de ambos:

```typescript
type ComTimestamp = { createdAt: string };
type ReviewComTimestamp = Review & ComTimestamp; // tem TODAS as propriedades de Review + createdAt
```

### Type narrowing com typeof e in

```typescript
function formatar(valor: string | number) {
  if (typeof valor === "string") return valor.toUpperCase();  // TS sabe: é string aqui
  return valor.toFixed(2);                                     // TS sabe: é number aqui
}

function processarEvento(evento: { type: "click" } | { type: "scroll"; posicao: number }) {
  if ("posicao" in evento) {
    console.log(evento.posicao); // TS sabe que essa variante tem "posicao"
  }
}
```

## Erros comuns

- Usar `any` para "resolver" um erro de tipo em vez de entender e corrigir o tipo real — isso desliga a checagem de tipos justamente onde ela seria mais útil.
- Duplicar interfaces parecidas manualmente em vez de derivar com `Partial`/`Pick`/`Omit`.
- Esquecer o `?` em propriedades opcionais, forçando toda chamada a passar campos desnecessários.
- Fazer type assertion (`as Tipo`) para "convencer" o compilador sem garantir de fato que o valor é daquele tipo em runtime — isso pode mascarar bugs reais.

## Checklist rápido

- [ ] Sei quando usar `Partial`, `Pick` e `Omit` em vez de duplicar interfaces
- [ ] Sei escrever uma função genérica simples com `<T>`
- [ ] Sei modelar um discriminated union para resultados de sucesso/erro
- [ ] Evito `any`, preferindo entender e tipar corretamente o valor real$md$,
  updated_at = now()
where slug = 'semana-3-typescript';

update public.study_contents set
  content = $md$# Integração Full Stack

## Objetivo desta aula

Consumir uma API real a partir do React de forma robusta — tratando loading, empty e error corretamente — e organizar essa lógica em hooks reutilizáveis em vez de espalhar `fetch` pelos componentes.

## O padrão básico de integração

```tsx
function useReviews(userId: string) {
  const [reviews, setReviews] = useState<Review[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let cancelado = false;
    setLoading(true);
    setError(null);

    fetch(`/api/reviews?user_id=${userId}`)
      .then(res => {
        if (!res.ok) throw new Error(`Erro HTTP ${res.status}`);
        return res.json();
      })
      .then(data => { if (!cancelado) setReviews(data); })
      .catch(() => { if (!cancelado) setError("Não foi possível carregar as revisões."); })
      .finally(() => { if (!cancelado) setLoading(false); });

    return () => { cancelado = true; };
  }, [userId]);

  return { reviews, loading, error };
}
```

Note os três cuidados presentes: (1) verificação de `res.ok`, (2) tratamento de erro que não expõe detalhes técnicos ao usuário, (3) flag `cancelado` para evitar `setState` depois que o componente desmontar.

## Os três estados obrigatórios (além do sucesso)

- **Loading**: enquanto a requisição está em andamento — mostrar skeleton/spinner, nunca uma tela em branco.
- **Empty**: quando a requisição teve sucesso mas não há dados — mensagem amigável com call-to-action, não uma tela vazia sem explicação.
- **Error**: quando a requisição falhou — mensagem clara, idealmente com opção de tentar novamente.

```tsx
function ListaDeRevisoes({ userId }: { userId: string }) {
  const { reviews, loading, error } = useReviews(userId);

  if (loading) return <Skeleton />;
  if (error) return <ErrorMessage text={error} onRetry={...} />;
  if (reviews.length === 0) return <EmptyState text="Você ainda não possui revisões." />;

  return <ul>{reviews.map(r => <li key={r.id}>{r.title}</li>)}</ul>;
}
```

Ignorar qualquer um desses três estados é uma das causas mais comuns de UI confusa em produção: usuário sem feedback durante o carregamento, tela em branco sem explicação quando não há dados, ou uma mensagem técnica assustadora quando algo falha.

## Centralizando em hooks/services

Repetir a lógica de `fetch` + tratamento de erro em cada componente gera duplicação e inconsistência (um componente trata erro de um jeito, outro de outro). Centralizar em hooks reutilizáveis resolve isso:

```
src/
  services/reviewService.ts   <- só a chamada HTTP crua
  hooks/useReviews.ts          <- estado (loading/error/data) + chamada ao service
  components/ReviewList.tsx    <- só consome o hook, foca em apresentação
```

```typescript
// services/reviewService.ts — só a comunicação com a API
export async function getReviews(userId: string) {
  const res = await fetch(`/api/reviews?user_id=${userId}`);
  if (!res.ok) throw new Error(`Erro HTTP ${res.status}`);
  return res.json();
}
```

Essa separação faz com que, se a forma de buscar dados mudar (trocar endpoint, adicionar cache, mudar de REST para outra abordagem), só o `service` precise mudar — hooks e componentes continuam funcionando sem alteração.

## Autenticação na integração

Ao chamar uma API autenticada, é preciso anexar as credenciais (token JWT, cookie de sessão) em cada requisição. Ferramentas como o client do Supabase já fazem isso automaticamente, injetando o token da sessão ativa — mas ao integrar com uma API própria (FastAPI, por exemplo), isso geralmente é feito manualmente:

```typescript
const res = await fetch("/api/reviews", {
  headers: { Authorization: `Bearer ${token}` },
});
```

## Paralelizando múltiplas chamadas independentes

Quando uma tela precisa de dados de várias fontes independentes, buscar sequencialmente desperdiça tempo:

```tsx
// Lento: espera uma terminar para começar a próxima
const reviews = await getReviews(userId);
const questions = await getQuestions(userId);

// Rápido: as duas buscas acontecem ao mesmo tempo
const [reviews, questions] = await Promise.all([
  getReviews(userId),
  getQuestions(userId),
]);
```

## Erros comuns

- Não verificar `response.ok`, tratando uma resposta de erro HTTP como se fosse sucesso.
- Deixar `fetch` espalhado em vários componentes em vez de centralizar em services/hooks.
- Esquecer o estado de "empty" e mostrar uma lista vazia sem nenhuma explicação ao usuário.
- Buscar dados independentes sequencialmente quando poderiam ser paralelizados com `Promise.all`.

## Checklist rápido

- [ ] Todo componente que busca dados trata loading, empty e error explicitamente
- [ ] Minha lógica de fetch está centralizada em services/hooks, não espalhada em componentes
- [ ] Verifico `response.ok` antes de processar qualquer resposta de API
- [ ] Uso `Promise.all` para chamadas independentes que podem rodar em paralelo$md$,
  updated_at = now()
where slug = 'semana-3-integracao-full-stack';

update public.study_contents set
  content = $md$# Docker

## Objetivo desta aula

Entender containers na prática, escrever Dockerfiles eficientes (incluindo multi-stage builds), e orquestrar múltiplos serviços localmente com Docker Compose.

## Containers: o problema que resolvem

Um container empacota uma aplicação com tudo que ela precisa para rodar (dependências, runtime, configuração) em uma unidade isolada e portátil. Isso elimina a clássica frase "funciona na minha máquina" — o mesmo container roda de forma idêntica no notebook do desenvolvedor, no servidor de CI e em produção, porque o ambiente inteiro está empacotado junto, não só o código.

## Dockerfile, instrução por instrução

```dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

- **FROM**: imagem base sobre a qual construir.
- **WORKDIR**: diretório de trabalho dentro do container (comandos seguintes rodam relativos a ele).
- **RUN**: executa um comando durante a CONSTRUÇÃO da imagem (ex: instalar dependências) — vira uma camada permanente da imagem.
- **COPY**: copia arquivos do host para dentro da imagem.
- **EXPOSE**: documenta a porta usada (não abre a porta sozinho — isso é feito ao rodar o container).
- **CMD**: comando padrão executado quando o container inicia (pode ser sobrescrito).
- **ENTRYPOINT**: parecido com CMD, mas pensado para não ser sobrescrito facilmente — frequentemente combinado com CMD para fornecer argumentos padrão.

### Por que a ordem das instruções importa (cache de camadas)

Cada instrução do Dockerfile cria uma **camada** cacheável. Se nada mudou em uma camada desde o último build, o Docker reaproveita o cache em vez de reexecutar. Por isso `COPY requirements.txt` + `RUN pip install` vêm ANTES de `COPY . .`: se só o código da aplicação mudar (não as dependências), o Docker reaproveita a camada já construída do `pip install`, tornando o build muito mais rápido. Se a ordem fosse invertida (copiar tudo antes de instalar), qualquer mudança no código invalidaria o cache das dependências, forçando reinstalar tudo a cada build.

## Multi-stage build: imagens menores e mais seguras

```dockerfile
# Stage 1: build (tem ferramentas pesadas, só usadas para compilar)
FROM node:20 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: produção (imagem final, enxuta)
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
```

A primeira stage tem tudo que é necessário para **construir** a aplicação (Node.js, dependências de desenvolvimento, ferramentas de build) — coisas que não precisam existir na imagem final que roda em produção. A segunda stage começa do zero com uma imagem mínima (`nginx:alpine`) e copia **só o resultado do build** (`/app/dist`). O resultado: uma imagem de produção drasticamente menor e com menos superfície de ataque (menos software instalado = menos vulnerabilidades potenciais).

## Docker Compose: orquestrando múltiplos serviços

```yaml
services:
  api:
    build: .
    ports: ["8000:8000"]
    environment:
      - DATABASE_URL=postgresql://user:pass@db:5432/app
    depends_on:
      - db
  db:
    image: postgres:16
    environment:
      - POSTGRES_PASSWORD=pass
    volumes:
      - pgdata:/var/lib/postgresql/data
  redis:
    image: redis:7-alpine

volumes:
  pgdata:
```

`docker compose up` sobe todos os serviços de uma vez, na rede interna criada automaticamente — dentro dela, os serviços se enxergam pelo nome (`db`, `redis`), sem precisar descobrir IPs.

## Volumes: por que os dados sobrevivem (ou não)

Sem volume, dados escritos dentro de um container existem só enquanto ele existir — recriar o container (`docker compose up --force-recreate`, ou uma atualização de imagem) apaga tudo. `volumes: - pgdata:/var/lib/postgresql/data` persiste os arquivos do PostgreSQL **fora** do ciclo de vida do container, em um volume gerenciado pelo Docker que sobrevive a recriações.

## .dockerignore

Assim como `.gitignore`, um `.dockerignore` evita copiar arquivos desnecessários (ou sensíveis) para dentro da imagem:

```
node_modules
.git
.env
*.log
```

Isso acelera o build (menos dados para copiar) e evita vazar segredos (`.env`) para dentro da imagem por acidente.

## Erros comuns

- Copiar todo o código ANTES de instalar dependências, invalidando o cache de camadas a cada mudança de código.
- Não usar multi-stage build em projetos com ferramentas pesadas de compilação, resultando em imagens de produção desnecessariamente grandes.
- Esquecer volumes em serviços com estado (bancos de dados), perdendo dados ao recriar o container.
- Colocar segredos (senhas, chaves de API) diretamente no Dockerfile ou na imagem, em vez de injetá-los via variáveis de ambiente no momento de rodar o container.

## Checklist rápido

- [ ] Sei explicar por que a ordem das instruções no Dockerfile afeta a velocidade do build
- [ ] Sei quando e por que usar multi-stage build
- [ ] Sei orquestrar múltiplos serviços com Docker Compose, incluindo rede interna
- [ ] Sei por que um serviço com banco de dados precisa de volume$md$,
  updated_at = now()
where slug = 'semana-4-docker';

update public.study_contents set
  content = $md$# Kubernetes & Observabilidade

## Objetivo desta aula

Entender os blocos fundamentais do Kubernetes (Pod, Deployment, Service, Ingress) e por que observabilidade (logs, métricas) é indispensável para operar sistemas distribuídos com múltiplos containers.

## Por que Kubernetes existe

Rodar um container isolado (Docker) resolve "empacotar a aplicação". Mas em produção, com múltiplas instâncias, atualizações sem downtime, recuperação automática de falhas e escalonamento conforme demanda, gerenciar isso manualmente em vários servidores se torna inviável. Kubernetes automatiza esse gerenciamento: descreve o **estado desejado** do sistema, e o Kubernetes trabalha continuamente para manter a realidade alinhada a essa descrição.

## Pods, Deployments e Services

- **Pod**: a menor unidade gerenciável — geralmente um container (ou um pequeno grupo intimamente relacionado, como uma aplicação e seu sidecar de logging).
- **Deployment**: descreve o estado desejado de um conjunto de Pods (qual imagem, quantas réplicas) e garante que a realidade convirja para isso — se um Pod cai, o Deployment sobe outro automaticamente.
- **Service**: expõe um conjunto de Pods sob um endereço estável, já que Pods individuais são efêmeros (recriados constantemente, com IPs que mudam).

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api
spec:
  replicas: 3
  selector:
    matchLabels: { app: api }
  template:
    metadata:
      labels: { app: api }
    spec:
      containers:
        - name: api
          image: minha-api:v2
          resources:
            limits: { memory: "512Mi", cpu: "500m" }
---
apiVersion: v1
kind: Service
metadata:
  name: api-service
spec:
  selector: { app: api }
  ports:
    - port: 80
      targetPort: 8000
```

O `Service` roteia tráfego para qualquer Pod com o label `app: api`, independente de qual Pod específico está rodando naquele momento — os clientes (outros serviços, o Ingress) só precisam conhecer o `Service`, nunca os Pods individuais.

### O que acontece quando um Pod consome mais memória que o limite

Se um Pod ultrapassa o limite de memória configurado (`resources.limits.memory`), o Kubernetes o encerra — conhecido como **OOMKilled** (Out Of Memory Killed) — e, por estar sob um Deployment, ele é recriado automaticamente. Isso protege o node de ficar sem memória por causa de um único Pod descontrolado, mas também é um sinal de alerta: reinícios frequentes por OOMKilled geralmente indicam um vazamento de memória na aplicação que precisa ser investigado, não apenas "aumentar o limite" indefinidamente.

## Ingress: a porta de entrada

O `Ingress` gerencia o acesso externo (HTTP/HTTPS) aos Services do cluster, tipicamente roteando por domínio ou path para diferentes serviços internos:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
spec:
  rules:
    - host: api.exemplo.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service: { name: api-service, port: { number: 80 } }
```

## Escalabilidade horizontal

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata: { name: api-hpa }
spec:
  scaleTargetRef: { apiVersion: apps/v1, kind: Deployment, name: api }
  minReplicas: 2
  maxReplicas: 10
  metrics:
    - type: Resource
      resource: { name: cpu, target: { type: Utilization, averageUtilization: 70 } }
```

O Horizontal Pod Autoscaler ajusta automaticamente o número de réplicas conforme métricas (uso de CPU, no exemplo) — crescendo sob carga alta e reduzindo quando a demanda cai, sem intervenção manual.

## Observabilidade: por que logs isolados não bastam

Com uma única aplicação rodando em uma máquina, "olhar o log" é simples. Com dezenas de Pods, cada um gerando seus próprios logs, isso se torna inviável sem centralização. **ELK** (Elasticsearch, Logstash, Kibana) é uma stack popular para isso: Logstash (ou alternativas como Fluentd) coleta logs de todos os Pods, Elasticsearch indexa e armazena, Kibana oferece uma interface de busca e visualização.

Observabilidade combina três pilares complementares:
- **Logs**: eventos discretos ("requisição X falhou com erro Y às 14:32").
- **Métricas**: números agregados ao longo do tempo (uso de CPU, latência média, taxa de erro).
- **Traces**: o caminho completo de uma requisição através de múltiplos serviços, útil para identificar em qual etapa específica está o gargalo em uma arquitetura distribuída.

### Por que "reiniciar o Pod" pode mascarar o problema real

Reiniciar um Pod com problema (memory leak, deadlock) costuma aliviar o sintoma temporariamente — mas sem investigar logs e métricas para entender a causa raiz, o problema tende a se repetir, cada vez com mais frequência. Observabilidade existe justamente para permitir a pergunta "por que isso está acontecendo", não só "como faço isso parar agora".

## Erros comuns

- Confundir Deployment com Pod — gerenciar Pods diretamente em vez de através de um Deployment perde a recuperação automática de falhas.
- Não configurar `resources.limits`, permitindo que um Pod problemático consuma recursos do node inteiro, afetando outros serviços.
- Reiniciar Pods repetidamente sem investigar logs/métricas, tratando o sintoma em vez da causa.
- Expor Services diretamente sem Ingress em ambientes com múltiplos domínios/serviços, perdendo a centralização do roteamento externo.

## Checklist rápido

- [ ] Sei explicar a relação entre Pod, Deployment e Service com minhas palavras
- [ ] Sei o que significa um Pod ser OOMKilled e o que isso pode indicar
- [ ] Entendo o papel do Ingress no roteamento de tráfego externo
- [ ] Sei por que logs centralizados são necessários com múltiplos Pods$md$,
  updated_at = now()
where slug = 'semana-4-kubernetes-observabilidade';

update public.study_contents set
  content = $md$# CI/CD

## Objetivo desta aula

Entender a diferença prática entre Integração Contínua e Entrega Contínua, escrever um pipeline básico com GitHub Actions, e reconhecer por que manter a branch principal sempre "verde" é uma disciplina, não um detalhe.

## CI (Integração Contínua): detectar problemas cedo

Toda vez que alguém envia código (push ou Pull Request), um pipeline automatizado roda verificações — lint, testes, build — **antes** de permitir o merge. Isso captura problemas no momento em que são introduzidos, quando são baratos de corrigir, em vez de descobri-los depois, em produção, quando já afetam usuários reais.

## CD (Entrega/Deploy Contínuo): automatizar a entrega

Depois que o código passa pela CI, a CD automatiza colocá-lo em produção (ou staging) sem intervenção manual repetitiva a cada release. Entrega contínua (deploy exige um clique) e deploy contínuo (deploy automático a cada merge) são variações do mesmo princípio, com diferentes níveis de automação total.

## GitHub Actions na prática

```yaml
name: CI
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: 20 }
      - run: npm ci
      - run: npm run lint
      - run: npm run test
      - run: npm run build

  deploy:
    needs: test  # só roda se "test" passar
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v4
      - run: echo "Deploy para produção aqui"
```

O job `deploy` depende (`needs: test`) do job `test` ter sucesso — se o lint, os testes ou o build falharem, o deploy nunca acontece, funcionando como uma trava de segurança automática.

## Etapas típicas de um pipeline

1. **Checkout**: baixa o código do commit/PR específico.
2. **Instalar dependências**: `npm ci` (mais determinístico que `npm install` em CI, pois respeita exatamente o lockfile).
3. **Lint**: verifica estilo e erros óbvios sem executar o código.
4. **Testes**: roda a suíte automatizada.
5. **Build**: compila/empacota a aplicação, capturando erros de build antes de chegar em produção.
6. **Deploy**: publica o resultado validado em um ambiente.

## Por que manter a branch principal sempre "verde"

Um pipeline de CI que falha na branch principal indica que aquele estado do código não é confiável. Continuar mesclando por cima de um pipeline quebrado acumula problemas e dificulta identificar exatamente qual mudança causou a falha original — quanto mais commits se acumulam sobre um estado quebrado, mais difícil (e arriscado) fica isolar e corrigir a causa raiz. A disciplina padrão da indústria é: pipeline quebrado na main vira prioridade máxima da equipe, à frente de novas features, até ser corrigido.

## Testes instáveis (flaky tests) corroem a confiança

Quando testes falham de forma aleatória e sem relação real com o código alterado, a equipe começa a ignorar falhas do CI ("deve ser flaky de novo") — e nesse momento o pipeline perde sua função de rede de segurança: bugs reais podem passar despercebidos escondidos entre os falsos alarmes. Vale mais investir tempo corrigindo a causa raiz da instabilidade (geralmente testes que dependem de timing, ordem de execução, ou estado compartilhado entre testes) do que conviver indefinidamente com testes que "às vezes falham".

## Vercel, Render e onde cada um se encaixa

**Vercel** é otimizada para frontend (Next.js, Vite, sites estáticos), com deploy automático a cada push e uma URL de preview única por Pull Request — extremamente útil para revisar visualmente uma mudança antes de aprovar o merge. **Render** é mais geral: hospeda tanto frontend quanto backend (APIs, workers, bancos de dados gerenciados) — útil quando o frontend está na Vercel mas o backend (FastAPI, por exemplo) precisa rodar em outro lugar com mais controle sobre o ambiente de execução.

## Erros comuns

- Fazer deploy manual "só dessa vez" pulando o pipeline de CI, introduzindo justamente o tipo de erro que ele existiria para capturar.
- Ignorar falhas de CI classificando-as como "flaky" sem investigar se realmente são, deixando bugs reais passarem.
- Não separar claramente etapas (lint, teste, build) em jobs/steps distintos, dificultando saber exatamente onde o pipeline falhou.
- Colocar segredos (chaves de API, tokens de deploy) diretamente no arquivo de workflow em vez de usar variáveis de ambiente seguras (GitHub Secrets).

## Checklist rápido

- [ ] Sei explicar a diferença entre CI e CD com um exemplo
- [ ] Sei escrever um workflow básico do GitHub Actions com múltiplos steps
- [ ] Entendo por que um pipeline quebrado na main deveria ser prioridade imediata
- [ ] Sei por que "ignorar testes flaky" é perigoso para a confiabilidade do processo$md$,
  updated_at = now()
where slug = 'semana-4-ci-cd';

update public.study_contents set
  content = $md$# Arquitetura de APIs

## Objetivo desta aula

Projetar endpoints REST seguindo convenções que outros desenvolvedores reconhecem instantaneamente, entender paginação, CORS e versionamento — tópicos que separam uma API "que funciona" de uma API bem projetada.

## REST: recursos e verbos

REST modela o sistema como **recursos** (usuários, revisões, perguntas) acessados via URLs previsíveis, usando os verbos HTTP para indicar a ação pretendida sobre aquele recurso.

```
GET    /reviews          -> lista revisões
POST   /reviews          -> cria uma revisão
GET    /reviews/{id}     -> busca uma revisão específica
PATCH  /reviews/{id}     -> atualiza parcialmente
PUT    /reviews/{id}     -> substitui o recurso inteiro
DELETE /reviews/{id}     -> remove
```

### Por que não usar verbos na URL

Uma URL como `GET /getUserReviews?userId=123` não segue as convenções REST: mistura um verbo (`get`) dentro do caminho, quando a ação já deveria ser comunicada pelo método HTTP. A forma idiomática seria `GET /users/123/reviews` — o recurso (revisões daquele usuário) está claro na URL, e o verbo HTTP já diz que é uma leitura.

## PUT vs. PATCH

**PUT** substitui o recurso inteiro (o cliente precisa enviar todos os campos, mesmo os que não mudaram). **PATCH** atualiza apenas os campos enviados — muito mais comum na prática, já que a maioria das atualizações altera só uma parte do recurso.

```json
// PATCH /reviews/123 — só o campo enviado é alterado
{ "minutes": 45 }
```

## Paginação

Retornar milhares de registros de uma vez é caro (memória, tempo de resposta, tráfego de rede) e geralmente desnecessário — o cliente raramente precisa de tudo ao mesmo tempo.

```
GET /reviews?page=2&limit=20
```
```json
{
  "data": [...],
  "page": 2,
  "total_pages": 8,
  "total_items": 153
}
```

**Offset-based** (`page`/`limit`) é simples de implementar, mas pode gerar itens duplicados ou saltados se registros forem inseridos/removidos entre uma página e outra. **Cursor-based** (`?cursor=abc123`) usa um ponteiro estável para a posição, evitando esse problema — mais comum em APIs de alto volume (redes sociais, feeds).

## Status Codes: a categoria geral

- **2xx**: sucesso (200 OK, 201 Created, 204 No Content).
- **3xx**: redirecionamento.
- **4xx**: erro do CLIENTE (400 dados inválidos, 401 não autenticado, 403 sem permissão, 404 não encontrado, 422 falha de validação).
- **5xx**: erro do SERVIDOR (500 erro interno inesperado).

Escolher o código certo comunica precisamente o que aconteceu, permitindo que o cliente (frontend, outro serviço) reaja de forma apropriada — por exemplo, um 401 pode disparar automaticamente um redirect para login, enquanto um 500 pode disparar um retry.

## CORS: o que realmente controla

CORS (Cross-Origin Resource Sharing) é aplicado pelo **navegador**, não pelo servidor de forma passiva — o navegador bloqueia respostas de origens diferentes a menos que o servidor declare explicitamente quais origens são permitidas.

```python
# FastAPI
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://meuapp.com"],
    allow_methods=["GET", "POST", "PATCH", "DELETE"],
    allow_headers=["Authorization", "Content-Type"],
)
```

Um erro clássico: a API funciona perfeitamente ao testar com `curl` ou Postman (essas ferramentas não aplicam CORS), mas falha misteriosamente quando chamada do navegador em um domínio diferente — porque o navegador, não a API em si, está bloqueando a resposta por falta de headers CORS corretos.

## Versionamento de API

```
/v1/reviews
/v2/reviews
```

Versionar permite introduzir mudanças incompatíveis (breaking changes) em uma nova versão, enquanto clientes existentes continuam usando a versão antiga até migrarem no seu próprio ritmo — evitando quebrar integrações de um dia para o outro quando múltiplos clientes (apps móveis, integrações de terceiros) dependem de contratos estáveis.

## Autenticação via headers

```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

O token (geralmente um JWT) é validado pelo servidor a cada requisição para identificar o usuário — sem precisar de sessão com estado guardado no servidor, o que facilita escalar horizontalmente (qualquer instância da API pode validar o token de forma independente).

## Erros comuns

- Usar GET para operações que alteram dados no servidor, violando a expectativa de que GET é uma operação segura e sem efeitos colaterais.
- Retornar 200 OK mesmo quando a operação falhou (com um campo `"success": false` no corpo) em vez de usar o status HTTP apropriado.
- Não paginar endpoints que podem crescer indefinidamente, causando degradação de performance conforme os dados aumentam.
- Testar só com ferramentas que ignoram CORS (Postman, curl) e descobrir o problema só quando o frontend real tenta chamar a API.

## Checklist rápido

- [ ] Sei escolher o verbo HTTP certo para cada operação
- [ ] Sei explicar a diferença entre PUT e PATCH com um exemplo
- [ ] Sei por que CORS é um mecanismo do navegador, não do servidor
- [ ] Entendo quando paginação se torna necessária em um endpoint$md$,
  updated_at = now()
where slug = 'semana-4-arquitetura-apis';

update public.study_contents set
  content = $md$# Git & Metodologias Ágeis

## Objetivo desta aula

Dominar operações de Git além do básico (rebase, cherry-pick, stash) sabendo quando cada uma é apropriada, e entender a diferença prática entre Scrum e Kanban na organização do trabalho em equipe.

## Branches e merge

Uma branch é uma linha de desenvolvimento independente. Merge combina o histórico de duas branches, criando um commit de merge quando há divergência real entre elas.

```bash
git checkout -b feature/revisoes
# ... commits ...
git checkout main
git merge feature/revisoes
```

## Rebase: histórico linear, com um custo

Rebase reaplica os commits de uma branch sobre uma nova base, criando um histórico linear sem commit de merge.

```bash
git checkout feature/revisoes
git rebase main
```

**O custo**: rebase **reescreve o histórico** (novos hashes de commit são gerados). Isso é seguro em uma branch local que só você usa, mas perigoso em uma branch já compartilhada — se outra pessoa já baixou a versão antiga, o rebase cria uma divergência que força uma reconciliação manual confusa (ou, na pior hipótese, perda de trabalho se alguém fizer force-push sem cuidado). Regra prática: rebase à vontade em branches pessoais antes de abrir o PR; depois que outras pessoas começaram a revisar/trabalhar naquela branch, prefira merge.

## Cherry-pick: levar um commit específico

```bash
git cherry-pick a1b2c3d
```

Aplica um commit específico de uma branch em outra, sem trazer o restante do histórico daquela branch. Útil para levar uma correção pontual (um hotfix crítico) para outra branch (ex: uma branch de release) sem misturar outras mudanças não relacionadas.

## Stash: pausar trabalho sem commitar

```bash
git stash                    # guarda mudanças não commitadas
git checkout outra-branch    # área de trabalho limpa
# ... resolve algo urgente ...
git checkout feature/revisoes
git stash pop                # recupera as mudanças guardadas
```

Útil quando você precisa trocar de contexto rapidamente (um bug urgente aparece) sem querer commitar um trabalho ainda incompleto.

## Resolvendo conflitos

Um conflito acontece quando duas branches alteram a mesma região de um arquivo de formas diferentes, e o Git não consegue decidir automaticamente qual versão manter.

```
<<<<<<< HEAD
const timeout = 5000;
=======
const timeout = 3000;
>>>>>>> feature/ajuste-timeout
```

Resolver significa examinar os marcadores, decidir (ou combinar) qual versão faz sentido, remover os marcadores, e finalizar com um commit normal. Não há atalho mágico — cabe à pessoa desenvolvedora decidir com base no contexto real do código.

## Boas mensagens de commit

Uma mensagem de commit útil descreve **o que** mudou e, quando não é óbvio, **por que**:

```
ruim:  "fix"
ruim:  "ajustes"
bom:   "corrige cálculo de revisões atrasadas para considerar timezone local"
```

Mensagens vagas dificultam muito investigar bugs no futuro (`git blame` e `git log` ficam inúteis) e entender a intenção de uma mudança sem precisar reconstituir o contexto do zero.

## Scrum: ciclos fixos e rituais

Scrum organiza o trabalho em **Sprints** (ciclos fixos, geralmente 1-2 semanas), com rituais estruturados:

- **Planning**: no início da Sprint, decide-se o que entra nela.
- **Daily**: alinhamento diário curto (o que fiz, o que farei, o que está bloqueando).
- **Retrospectiva**: ao final da Sprint, reflexão sobre o que funcionou e o que pode melhorar no processo da equipe.

## Kanban: fluxo contínuo

Kanban organiza o trabalho em colunas (ex: "a fazer", "em progresso", "concluído"), sem ciclos fixos — o trabalho flui continuamente, e novas demandas entram conforme surgem. Um princípio central é **limitar o trabalho em progresso** (WIP limit): evitar que muitas tarefas estejam "em andamento" simultaneamente, o que geralmente sinaliza gargalos e reduz o foco.

## Quando cada abordagem se encaixa melhor

**Scrum** funciona bem para produtos com entregas planejadas em ciclos previsíveis, onde faz sentido comprometer-se com um escopo por um período fixo. **Kanban** funciona bem para fluxo contínuo de demandas variáveis e imprevisíveis (suporte técnico, manutenção), onde forçar ciclos fixos artificiais não agregaria valor real.

## Erros comuns

- Fazer rebase em uma branch já compartilhada com outras pessoas, causando divergência de histórico confusa.
- Mensagens de commit vagas que não ajudam ninguém (incluindo você mesmo, meses depois) a entender o que mudou e por quê.
- Resolver conflitos "no automático" sem entender de fato o que cada lado da mudança pretendia fazer.
- Aplicar Scrum rigidamente a um contexto de fluxo imprevisível (ou vice-versa), forçando um processo que não se encaixa na natureza real do trabalho.

## Checklist rápido

- [ ] Sei quando rebase é seguro e quando não é
- [ ] Sei usar cherry-pick para levar uma correção pontual entre branches
- [ ] Escrevo mensagens de commit que explicam o quê e o porquê
- [ ] Sei explicar a diferença entre Scrum e Kanban com um exemplo de quando cada um se encaixa melhor$md$,
  updated_at = now()
where slug = 'semana-4-git-metodologias-ageis';

update public.study_contents set
  content = $md$# Projetos do Portfólio

## Objetivo desta aula

Aprender a estruturar e, principalmente, a **falar sobre** um projeto de portfólio de forma que demonstre decisões técnicas reais — usando dois projetos-exemplo (PokeFast API e SmartFinance) como cases de estudo didáticos.

## PokeFast API — Case de estudo (Backend)

Um projeto-exemplo em **Python + FastAPI** que consome a PokéAPI (uma API pública externa) de forma assíncrona, expondo endpoints próprios organizados e testados. É um case pensado para exercitar, na prática, os fundamentos estudados na Semana 1.

### O que esse tipo de projeto costuma demonstrar

- **Arquitetura**: separação entre rotas, serviços (lógica de negócio) e o cliente HTTP que fala com a PokéAPI externa — evitando misturar tudo em um único arquivo.
- **Async na prática**: chamadas à API externa feitas de forma assíncrona, para não bloquear a aplicação enquanto espera a resposta de um serviço de terceiros.
- **Tratamento de falhas de dependência externa**: o que acontece se a PokéAPI estiver lenta ou fora do ar? Um projeto bem construído trata timeout e erro de forma explícita, em vez de deixar a exceção propagar sem controle.
- **Paginação própria**: os endpoints do projeto paginam resultados, em vez de retornar listas inteiras de uma vez.
- **Testes**: cobertura dos principais endpoints, incluindo casos de erro (ex: Pokémon inexistente retorna 404, não um erro genérico).

### Como falar sobre esse tipo de projeto em entrevista, sem inventar

Ao ser perguntado(a) sobre decisões específicas de um projeto de estudo, a resposta honesta e didática é apresentar a prática esperada de forma geral: *"para consumir uma API externa de forma resiliente, o padrão que segui foi..."* em vez de afirmar como fato absoluto um detalhe que talvez não tenha sido implementado exatamente daquela forma. Isso demonstra domínio do conceito sem comprometer a integridade da conversa.

## SmartFinance — Case de estudo (Frontend)

Um projeto-exemplo em **React + TypeScript**, com foco em um dashboard financeiro pessoal — pensado para exercitar visualização de dados, componentização e boas práticas de UX estudadas na Semana 3.

### O que esse tipo de projeto costuma demonstrar

- **Visualização de dados**: gráficos (com bibliotecas como Recharts) mostrando gastos/receitas ao longo do tempo, por categoria.
- **Gerenciamento de estado compartilhado**: Context API para dados usados em várias partes do dashboard (usuário, filtros ativos), evitando prop drilling.
- **Composição de dashboard**: vários cards/gráficos independentes, cada um responsável por buscar e tratar seus próprios dados — loading, empty e error tratados card a card, não de forma global (conectando diretamente com a Semana 3).
- **Geração de relatório em PDF**: um recurso comum em ferramentas financeiras, exercitando integração com bibliotecas de terceiros no frontend.
- **Atenção a detalhes de UX**: formatação de valores monetários, feedback claro em ações do usuário, estados de carregamento bem sinalizados.

## As 12 perguntas que todo projeto de portfólio deveria responder

Preparar respostas objetivas para estas perguntas cobre a maioria do que um entrevistador técnico pergunta sobre um projeto:

1. Qual problema o projeto resolve?
2. Qual foi a arquitetura escolhida?
3. Por que essas tecnologias específicas?
4. Como frontend e backend se comunicam?
5. Como os dados são armazenados?
6. Quais foram os principais desafios?
7. Como você resolveu esses desafios?
8. O que você faria diferente hoje?
9. Como o sistema poderia escalar?
10. Como você testaria (ou testou) o sistema?
11. Como seria o processo de deploy?
12. Como você melhoraria a segurança?

## Por que documentar decisões no README ajuda na entrevista

Escrever "o porquê" de uma decisão técnica no README força articular o raciocínio por escrito — o que é, na prática, um ensaio da própria resposta que você daria verbalmente em entrevista. Um README que só lista "tecnologias usadas" sem explicar decisões perde essa oportunidade.

## Erros comuns ao apresentar um projeto

- Listar tecnologias sem conseguir explicar por que cada uma foi escolhida.
- Não conseguir descrever pelo menos um desafio real e como foi resolvido — projetos "perfeitos sem obstáculos" soam pouco convincentes.
- Afirmar com certeza absoluta um detalhe técnico não implementado de fato, arriscando ser pego em uma pergunta de aprofundamento.
- Focar só no "o quê" (funcionalidades) sem conseguir explicar o "como" (arquitetura, decisões).

## Checklist rápido

- [ ] Consigo explicar o PokeFast API e o SmartFinance como cases de estudo, sem inventar detalhes não definidos
- [ ] Tenho uma resposta preparada para cada uma das 12 perguntas, para pelo menos um projeto meu
- [ ] Consigo descrever pelo menos um desafio técnico real e como o resolvi
- [ ] Meu README (de um projeto real meu) explica decisões, não só lista tecnologias$md$,
  updated_at = now()
where slug = 'semana-5-projetos-portfolio';

update public.study_contents set
  content = $md$# Soft Skills & Método STAR

## Objetivo desta aula

Estruturar respostas de entrevista comportamental de forma clara e convincente usando o método STAR, com histórias reais preparadas com antecedência.

## Por que entrevista comportamental existe

Entrevistas técnicas avaliam conhecimento e capacidade de resolver problemas; entrevistas comportamentais avaliam como você trabalha na prática: comunicação, trabalho em equipe, lida com conflito, prioriza sob pressão. Empresas contratam pessoas, não só código — habilidades técnicas sem capacidade de colaborar tendem a gerar atrito em equipes reais.

## O método STAR, em detalhe

- **Situação**: o contexto — onde, quando, com quem, qual era o cenário.
- **Tarefa**: qual era especificamente seu objetivo ou responsabilidade naquela situação.
- **Ação**: o que **você** fez — não "nós", não "a equipe". O foco é na sua contribuição individual, mesmo que o resultado tenha sido fruto de trabalho coletivo.
- **Resultado**: o que aconteceu — idealmente com algum resultado mensurável ou aprendizado claro.

### Exemplo estruturado

**Pergunta**: "Conte sobre um problema técnico difícil que você resolveu."

> **Situação**: Durante o desenvolvimento de um projeto pessoal, o dashboard estava demorando mais de 5 segundos para carregar com dados reais.
> **Tarefa**: Eu precisava identificar a causa e reduzir esse tempo para uma experiência aceitável.
> **Ação**: Usei as ferramentas de rede do navegador para identificar que o problema era um padrão N+1 de queries — o código buscava a lista de usuários e depois fazia uma query separada para cada um. Refatorei para usar eager loading, trazendo os dados relacionados em uma única consulta adicional.
> **Resultado**: O tempo de carregamento caiu de 5 segundos para menos de 300ms. Também aprendi a sempre verificar o número de queries geradas ao trabalhar com relacionamentos em um ORM.

## Perguntas comuns e como abordá-las

**"Conte sobre um conflito com um colega."** — Descreva a situação de forma neutra, sem culpar a outra pessoa na narrativa. O foco deve estar em como você comunicou o desacordo profissionalmente e ajudou a chegar a uma solução — não em quem "estava certo".

**"Fale sobre uma situação em que precisou aprender uma tecnologia rapidamente."** — Ótima oportunidade para demonstrar autonomia de aprendizado: como você buscou informação, praticou, e aplicou sob prazo. Isso é especialmente relevante em tecnologia, onde ferramentas e frameworks mudam constantemente.

**"Como você lida com feedback?"** — Demonstre abertura genuína, sem soar nem defensivo nem passivo demais. Um exemplo concreto de feedback que você recebeu e como o aplicou vale mais que uma resposta genérica ("adoro receber feedback").

**"Como você prioriza tarefas?"** — Descreva um critério real (urgência, impacto, dependências entre tarefas) com um exemplo específico, não uma resposta abstrata de manual de gestão.

## Por que preparar de 4 a 6 histórias reais com antecedência

A maioria das perguntas comportamentais se encaixa em temas recorrentes: um conflito, um erro/falha, um prazo apertado, uma iniciativa própria, um aprendizado rápido, uma decisão técnica difícil. Preparar um punhado de histórias reais, estruturadas em STAR, cobre a grande maioria das variações dessas perguntas — evitando respostas vagas ou, pior, inventadas sob a pressão do momento.

## Por que histórias reais são mais convincentes que inventadas

Entrevistadores experientes frequentemente fazem perguntas de aprofundamento ("e o que aconteceu depois?", "como o colega reagiu?") sobre qualquer resposta dada. Uma história real tem detalhes naturais e consistentes que sustentam esse aprofundamento; uma história inventada tende a se desmontar diante de perguntas específicas, porque não há memória real de detalhes que nunca aconteceram.

## Erros comuns

- Responder de forma genérica demais, sem uma situação concreta ("eu sempre tento resolver conflitos bem") em vez de narrar um caso real.
- Falar só em "nós"/"a equipe" na parte da Ação, sem deixar claro qual foi especificamente a sua contribuição individual.
- Escolher exemplos onde você foi vítima passiva de um problema, sem mostrar uma ação concreta que tomou.
- Não ter um Resultado claro — terminar a história no meio, sem fechar o que de fato aconteceu ou o que foi aprendido.

## Checklist rápido

- [ ] Tenho pelo menos 4 histórias reais preparadas, estruturadas em STAR
- [ ] Em cada história, minha "Ação" fala claramente do que EU fiz, não só "a equipe"
- [ ] Todas as minhas histórias têm um Resultado claro e, quando possível, mensurável
- [ ] Pratiquei contar essas histórias em voz alta, não só mentalmente$md$,
  updated_at = now()
where slug = 'semana-5-soft-skills-star';

update public.study_contents set
  content = $md$# System Design

## Objetivo desta aula

Conectar os conceitos de performance e arquitetura estudados ao longo da trilha (cache, índices, filas, async) em um raciocínio único de escalabilidade — a habilidade central avaliada em entrevistas de system design.

## Escalar verticalmente vs. horizontalmente

**Escalar verticalmente** significa aumentar os recursos (CPU, memória) de uma única máquina — simples, mas tem um teto físico e um único ponto de falha. **Escalar horizontalmente** significa adicionar mais instâncias trabalhando em paralelo, distribuindo a carga — mais complexo de coordenar, mas sem teto prático e mais resiliente (uma instância cair não derruba o sistema inteiro).

## As peças que compõem um sistema escalável

### Cache (revisão da Semana 1, aplicado em escala)

Cache reduz a carga no banco de dados evitando recalcular/rebuscar os mesmos dados repetidamente — uma das formas mais eficazes e relativamente simples de melhorar performance sob alta carga, atacando o sintoma mais comum (banco sobrecarregado com leituras repetidas).

### Índices de banco de dados

Um índice acelera buscas em uma coluna específica, ao custo de espaço extra e escrita levemente mais lenta (o índice também precisa ser atualizado a cada insert/update). Sem índices adequados nas colunas mais consultadas, queries ficam progressivamente mais lentas conforme a tabela cresce — um problema que muitas vezes só aparece em produção, com volume real de dados.

### Filas e processamento assíncrono (revisão da Semana 1)

Sistemas de alta escala tiram trabalho pesado do caminho síncrono da requisição, delegando para filas (Celery e similares) — a resposta ao usuário continua rápida mesmo quando a tarefa de fundo (gerar um relatório, processar uma imagem) demora.

### Load Balancing

Um load balancer distribui requisições entre várias instâncias da aplicação, evitando que uma única instância fique sobrecarregada enquanto outras estão ociosas — peça essencial para qualquer escala horizontal funcionar de fato.

### CDN

Uma CDN (Content Delivery Network) distribui arquivos estáticos (imagens, JS, CSS) em servidores geograficamente próximos ao usuário final, reduzindo a latência de carregamento sem sobrecarregar o servidor de origem com esse tráfego.

### Code Splitting e Lazy Loading (frontend)

No frontend, code splitting divide o JavaScript em pedaços menores, carregados sob demanda — reduzindo o tempo até a aplicação ficar interativa, especialmente relevante em aplicações grandes.

## Raciocinando sobre um cenário real

**Pergunta de revisão**: *"O que você faria se o SmartFinance recebesse centenas de milhares de acessos simultâneos?"*

Uma resposta estruturada combinaria várias das peças acima, aplicadas ao ponto certo:

1. **Cache** das consultas mais frequentes (ex: resumo mensal de gastos, que não muda a cada segundo).
2. **Índices** adequados nas tabelas mais acessadas (transações, filtradas por usuário e data).
3. **Fila** para tarefas pesadas como geração de relatório em PDF, tirando-as do caminho síncrono da requisição.
4. **CDN** para servir os assets estáticos do frontend, sem sobrecarregar o servidor de aplicação.
5. **Escalabilidade horizontal** da API, atrás de um load balancer, para distribuir a carga de requisições entre múltiplas instâncias.

## Por que "adicionar mais servidores" sozinho nem sempre resolve

Se o gargalo real está em outro ponto — uma query lenta sem índice, ou um banco de dados único que não escala horizontalmente com a mesma facilidade que a camada de aplicação — adicionar mais servidores de aplicação não resolve o problema, apenas move (ou nem isso) o gargalo para outro lugar. Escalabilidade eficaz exige primeiro **identificar onde está o gargalo real** (via observabilidade — métricas e profiling) antes de escolher a solução: cache resolve leitura repetida cara; índice resolve busca lenta; fila resolve processamento pesado bloqueando a resposta; mais instâncias resolvem volume de requisições quando a aplicação em si já está otimizada.

## Throughput vs. latência, aplicado a decisões de arquitetura

Otimizações diferentes atacam métricas diferentes: cache e índices tendem a reduzir **latência** (resposta mais rápida para uma única requisição); load balancing e mais réplicas tendem a aumentar **throughput** (mais requisições processadas por segundo, no total). Um sistema pode precisar de ambos, dependendo de onde está o problema real.

## Erros comuns

- Propor "adicionar mais servidores" como resposta única e universal, sem identificar onde está o gargalo real.
- Esquecer que cache tem o problema companheiro da invalidação — propor cache sem mencionar como ele seria mantido atualizado.
- Ignorar o frontend na análise de escalabilidade, focando só no backend, quando code splitting e CDN também têm impacto real na experiência sob carga.
- Não considerar trade-offs — apresentar uma solução como se não tivesse custo (complexidade operacional, latência adicional, consistência eventual).

## Checklist rápido

- [ ] Sei explicar a diferença entre escalar vertical e horizontalmente
- [ ] Consigo montar uma resposta estruturada para "como você escalaria X", combinando várias técnicas
- [ ] Sei diferenciar quando um problema é de latência vs. de throughput
- [ ] Sei que "mais servidores" não é resposta universal — primeiro identifico o gargalo$md$,
  updated_at = now()
where slug = 'semana-5-system-design';

update public.study_contents set
  content = $md$# Code Review

## Objetivo desta aula

Revisar código com foco no que realmente importa — correção, manutenibilidade, segurança — aplicando princípios de qualidade (SOLID, DRY, KISS) de forma equilibrada, sem dogmatismo.

## Por que Code Review importa além de "achar bugs"

Revisão de código captura problemas antes de chegarem à produção, mas cumpre outras funções igualmente importantes: espalha conhecimento sobre o sistema pelo time (mais de uma pessoa entende cada parte do código), mantém um padrão de qualidade consistente, e é uma oportunidade de mentoria — tanto para quem revisa quanto para quem recebe o feedback.

## Legibilidade acima de "código esperto"

Código é lido muitas vezes mais do que é escrito. Nomes claros de variáveis e funções, funções pequenas com uma única responsabilidade clara, e comentários apenas onde o "porquê" não é óbvio pelo próprio código — tudo isso importa mais no longo prazo do que uma solução "elegante" mas difícil de entender.

```python
# Difícil de entender rapidamente
def p(l): return [x for x in l if x%2==0 and x>0]

# Claro sobre a intenção
def filtrar_numeros_pares_positivos(numeros):
    return [n for n in numeros if n % 2 == 0 and n > 0]
```

## SOLID, aplicado com bom senso

- **Single Responsibility**: uma classe/função deve ter um único motivo para mudar.
- **Open/Closed**: código deve ser extensível sem precisar modificar o que já funciona.
- **Liskov Substitution**: uma subclasse deve poder substituir sua classe pai sem quebrar o comportamento esperado.
- **Interface Segregation**: interfaces específicas são melhores que uma interface genérica gigante que força implementações desnecessárias.
- **Dependency Inversion**: depender de abstrações, não de implementações concretas específicas.

SOLID é um guia, não uma lei rígida — aplicar cada princípio ao extremo em todo lugar pode criar abstrações desnecessárias para problemas simples. O objetivo final (código flexível e desacoplado) importa mais que seguir a letra do princípio.

## DRY (Don't Repeat Yourself) e seu limite

Evitar duplicar a mesma lógica em vários lugares — centralizando em uma função/módulo reutilizável — reduz o risco de uma correção ser aplicada em um lugar e esquecida em outro. Porém, DRY aplicado cedo demais, sobre código ainda não totalmente compreendido, pode criar uma abstração genérica errada que precisa ser desfeita depois. Às vezes, duplicar um pouco de código simples por enquanto é melhor que forçar uma abstração prematura complicada.

## KISS (Keep It Simple) e quando ele compete com DRY

KISS defende a solução mais simples que resolve o problema atual. DRY e KISS podem competir: eliminar toda duplicação às vezes exige uma abstração genérica mais complexa, o que vai contra a simplicidade. Bom senso de engenharia é balancear os dois conforme o contexto — não existe uma regra universal que resolve esse trade-off automaticamente.

## O que observar em um Pull Request

- **Tratamento de erros**: a lógica lida com casos de falha (dado inválido, dependência externa fora do ar), ou só cobre o caminho feliz?
- **Testes**: as mudanças têm cobertura adequada, incluindo casos de borda e cenários de erro?
- **Performance**: existe alguma query em loop (N+1), processamento redundante, ou dado carregado além do necessário?
- **Segurança**: os dados de entrada são validados no backend? Há informação sensível exposta em logs ou respostas de erro?
- **Manutenibilidade**: outra pessoa da equipe conseguiria entender e alterar esse código daqui a 6 meses, sem precisar perguntar ao autor original?

## Feedback construtivo: bloqueante vs. sugestão

Um bom review distingue claramente entre:
- **Bloqueante**: precisa ser corrigido antes do merge (um bug real, uma falha de segurança).
- **Sugestão**: um nice-to-have que pode ser feito depois, sem impedir a aprovação.

Comentários vagos ("isso está estranho") ajudam menos que comentários específicos com uma sugestão concreta ("esse loop gera uma query por item — considere usar eager loading aqui").

## As três perguntas de um bom review

1. **Isso vai quebrar em produção?** (correção)
2. **Outra pessoa do time entenderia esse código sem contexto extra?** (manutenibilidade)
3. **Os casos de falha foram tratados e testados, não só o caminho feliz?** (robustez)

## Erros comuns

- Focar só em estilo/formatação (que ferramentas automáticas já deveriam cobrir) e ignorar problemas reais de lógica ou segurança.
- Aplicar princípios como SOLID/DRY de forma dogmática, criando complexidade desnecessária para problemas simples.
- Dar feedback vago, sem sugestão concreta de como melhorar.
- Não distinguir entre comentário bloqueante e sugestão, deixando o autor sem saber o que realmente precisa corrigir antes do merge.

## Checklist rápido

- [ ] Ao revisar, penso nas três perguntas centrais (quebra, entendimento, robustez)
- [ ] Distingo claramente comentários bloqueantes de sugestões
- [ ] Aplico SOLID/DRY/KISS com bom senso, não como regras absolutas
- [ ] Meus comentários de review incluem sugestões concretas, não só apontam o problema$md$,
  updated_at = now()
where slug = 'semana-5-code-review';

update public.study_contents set
  content = $md$# Preparação para Entrevista

## Objetivo desta aula

Consolidar, em um checklist final, tudo que foi estudado ao longo das cinco semanas — organizando a revisão de véspera de entrevista de forma eficiente, sem tentar reaprender tudo do zero na última hora.

## Checklist técnico consolidado

**Python**: estruturas de dados e complexidade, os quatro pilares da POO, decoradores e geradores, ambientes virtuais.

**Assincronismo & FastAPI**: concorrência vs. paralelismo, Event Loop, Depends para injeção de dependências, validação automática com Pydantic.

**Persistência & SQLAlchemy**: relacionamentos (1:1, 1:N, N:N), o problema N+1 e como evitá-lo (`selectinload`/`joinedload`), migrations com Alembic.

**Mensageria & Cache**: cache hit/miss, estratégias de invalidação, filas com Celery, idempotência.

**Testes**: unitários vs. integração, fixtures, mocking, testar erros além do caminho feliz.

**Frontend (HTML/CSS/Tailwind/JS)**: semântica e acessibilidade, Box Model e especificidade, Flexbox vs. Grid, closures, Event Loop no JavaScript (microtasks/macrotasks).

**React**: Virtual DOM e reconciliation, imutabilidade de estado, `useEffect` com cleanup correto, quando `useMemo`/`useCallback` realmente ajudam, Context API e seus limites.

**TypeScript**: `Partial`/`Pick`/`Omit`, generics, discriminated unions, type narrowing.

**Integração Full Stack**: loading/empty/error sempre tratados, services/hooks centralizando chamadas de API.

**DevOps**: Dockerfile e multi-stage build, Pod/Deployment/Service no Kubernetes, pipeline de CI/CD, REST e paginação, Git (rebase vs. merge), Scrum vs. Kanban.

**System Design**: cache, índices, filas, load balancing, CDN — e saber identificar o gargalo real antes de propor uma solução.

## Projetos do portfólio: o que ter pronto

Para cada projeto real seu, tenha preparado: o problema que ele resolve, as decisões de arquitetura e por quê, pelo menos um desafio técnico real enfrentado e como foi resolvido, e o que você faria diferente hoje. Revisar os próprios projetos em detalhe é tão importante quanto revisar teoria — é sobre eles que a conversa técnica provavelmente vai se aprofundar.

## Perguntas comportamentais: revisão rápida

Revise as histórias preparadas com o método STAR (aula anterior): um desafio técnico difícil, um conflito com colega tratado profissionalmente, um aprendizado rápido sob prazo. Garanta que cada história tem Situação, Tarefa, Ação (em primeira pessoa) e Resultado claros.

## Apresentação pessoal: a estrutura, não o texto decorado

Prepare uma resposta concisa (1-2 minutos) para "fale sobre você", conectando: quem você é, sua trajetória de estudo/experiência, tecnologias, um projeto principal, e o que busca na próxima oportunidade. O objetivo é ter a **estrutura** internalizada, adaptando as palavras naturalmente a cada conversa — não decorar um texto fixo, que soa artificial e trava diante de qualquer variação na pergunta.

## Por que entender conceitos vale mais que decorar respostas

Entrevistadores frequentemente fazem perguntas de acompanhamento ou pequenas variações do cenário original. Quem decorou uma resposta pronta trava diante de qualquer mudança; quem entende o conceito de verdade consegue adaptar o raciocínio a um cenário levemente diferente — e é exatamente essa adaptação que demonstra domínio real, não memorização.

## Roteiro sugerido para a véspera

1. Revisar este checklist, marcando o que já está confortável e o que precisa de reforço.
2. Reler os próprios projetos (código e README), refrescando os detalhes.
3. Praticar em voz alta pelo menos 2-3 das histórias comportamentais.
4. Revisar as perguntas técnicas mais desafiadoras já respondidas no banco de questões.
5. Dormir bem — cansaço prejudica mais a clareza de raciocínio do que qualquer lacuna pontual de conteúdo.

## Erros comuns

- Tentar revisar tudo com a mesma profundidade na véspera, em vez de focar no que ainda não está sólido.
- Decorar respostas fixas em vez de internalizar a estrutura e os conceitos.
- Negligenciar a revisão dos próprios projetos, focando só em teoria genérica.
- Deixar a preparação comportamental para a última hora, tratando-a como menos importante que a técnica.

## Checklist final

- [ ] Revisei os tópicos técnicos das 5 semanas e sei apontar onde ainda tenho dúvida
- [ ] Tenho as informações-chave dos meus projetos reais organizadas e acessíveis
- [ ] Pratiquei minhas histórias comportamentais em voz alta
- [ ] Tenho minha apresentação pessoal estruturada (não decorada) e ensaiada
- [ ] Sei explicar, com minhas palavras, os conceitos das 5 semanas — não só repetir definições$md$,
  updated_at = now()
where slug = 'semana-5-preparacao-entrevista';
