-- ============================================================
-- ReviseTI — PROMPT 02: conteúdo completo das 5 semanas
-- Rode este arquivo no SQL Editor do Supabase DEPOIS de 0001_init.sql
-- Idempotente: pode ser executado mais de uma vez sem duplicar dados.
-- ============================================================

-- ------------------------------------------------------------
-- 1. EXTENDER study_contents (idempotente via IF NOT EXISTS)
-- ------------------------------------------------------------
alter table public.study_contents add column if not exists day_name text;
alter table public.study_contents add column if not exists topic_count integer not null default 0;
alter table public.study_contents add column if not exists metadata jsonb not null default '{}'::jsonb;

-- ------------------------------------------------------------
-- 2. TABELA content_topics
-- ------------------------------------------------------------
create table if not exists public.content_topics (
  id uuid primary key default gen_random_uuid(),
  content_id uuid not null references public.study_contents(id) on delete cascade,
  title text not null,
  description text,
  order_index integer not null default 0,
  created_at timestamptz not null default now()
);

alter table public.content_topics enable row level security;

drop policy if exists "content_topics_select_authenticated" on public.content_topics;
create policy "content_topics_select_authenticated" on public.content_topics
  for select using (auth.role() = 'authenticated');
-- Sem policy de insert/update/delete para usuários comuns: tópicos são
-- conteúdo oficial, administrado por seed/migration, igual study_contents.

create index if not exists idx_content_topics_content_id on public.content_topics(content_id);

-- ------------------------------------------------------------
-- 3. SEED — conteúdo completo (idempotente por slug)
-- ------------------------------------------------------------
-- Garante que as 25 aulas existam (caso 0001_init.sql já tenha rodado,
-- isso apenas mantém; caso não, insere do zero).

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (1, 1, 'Segunda-feira', 'Core Python & POO', 'semana-1-core-python-poo', 'Estruturas de dados nativas, complexidade e os quatro pilares da Programação Orientada a Objetos.', 90, 1)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Segunda-feira',
  description = 'Estruturas de dados nativas, complexidade e os quatro pilares da Programação Orientada a Objetos.',
  content = $md$# Core Python & POO

Antes de qualquer framework, uma pessoa desenvolvedora Full Stack precisa dominar as estruturas de dados nativas do Python e os fundamentos de orientação a objetos — é o que sustenta tudo que vem depois (FastAPI, SQLAlchemy, testes).

## Estruturas de dados

- **Listas** (`list`): coleção **mutável** e ordenada. Ótima para quando você precisa adicionar, remover ou alterar itens.
- **Tuplas** (`tuple`): coleção **imutável** e ordenada. Use quando os dados não devem mudar (ex: coordenadas, configurações fixas).
- **Dicionários** (`dict`): pares chave-valor, mutáveis. A estrutura mais usada para representar objetos/registros.
- **Sets** (`set`): coleção não ordenada de itens **únicos** — ideal para eliminar duplicatas e testar pertencimento rapidamente.

```python
nomes = ["Ana", "João", "Maria"]   # lista: mutável
ponto = (10, 20)                    # tupla: imutável
usuario = {"nome": "Ana", "idade": 28}  # dict
ids_unicos = {1, 2, 2, 3}           # set -> {1, 2, 3}
```

## Complexidade

Pense em quanto tempo uma operação leva conforme os dados crescem (notação Big O). Buscar um item em uma lista é O(n) — no pior caso, percorre tudo. Buscar uma chave em um dicionário ou item em um set é O(1) em média, graças ao hashing. Essa diferença importa muito quando o volume de dados cresce.

## Mutabilidade e imutabilidade

Objetos mutáveis (listas, dicts, sets) podem ser alterados depois de criados; objetos imutáveis (tuplas, strings, números) não. Isso afeta como o Python lida com cópias: alterar uma lista dentro de uma função altera a lista original (mesma referência), enquanto uma tupla nunca muda.

## Pilares da POO

- **Herança**: uma classe filha reaproveita comportamento de uma classe pai.
- **Polimorfismo**: objetos de classes diferentes respondem ao mesmo método de formas diferentes.
- **Encapsulamento**: esconder detalhes internos de implementação, expondo só o necessário.
- **Abstração**: modelar o essencial de um conceito, ignorando detalhes irrelevantes ao contexto.

```python
class Animal:
    def emitir_som(self):
        raise NotImplementedError

class Cachorro(Animal):
    def emitir_som(self):
        return "Woof"

class Gato(Animal):
    def emitir_som(self):
        return "Miau"
```

## Decoradores, geradores e yield

Decoradores envolvem uma função para adicionar comportamento sem alterar seu código (`@app.get("/rota")` no FastAPI é um decorador). Geradores, criados com `yield`, produzem valores um de cada vez, sob demanda — economizando memória ao lidar com sequências grandes.

```python
def contador(limite):
    n = 0
    while n < limite:
        yield n
        n += 1
```

## Ambientes virtuais

Um ambiente virtual (`venv`) isola as dependências de um projeto Python das demais instalações do sistema, evitando conflitos de versão entre projetos diferentes.

```bash
python -m venv .venv
source .venv/bin/activate  # Linux/Mac
.venv\Scripts\activate     # Windows
```

## Pontos importantes

- Prefira dicionários/sets quando precisar de busca rápida por chave.
- Use tuplas para dados que não devem ser alterados.
- Domine os quatro pilares da POO antes de avançar para frameworks — eles aparecem o tempo todo em bibliotecas como SQLAlchemy e FastAPI.
- Sempre trabalhe dentro de um ambiente virtual por projeto.$md$,
  topic_count = 15,
  updated_at = now()
where slug = 'semana-1-core-python-poo';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-1-core-python-poo');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Listas', 0),
  ('Tuplas', 1),
  ('Dicionários', 2),
  ('Sets', 3),
  ('Complexidade', 4),
  ('Mutabilidade', 5),
  ('Imutabilidade', 6),
  ('Herança', 7),
  ('Polimorfismo', 8),
  ('Encapsulamento', 9),
  ('Abstração', 10),
  ('Decoradores', 11),
  ('Geradores', 12),
  ('yield', 13),
  ('Ambientes virtuais', 14)
) as t(title, order_index)
where study_contents.slug = 'semana-1-core-python-poo';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (1, 2, 'Terça-feira', 'Assincronismo & FastAPI', 'semana-1-assincronismo-fastapi', 'Concorrência vs. paralelismo, o Event Loop, e como construir APIs modernas com FastAPI.', 90, 2)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Terça-feira',
  description = 'Concorrência vs. paralelismo, o Event Loop, e como construir APIs modernas com FastAPI.',
  content = $md$# Assincronismo & FastAPI

## Concorrência vs. paralelismo

**Concorrência** é lidar com várias tarefas ao mesmo tempo, alternando entre elas (útil quando a maior parte do tempo é esperando I/O, como uma requisição de rede). **Paralelismo** é executar várias tarefas literalmente ao mesmo tempo, em núcleos diferentes do processador (útil para processamento pesado de CPU). Uma API web passa a maior parte do tempo esperando banco de dados e rede — por isso o assincronismo (concorrência) rende tanto ali.

## Event Loop, async e await

O **Event Loop** é o mecanismo que permite ao Python alternar entre tarefas assíncronas sem bloquear a thread principal. Uma função declarada com `async def` retorna uma *coroutine*; `await` pausa a execução daquela função até o resultado estar pronto, liberando o Event Loop para atender outras requisições nesse meio-tempo.

```python
async def buscar_usuario(id: int):
    usuario = await db.fetch_one("SELECT * FROM users WHERE id = :id", {"id": id})
    return usuario
```

## FastAPI

FastAPI é um framework para construir APIs em Python, construído sobre Starlette e Pydantic, com suporte nativo a `async`/`await` e documentação automática (Swagger/OpenAPI).

### APIRouter

Organiza rotas em módulos separados, evitando um único arquivo gigante:

```python
from fastapi import APIRouter

router = APIRouter(prefix="/reviews", tags=["reviews"])

@router.get("/")
async def listar_revisoes():
    return {"reviews": []}
```

### Depends (injeção de dependências)

`Depends` permite reaproveitar lógica (autenticação, conexão de banco) entre várias rotas sem repetir código:

```python
from fastapi import Depends

async def get_current_user(token: str):
    return decode_token(token)

@router.get("/me")
async def meu_perfil(user = Depends(get_current_user)):
    return user
```

### Pydantic e validação

Pydantic define o formato esperado dos dados de entrada e saída usando classes Python tipadas. O FastAPI valida automaticamente o corpo da requisição contra esse modelo.

```python
from pydantic import BaseModel

class ReviewCreate(BaseModel):
    title: str
    minutes: int
```

### HTTP 422

Quando os dados enviados não batem com o modelo Pydantic, o FastAPI retorna automaticamente **422 Unprocessable Entity**, com os detalhes de qual campo falhou na validação.

## Pontos importantes

- Use `async`/`await` para operações de I/O (banco, rede, arquivos), não para processamento pesado de CPU.
- `Depends` é a forma idiomática de reaproveitar lógica entre rotas no FastAPI.
- Um 422 quase sempre significa "os dados enviados não batem com o schema esperado".$md$,
  topic_count = 12,
  updated_at = now()
where slug = 'semana-1-assincronismo-fastapi';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-1-assincronismo-fastapi');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Concorrência', 0),
  ('Paralelismo', 1),
  ('async', 2),
  ('await', 3),
  ('Event Loop', 4),
  ('I/O', 5),
  ('FastAPI', 6),
  ('Depends', 7),
  ('APIRouter', 8),
  ('Pydantic', 9),
  ('Validação', 10),
  ('HTTP 422', 11)
) as t(title, order_index)
where study_contents.slug = 'semana-1-assincronismo-fastapi';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (1, 3, 'Quarta-feira', 'Persistência de Dados & SQLAlchemy', 'semana-1-persistencia-sqlalchemy', 'ORM, modelagem de relacionamentos, estratégias de carregamento e migrations com Alembic.', 90, 3)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Quarta-feira',
  description = 'ORM, modelagem de relacionamentos, estratégias de carregamento e migrations com Alembic.',
  content = $md$# Persistência de Dados & SQLAlchemy

## O que é um ORM

Um **ORM** (Object-Relational Mapper) traduz tabelas do banco relacional em classes Python, e linhas em instâncias dessas classes — você manipula objetos Python em vez de escrever SQL cru para cada operação. O **SQLAlchemy** é o ORM mais usado no ecossistema Python.

```python
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class Review(Base):
    __tablename__ = "reviews"
    id: Mapped[int] = mapped_column(primary_key=True)
    title: Mapped[str]
    user_id: Mapped[int]
```

## Relacionamentos

- **1:1** — um registro se relaciona com exatamente um outro (ex: usuário e seu perfil estendido).
- **1:N** — um registro se relaciona com vários outros (ex: um usuário tem várias revisões).
- **N:N** — vários registros de um lado se relacionam com vários do outro, geralmente via tabela associativa (ex: aulas e tags).

```python
class User(Base):
    __tablename__ = "users"
    id: Mapped[int] = mapped_column(primary_key=True)
    reviews: Mapped[list["Review"]] = relationship(back_populates="user")
```

## Lazy vs. Eager Loading

**Lazy loading** busca os dados relacionados só quando você acessa o atributo — simples, mas pode gerar o problema "N+1 queries" (uma query extra para cada item de uma lista). **Eager loading** já traz os dados relacionados na mesma query inicial:

- `joinedload`: usa um `JOIN` para trazer tudo em uma única query — bom para relacionamentos 1:1 ou 1:N pequenos.
- `selectinload`: faz uma segunda query com `IN (...)` para buscar os relacionados em lote — geralmente melhor para listas maiores, evita duplicar linhas.

```python
from sqlalchemy.orm import selectinload

stmt = select(User).options(selectinload(User.reviews))
```

## Sessões

A `Session` do SQLAlchemy é o objeto que gerencia a "unidade de trabalho": rastreia objetos carregados, agrupa mudanças e as envia ao banco em uma transação com `commit()`.

## Alembic e Migrations

Alembic é a ferramenta de migrations do SQLAlchemy: gera e versiona scripts que alteram o schema do banco de forma incremental e reversível, mantendo o banco sincronizado com os modelos ao longo do tempo.

```bash
alembic revision --autogenerate -m "cria tabela reviews"
alembic upgrade head
```

## Pontos importantes

- Prefira `selectinload` quando for carregar listas de relacionados; `joinedload` para relacionamentos únicos.
- Toda mudança de schema em produção deve passar por uma migration versionada, nunca um `ALTER TABLE` manual e não rastreado.$md$,
  topic_count = 14,
  updated_at = now()
where slug = 'semana-1-persistencia-sqlalchemy';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-1-persistencia-sqlalchemy');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('ORM', 0),
  ('SQLAlchemy', 1),
  ('Modelos', 2),
  ('Relacionamentos', 3),
  ('1:1', 4),
  ('1:N', 5),
  ('N:N', 6),
  ('Lazy Loading', 7),
  ('Eager Loading', 8),
  ('joinedload', 9),
  ('selectinload', 10),
  ('Sessões', 11),
  ('Alembic', 12),
  ('Migrations', 13)
) as t(title, order_index)
where study_contents.slug = 'semana-1-persistencia-sqlalchemy';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (1, 4, 'Quinta-feira', 'Mensageria, Cache & Performance', 'semana-1-mensageria-cache', 'Redis como cache, Celery para processamento em background e estratégias de invalidação.', 90, 4)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Quinta-feira',
  description = 'Redis como cache, Celery para processamento em background e estratégias de invalidação.',
  content = $md$# Mensageria, Cache & Performance

## Redis e cache

Redis é um banco de dados em memória, usado principalmente como **cache**: guarda resultados de operações custosas (queries pesadas, chamadas a APIs externas) para respostas quase instantâneas em acessos repetidos.

```python
import redis
r = redis.Redis()

def get_dashboard(user_id: int):
    chave = f"dashboard:{user_id}"
    cache = r.get(chave)
    if cache:
        return cache
    dados = calcular_dashboard_caro(user_id)
    r.set(chave, dados, ex=300)  # expira em 5 minutos
    return dados
```

### Quando usar cache

Vale a pena cachear dados que são **lidos com frequência** e **caros de calcular**, mas que **não mudam a cada request**. Dados críticos e sempre atualizados (ex: saldo bancário em tempo real) exigem mais cuidado.

### Invalidação de cache

O ponto mais difícil de cache não é guardar — é saber quando **invalidar**. Estratégias comuns: expiração por tempo (TTL), invalidação explícita quando o dado muda, ou versionamento de chave.

## Celery, filas e background tasks

**Celery** é uma fila de tarefas distribuída: em vez de processar algo pesado (enviar email, gerar relatório, redimensionar imagem) durante a requisição HTTP — deixando o usuário esperando — você enfileira a tarefa e um *worker* separado a processa em background.

```python
from celery import Celery

app = Celery("tasks", broker="redis://localhost:6379/0")

@app.task
def enviar_email_boas_vindas(usuario_id: int):
    ...  # processa fora do ciclo da requisição
```

O FastAPI também tem `BackgroundTasks`, mais simples, para tarefas leves que não precisam de retry ou fila persistente.

## Performance

Cache e processamento assíncrono são duas das ferramentas mais efetivas para performance: reduzem trabalho repetido e tiram tarefas lentas do caminho crítico da resposta ao usuário.

## Pontos importantes

- Cache resolve leitura repetida de dados caros; filas resolvem processamento pesado que não precisa bloquear a resposta.
- Sempre defina uma estratégia de expiração/invalidação — cache sem invalidação vira uma fonte de dados desatualizados.$md$,
  topic_count = 10,
  updated_at = now()
where slug = 'semana-1-mensageria-cache';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-1-mensageria-cache');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Redis', 0),
  ('Cache', 1),
  ('Celery', 2),
  ('Background Tasks', 3),
  ('Filas', 4),
  ('Processamento assíncrono', 5),
  ('Performance', 6),
  ('Quando utilizar cache', 7),
  ('Invalidação de cache', 8),
  ('Jobs em background', 9)
) as t(title, order_index)
where study_contents.slug = 'semana-1-mensageria-cache';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (1, 5, 'Sexta-feira', 'Testes Automatizados com Pytest', 'semana-1-testes-pytest', 'Testes unitários, de integração, fixtures, mocks e os principais status HTTP em testes de API.', 90, 5)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Sexta-feira',
  description = 'Testes unitários, de integração, fixtures, mocks e os principais status HTTP em testes de API.',
  content = $md$# Testes Automatizados com Pytest

## Testes unitários vs. de integração

**Testes unitários** verificam uma unidade isolada de código (uma função, um método), geralmente sem tocar banco de dados ou rede. **Testes de integração** verificam como várias partes trabalham juntas — por exemplo, uma rota da API completa, do request até a resposta, passando pelo banco de verdade (ou um de teste).

```python
def somar(a, b):
    return a + b

def test_somar():
    assert somar(2, 3) == 5
```

## Fixtures

Fixtures no Pytest preparam o contexto necessário para um teste (ex: um cliente HTTP de teste, uma sessão de banco limpa) e são reaproveitadas entre vários testes:

```python
import pytest
from fastapi.testclient import TestClient
from main import app

@pytest.fixture
def client():
    return TestClient(app)

def test_listar_revisoes(client):
    response = client.get("/reviews")
    assert response.status_code == 200
```

## Mocking

Mocking substitui uma dependência real (uma API externa, um envio de email) por uma versão falsa e controlada, para testar seu código sem depender de sistemas externos instáveis ou lentos.

```python
from unittest.mock import patch

@patch("app.services.enviar_email")
def test_cadastro_dispara_email(mock_email, client):
    client.post("/register", json={"email": "a@a.com"})
    mock_email.assert_called_once()
```

## Testes de API e status HTTP

Ao testar endpoints, verificar o status HTTP correto é essencial:

- **200 OK** — sucesso em uma leitura (GET).
- **201 Created** — sucesso ao criar um recurso (POST).
- **400 Bad Request** — a requisição está malformada.
- **404 Not Found** — o recurso solicitado não existe.
- **422 Unprocessable Entity** — os dados não passaram na validação (comum no FastAPI/Pydantic).

## Estratégia de testes

Uma boa estratégia combina muitos testes unitários rápidos (base da pirâmide), um número moderado de testes de integração, e poucos testes end-to-end mais lentos — priorizando cobrir os fluxos críticos da aplicação.

## Pontos importantes

- Teste o comportamento esperado **e** os casos de erro (não só o "caminho feliz").
- Fixtures evitam repetição de setup entre testes.
- Use mocks para isolar seu código de serviços externos não confiáveis durante os testes.$md$,
  topic_count = 11,
  updated_at = now()
where slug = 'semana-1-testes-pytest';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-1-testes-pytest');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Testes unitários', 0),
  ('Testes de integração', 1),
  ('Fixtures', 2),
  ('Mocking', 3),
  ('Testes de API', 4),
  ('HTTP 200', 5),
  ('HTTP 201', 6),
  ('HTTP 400', 7),
  ('HTTP 404', 8),
  ('HTTP 422', 9),
  ('Estratégia de testes', 10)
) as t(title, order_index)
where study_contents.slug = 'semana-1-testes-pytest';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (2, 1, 'Segunda-feira', 'HTML5 Semântico & Acessibilidade', 'semana-2-html5-acessibilidade', 'Tags semânticas, formulários acessíveis e como o navegador constrói a página.', 90, 6)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Segunda-feira',
  description = 'Tags semânticas, formulários acessíveis e como o navegador constrói a página.',
  content = $md$# HTML5 Semântico & Acessibilidade

## Por que HTML semântico

Usar a tag certa para cada função (em vez de `<div>` para tudo) ajuda leitores de tela, motores de busca e outros desenvolvedores a entender a estrutura da página sem precisar ler classes CSS.

```html
<header>...</header>
<nav>...</nav>
<main>
  <section>
    <article>...</article>
  </section>
</main>
<footer>...</footer>
```

- **header**: cabeçalho da página ou de uma seção.
- **nav**: bloco de navegação principal.
- **main**: conteúdo principal e único da página.
- **section**: agrupamento temático de conteúdo.
- **article**: conteúdo independente, que faz sentido sozinho (um post, uma notícia).
- **footer**: rodapé da página ou seção.

## Formulários e labels

Todo campo de formulário deve ter um `<label>` associado — isso permite que leitores de tela anunciem o propósito do campo, e que clicar no texto foque o input.

```html
<label for="email">Email</label>
<input id="email" type="email" required />
```

## Acessibilidade

Acessibilidade (a11y) significa construir interfaces que qualquer pessoa consiga usar, incluindo quem usa leitor de tela, navega só por teclado, ou tem baixa visão. Elementos semânticos, contraste adequado, `alt` em imagens e foco visível em elementos interativos são a base.

## SEO

Motores de busca leem a estrutura semântica para entender do que trata a página. `<h1>` único por página, hierarquia correta de headings e `<meta description>` ajudam no ranqueamento.

## DOM e carregamento da página

O **DOM** (Document Object Model) é a representação em árvore do HTML que o navegador constrói e que o JavaScript manipula. O navegador processa o HTML de cima para baixo: por isso scripts que manipulam elementos costumam ficar no fim do `<body>` ou usar `defer`, para garantir que o DOM já exista.

## Pontos importantes

- Um `<div>` não comunica nada; escolha a tag semântica correspondente sempre que existir uma.
- Todo input precisa de label associado — não é opcional para acessibilidade.
- HTML bem estruturado beneficia acessibilidade e SEO ao mesmo tempo.$md$,
  topic_count = 13,
  updated_at = now()
where slug = 'semana-2-html5-acessibilidade';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-2-html5-acessibilidade');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('HTML semântico', 0),
  ('header', 1),
  ('nav', 2),
  ('main', 3),
  ('section', 4),
  ('article', 5),
  ('footer', 6),
  ('formulários', 7),
  ('labels', 8),
  ('acessibilidade', 9),
  ('SEO', 10),
  ('DOM', 11),
  ('carregamento da página', 12)
) as t(title, order_index)
where study_contents.slug = 'semana-2-html5-acessibilidade';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (2, 2, 'Terça-feira', 'CSS3 Avançado & Layouts', 'semana-2-css3-layouts', 'Cascata, especificidade, box model e os dois principais sistemas de layout: Flexbox e Grid.', 90, 7)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Terça-feira',
  description = 'Cascata, especificidade, box model e os dois principais sistemas de layout: Flexbox e Grid.',
  content = $md$# CSS3 Avançado & Layouts

## Cascata e especificidade

CSS significa "Cascading Style Sheets" — quando várias regras se aplicam ao mesmo elemento, a **cascata** decide qual vence, com base em origem, especificidade e ordem no código. **Especificidade** é calculada por tipo de seletor: um ID (`#id`) pesa mais que uma classe (`.classe`), que pesa mais que um seletor de elemento (`div`).

## Box Model

Todo elemento é uma caixa composta por: **conteúdo** → **padding** (espaço interno) → **border** (borda) → **margin** (espaço externo). Entender essa ordem evita surpresas de tamanho e espaçamento.

```css
.card {
  padding: 16px;
  border: 1px solid #e2e8f0;
  margin-bottom: 12px;
  box-sizing: border-box; /* padding e border não somam ao width definido */
}
```

## Display, Flexbox e Grid

`display` define como um elemento se comporta no layout (`block`, `inline`, `flex`, `grid`...).

**Flexbox** organiza itens em uma única dimensão (linha ou coluna) — ótimo para barras de navegação, cards em linha, alinhamento vertical/horizontal:

```css
.container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
}
```

**Grid** organiza itens em duas dimensões (linhas e colunas simultaneamente) — ideal para layouts de página inteira:

```css
.grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
}
```

## Position

`static` (padrão, segue o fluxo normal), `relative` (desloca em relação à própria posição original), `absolute` (posiciona em relação ao ancestral posicionado mais próximo), `fixed` (fixo na tela, ignora o scroll).

## Responsividade e Media Queries

Media queries aplicam estilos condicionalmente conforme o tamanho da tela, permitindo layouts que se adaptam de mobile a desktop:

```css
.sidebar { display: none; }

@media (min-width: 1024px) {
  .sidebar { display: block; }
}
```

## Pontos importantes

- Use Flexbox para alinhar itens em uma linha/coluna; Grid para estruturar a página em duas dimensões.
- `box-sizing: border-box` evita que padding/border estourem o tamanho esperado do elemento.
- Pense mobile-first: comece com o estilo para telas pequenas e adicione media queries para telas maiores.$md$,
  topic_count = 12,
  updated_at = now()
where slug = 'semana-2-css3-layouts';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-2-css3-layouts');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Cascata', 0),
  ('Especificidade', 1),
  ('Box Model', 2),
  ('Margin', 3),
  ('Padding', 4),
  ('Border', 5),
  ('Display', 6),
  ('Flexbox', 7),
  ('Grid', 8),
  ('Position', 9),
  ('Responsividade', 10),
  ('Media Queries', 11)
) as t(title, order_index)
where study_contents.slug = 'semana-2-css3-layouts';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (2, 3, 'Quarta-feira', 'Tailwind CSS & Responsividade', 'semana-2-tailwind-responsividade', 'Utility classes, mobile-first e como compor layouts responsivos sem sair do HTML/JSX.', 90, 8)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Quarta-feira',
  description = 'Utility classes, mobile-first e como compor layouts responsivos sem sair do HTML/JSX.',
  content = $md$# Tailwind CSS & Responsividade

## Utility classes

Tailwind é um framework CSS "utility-first": em vez de escrever CSS customizado, você compõe classes pequenas e específicas diretamente na marcação (`flex`, `px-4`, `text-sm`, `rounded-xl`). Isso reduz a necessidade de nomear classes e manter arquivos CSS separados.

```html
<button class="rounded-xl bg-brand-600 px-4 py-2.5 text-sm font-semibold text-white hover:bg-brand-700">
  Salvar
</button>
```

## Mobile first e breakpoints

Tailwind é mobile-first por padrão: classes sem prefixo valem para qualquer tamanho de tela, e prefixos (`sm:`, `md:`, `lg:`, `xl:`) aplicam a partir daquele breakpoint para cima.

```html
<div class="flex flex-col gap-4 lg:flex-row">
  <!-- empilhado no mobile, lado a lado a partir de "lg" -->
</div>
```

## Flex e Grid no Tailwind

As mesmas ideias de Flexbox e Grid do CSS puro, só que como classes utilitárias:

```html
<div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
  <!-- 1 coluna no mobile, 2 no tablet, 3 no desktop -->
</div>
```

## Espaçamento e tipografia

Tailwind usa uma escala consistente de espaçamento (`p-1` até `p-96`, incrementos de 0.25rem) e tipografia (`text-xs` até `text-9xl`), o que ajuda a manter consistência visual sem decidir valores arbitrários a cada componente.

## Estados

Classes de estado (`hover:`, `focus:`, `disabled:`, `dark:`) aplicam estilos condicionalmente sem precisar de CSS separado ou JavaScript:

```html
<input class="border focus:border-brand-500 disabled:opacity-60" />
```

## Componentização visual

Como Tailwind não gera classes semânticas próprias, a organização visual normalmente acontece via componentes de UI reutilizáveis (React, Vue) que encapsulam a combinação de classes — em vez de duplicar longas strings de classes em todo lugar.

## Pontos importantes

- Pense mobile-first: escreva a versão mobile sem prefixo, e adicione `sm:`/`lg:` só onde o layout muda.
- Prefira extrair um componente reutilizável a duplicar a mesma combinação longa de classes.$md$,
  topic_count = 11,
  updated_at = now()
where slug = 'semana-2-tailwind-responsividade';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-2-tailwind-responsividade');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Utility Classes', 0),
  ('Mobile First', 1),
  ('Breakpoints', 2),
  ('Responsive Design', 3),
  ('Layouts', 4),
  ('Flex', 5),
  ('Grid', 6),
  ('Espaçamento', 7),
  ('Tipografia', 8),
  ('Estados', 9),
  ('Componentização visual', 10)
) as t(title, order_index)
where study_contents.slug = 'semana-2-tailwind-responsividade';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (2, 4, 'Quinta-feira', 'Core do JavaScript', 'semana-2-core-javascript', 'Declaração de variáveis, escopo, closures e manipulação do DOM.', 90, 9)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Quinta-feira',
  description = 'Declaração de variáveis, escopo, closures e manipulação do DOM.',
  content = $md$# Core do JavaScript

## var, let e const

`var` tem escopo de função e sofre *hoisting* (é "içada" para o topo, podendo ser usada antes de ser declarada — com valor `undefined`). `let` e `const` têm escopo de bloco (`{ }`) e não podem ser usadas antes da declaração. `const` impede reatribuição da variável (mas não torna o conteúdo imutável, se for um objeto).

```javascript
console.log(x); // undefined (hoisting)
var x = 10;

console.log(y); // ReferenceError
let y = 10;
```

## Scope (escopo)

Escopo define onde uma variável é visível. Variáveis declaradas dentro de uma função ou bloco só existem ali (com `let`/`const`); variáveis globais são visíveis em todo o arquivo.

## Closure

Uma closure acontece quando uma função "lembra" do escopo em que foi criada, mesmo depois que esse escopo já terminou de executar:

```javascript
function criarContador() {
  let contagem = 0;
  return function () {
    contagem++;
    return contagem;
  };
}

const contador = criarContador();
contador(); // 1
contador(); // 2
```

## DOM, querySelector e eventos

O JavaScript manipula o DOM (a árvore de elementos da página) para reagir a interações e atualizar a interface dinamicamente:

```javascript
const botao = document.querySelector("#salvar");

botao.addEventListener("click", () => {
  botao.textContent = "Salvo!";
});
```

`querySelector` busca o primeiro elemento que bate com um seletor CSS. `addEventListener` registra uma função a ser chamada quando um evento (clique, envio de formulário, tecla pressionada) acontece.

## Pontos importantes

- Prefira `const` por padrão, e `let` só quando a variável realmente precisa ser reatribuída. Evite `var` em código novo.
- Closures são a base de padrões como debounce, memoização e hooks do React.$md$,
  topic_count = 11,
  updated_at = now()
where slug = 'semana-2-core-javascript';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-2-core-javascript');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('var', 0),
  ('let', 1),
  ('const', 2),
  ('Hoisting', 3),
  ('Scope', 4),
  ('Closure', 5),
  ('DOM', 6),
  ('querySelector', 7),
  ('addEventListener', 8),
  ('Eventos', 9),
  ('Manipulação de elementos', 10)
) as t(title, order_index)
where study_contents.slug = 'semana-2-core-javascript';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (2, 5, 'Sexta-feira', 'JavaScript Assíncrono', 'semana-2-javascript-assincrono', 'Métodos funcionais de array, o Event Loop, Promises e async/await.', 90, 10)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Sexta-feira',
  description = 'Métodos funcionais de array, o Event Loop, Promises e async/await.',
  content = $md$# JavaScript Assíncrono

## Métodos funcionais de array

Esses métodos percorrem um array sem mutá-lo, retornando um novo resultado — a base de código funcional e declarativo em JS:

```javascript
const numeros = [1, 2, 3, 4, 5];

numeros.map(n => n * 2);          // [2, 4, 6, 8, 10]
numeros.filter(n => n % 2 === 0); // [2, 4]
numeros.reduce((soma, n) => soma + n, 0); // 15
numeros.find(n => n > 3);         // 4
numeros.some(n => n > 4);         // true
numeros.forEach(n => console.log(n)); // efeito colateral, sem retorno
```

## Event Loop, microtasks e macrotasks

O JavaScript é single-threaded, mas lida com assincronismo via **Event Loop**. Tarefas assíncronas entram em filas: **microtasks** (Promises) têm prioridade e são processadas antes das **macrotasks** (`setTimeout`, eventos de I/O) a cada ciclo do loop.

## Promise

Uma `Promise` representa um valor que estará disponível no futuro (sucesso ou erro):

```javascript
fetch("/api/reviews")
  .then(res => res.json())
  .then(data => console.log(data))
  .catch(err => console.error(err));
```

## async/await e try/catch

`async`/`await` é açúcar sintático sobre Promises, deixando código assíncrono com aparência síncrona e mais fácil de ler. Erros são tratados com `try`/`catch`:

```javascript
async function carregarRevisoes() {
  try {
    const res = await fetch("/api/reviews");
    if (!res.ok) throw new Error("Falha ao carregar");
    return await res.json();
  } catch (erro) {
    console.error("Não foi possível carregar:", erro);
    return [];
  }
}
```

## Pontos importantes

- `map`/`filter`/`reduce` não alteram o array original — sempre retornam um novo.
- Toda chamada assíncrona (fetch, banco de dados) deve ter tratamento de erro explícito, nunca assuma que ela sempre terá sucesso.
- Prefira `async`/`await` a encadear vários `.then()`, para legibilidade.$md$,
  topic_count = 16,
  updated_at = now()
where slug = 'semana-2-javascript-assincrono';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-2-javascript-assincrono');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('map', 0),
  ('filter', 1),
  ('reduce', 2),
  ('find', 3),
  ('some', 4),
  ('forEach', 5),
  ('Web APIs', 6),
  ('Event Loop', 7),
  ('Microtasks', 8),
  ('Macrotasks', 9),
  ('Fetch', 10),
  ('Promise', 11),
  ('async', 12),
  ('await', 13),
  ('try/catch', 14),
  ('Tratamento de erros', 15)
) as t(title, order_index)
where study_contents.slug = 'semana-2-javascript-assincrono';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (3, 1, 'Segunda-feira', 'Fundamentos do React', 'semana-3-fundamentos-react', 'Virtual DOM, JSX, componentes, props e o fluxo de dados unidirecional.', 90, 11)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Segunda-feira',
  description = 'Virtual DOM, JSX, componentes, props e o fluxo de dados unidirecional.',
  content = $md$# Fundamentos do React

## Virtual DOM e Reconciliation

React mantém uma representação em memória da UI (o **Virtual DOM**). Quando o estado muda, React calcula a diferença entre a versão anterior e a nova (**reconciliation**) e atualiza no DOM real só o que realmente mudou — mais rápido do que recriar a página inteira.

## JSX

JSX é uma extensão de sintaxe que permite escrever marcação parecida com HTML dentro do JavaScript, compilada para chamadas de função (`React.createElement`):

```jsx
function Ola({ nome }) {
  return <h1>Olá, {nome}!</h1>;
}
```

## Componentes e props

Componentes são funções que retornam JSX. **Props** são os parâmetros que um componente recebe do componente pai — sempre de cima para baixo (fluxo unidirecional):

```jsx
function Card({ titulo, children }) {
  return (
    <div className="card">
      <h2>{titulo}</h2>
      {children}
    </div>
  );
}

<Card titulo="Progresso">
  <p>60% concluído</p>
</Card>
```

## Estado e imutabilidade

Estado é dado que muda ao longo do tempo e que, quando alterado, faz o componente renderizar de novo (`useState`). React espera que você **nunca mute o estado diretamente** — sempre crie uma nova referência:

```jsx
// Errado: muta o array original
lista.push(novoItem);

// Certo: cria um novo array
setLista([...lista, novoItem]);
```

## Fluxo de dados e renderização

Dados fluem de componentes pais para filhos via props; para um filho "avisar" o pai de algo, o pai passa uma função como prop (callback). Sempre que o estado ou as props de um componente mudam, React re-renderiza aquele componente e seus filhos.

## Pontos importantes

- Nunca mute estado diretamente — sempre gere uma nova referência (spread, `.map`, etc.).
- Props fluem de cima para baixo; comunicação de baixo para cima acontece via callbacks.$md$,
  topic_count = 10,
  updated_at = now()
where slug = 'semana-3-fundamentos-react';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-3-fundamentos-react');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('React', 0),
  ('Virtual DOM', 1),
  ('Reconciliation', 2),
  ('JSX', 3),
  ('Componentes', 4),
  ('Props', 5),
  ('Estado', 6),
  ('Imutabilidade', 7),
  ('Fluxo de dados', 8),
  ('Renderização', 9)
) as t(title, order_index)
where study_contents.slug = 'semana-3-fundamentos-react';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (3, 2, 'Terça-feira', 'Hooks Avançados', 'semana-3-hooks-avancados', 'useEffect, cleanup, dependências, useMemo e useCallback para performance.', 90, 12)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Terça-feira',
  description = 'useEffect, cleanup, dependências, useMemo e useCallback para performance.',
  content = $md$# Hooks Avançados

## useEffect e efeitos colaterais

`useEffect` executa código fora do fluxo de renderização — chamadas de API, subscriptions, manipulação direta do DOM. Ele roda depois que o componente renderiza:

```jsx
useEffect(() => {
  fetchReviews(userId).then(setReviews);
}, [userId]); // roda de novo só quando userId mudar
```

## Array de dependências

O segundo argumento de `useEffect` (e de `useMemo`/`useCallback`) diz ao React quando o efeito precisa rodar de novo. Array vazio `[]` = roda só na montagem; sem array = roda a cada renderização; com valores = roda quando algum deles mudar.

## Cleanup

Se o efeito criar uma subscription, timer ou listener, é preciso "desmontar" isso quando o componente sai de tela ou antes do efeito rodar de novo — evitando vazamento de memória:

```jsx
useEffect(() => {
  const id = setInterval(() => tick(), 1000);
  return () => clearInterval(id); // cleanup
}, []);
```

## useMemo e useCallback

Ambos memoizam (guardam em cache) um valor entre renderizações, recalculando só quando as dependências mudam.

- `useMemo` memoiza um **valor** calculado (ex: uma lista filtrada cara de computar).
- `useCallback` memoiza uma **função**, evitando recriá-la a cada renderização (útil ao passar callbacks para componentes filhos memoizados).

```jsx
const revisoesConcluidas = useMemo(
  () => reviews.filter(r => r.completed),
  [reviews]
);

const handleSalvar = useCallback(() => {
  salvarRevisao(id);
}, [id]);
```

## Performance

`useMemo`/`useCallback` só valem a pena quando o cálculo é realmente caro ou quando evitam re-renderizações desnecessárias de componentes filhos memoizados (`React.memo`) — usá-los em tudo, sem necessidade, só adiciona complexidade.

## Pontos importantes

- Sempre declare as dependências corretas do `useEffect` — omitir uma gera bugs sutis com dados desatualizados.
- Cleanup é obrigatório sempre que o efeito cria algo que "continua vivo" (timer, subscription, listener).$md$,
  topic_count = 9,
  updated_at = now()
where slug = 'semana-3-hooks-avancados';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-3-hooks-avancados');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('useState', 0),
  ('useEffect', 1),
  ('Cleanup', 2),
  ('Dependências', 3),
  ('useMemo', 4),
  ('useCallback', 5),
  ('Performance', 6),
  ('Memoização', 7),
  ('Efeitos colaterais', 8)
) as t(title, order_index)
where study_contents.slug = 'semana-3-hooks-avancados';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (3, 3, 'Quarta-feira', 'Estado Global & Next.js', 'semana-3-estado-global-nextjs', 'Context API para estado compartilhado e os fundamentos do App Router do Next.js.', 90, 13)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Quarta-feira',
  description = 'Context API para estado compartilhado e os fundamentos do App Router do Next.js.',
  content = $md$# Estado Global & Next.js

## Context API

Quando várias partes distantes da árvore de componentes precisam do mesmo dado (ex: usuário autenticado), passar props manualmente por cada nível ("prop drilling") fica inviável. A **Context API** resolve isso: um `Provider` disponibiliza um valor que qualquer componente descendente pode ler diretamente.

```jsx
const AuthContext = createContext(null);

function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  return (
    <AuthContext.Provider value={{ user, setUser }}>
      {children}
    </AuthContext.Provider>
  );
}

function Perfil() {
  const { user } = useContext(AuthContext);
  return <p>{user?.name}</p>;
}
```

## Next.js e App Router

Next.js é um framework sobre React que adiciona roteamento baseado em arquivos, renderização no servidor e outras otimizações. O **App Router** (pasta `app/`) organiza rotas por pastas, cada uma com um `page.tsx`.

## Server Components vs. Client Components

No App Router, componentes são **Server Components** por padrão: renderizam no servidor, não enviam JavaScript ao navegador, e podem acessar banco de dados diretamente. Um componente vira **Client Component** ao declarar `"use client"` no topo do arquivo — necessário para usar hooks como `useState`/`useEffect` ou interatividade no navegador.

```jsx
"use client";
import { useState } from "react";

export function Contador() {
  const [n, setN] = useState(0);
  return <button onClick={() => setN(n + 1)}>{n}</button>;
}
```

## Layouts e rotas dinâmicas

Um `layout.tsx` envolve várias páginas com uma UI compartilhada (ex: sidebar) sem perder estado ao navegar entre elas. Rotas dinâmicas usam colchetes na pasta: `app/contents/[slug]/page.tsx` captura qualquer valor de `slug` na URL.

## Pontos importantes

- Use Context para estado global de baixo volume de atualização (usuário, tema) — para estado que muda com muita frequência, considere outras soluções de state management.
- No App Router, só marque como Client Component o que realmente precisa de interatividade no navegador.$md$,
  topic_count = 8,
  updated_at = now()
where slug = 'semana-3-estado-global-nextjs';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-3-estado-global-nextjs');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Context API', 0),
  ('Estado global', 1),
  ('Provider', 2),
  ('App Router', 3),
  ('Server Components', 4),
  ('Client Components', 5),
  ('Layouts', 6),
  ('Rotas dinâmicas', 7)
) as t(title, order_index)
where study_contents.slug = 'semana-3-estado-global-nextjs';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (3, 4, 'Quinta-feira', 'TypeScript', 'semana-3-typescript', 'Tipagem estática aplicada a componentes React: interfaces, generics e utilitários de tipo.', 90, 14)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Quinta-feira',
  description = 'Tipagem estática aplicada a componentes React: interfaces, generics e utilitários de tipo.',
  content = $md$# TypeScript

## Interfaces e type aliases

Ambos descrevem o formato de um objeto. `interface` é extensível (pode ser reaberta/estendida); `type` é mais flexível para uniões e tipos compostos. Na prática, para props de componente, os dois funcionam bem:

```typescript
interface ReviewProps {
  title: string;
  minutes: number;
  completed?: boolean; // opcional
}

type Difficulty = "easy" | "medium" | "hard"; // type alias com union
```

## Tipando props, state e eventos

```tsx
function ReviewCard({ title, minutes }: ReviewProps) {
  const [completed, setCompleted] = useState<boolean>(false);

  function handleClick(e: React.MouseEvent<HTMLButtonElement>) {
    setCompleted(!completed);
  }

  return <button onClick={handleClick}>{title} — {minutes}min</button>;
}
```

## Generics

Generics permitem escrever código reutilizável que funciona com vários tipos, mantendo a segurança de tipos:

```typescript
function primeiro<T>(lista: T[]): T | undefined {
  return lista[0];
}

primeiro<string>(["a", "b"]); // T = string
```

## Utility types: Partial, Pick, Omit

- `Partial<T>`: torna todas as propriedades de `T` opcionais — útil para objetos de atualização parcial (`PATCH`).
- `Pick<T, K>`: cria um novo tipo só com as propriedades escolhidas de `T`.
- `Omit<T, K>`: cria um novo tipo com todas as propriedades de `T`, exceto as escolhidas.

```typescript
interface Review { id: string; title: string; minutes: number; completed: boolean; }

type ReviewUpdate = Partial<Review>;             // tudo opcional
type ReviewSummary = Pick<Review, "id" | "title">; // só id e title
type NewReview = Omit<Review, "id">;              // tudo, menos id
```

## Union, Intersection e narrowing

**Union** (`A | B`) significa "A ou B". **Intersection** (`A & B`) combina os dois tipos em um só. **Type narrowing** é o processo de o TypeScript "estreitar" um tipo union para um tipo mais específico dentro de um `if`, checagem de tipo, etc.

```typescript
function formatar(valor: string | number) {
  if (typeof valor === "string") {
    return valor.toUpperCase(); // aqui o TS sabe que é string
  }
  return valor.toFixed(2); // aqui, number
}
```

## Pontos importantes

- `Partial`/`Pick`/`Omit` evitam duplicar interfaces parecidas manualmente — derive-as do tipo principal.
- Type narrowing com `typeof`/`in`/checagens explícitas é a forma idiomática de lidar com union types.$md$,
  topic_count = 13,
  updated_at = now()
where slug = 'semana-3-typescript';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-3-typescript');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Tipos', 0),
  ('Interfaces', 1),
  ('Type aliases', 2),
  ('Props', 3),
  ('State', 4),
  ('Eventos', 5),
  ('Generics', 6),
  ('Partial', 7),
  ('Pick', 8),
  ('Omit', 9),
  ('Union Types', 10),
  ('Intersection Types', 11),
  ('Type narrowing', 12)
) as t(title, order_index)
where study_contents.slug = 'semana-3-typescript';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (3, 5, 'Sexta-feira', 'Integração Full Stack', 'semana-3-integracao-full-stack', 'Consumindo uma API do FastAPI a partir do React, com autenticação e tratamento de estados.', 90, 15)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Sexta-feira',
  description = 'Consumindo uma API do FastAPI a partir do React, com autenticação e tratamento de estados.',
  content = $md$# Integração Full Stack

## Consumindo uma API a partir do React

O frontend React se comunica com o backend (FastAPI ou Supabase) via requisições HTTP — geralmente com `fetch` ou uma biblioteca cliente. O padrão mais comum: disparar a requisição em um `useEffect`, guardar o resultado no estado, e tratar os três estados possíveis da UI.

```tsx
function useReviews(userId: string) {
  const [reviews, setReviews] = useState<Review[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    setLoading(true);
    fetch(`/api/reviews?user_id=${userId}`)
      .then(res => {
        if (!res.ok) throw new Error("Falha ao carregar");
        return res.json();
      })
      .then(setReviews)
      .catch(() => setError("Não foi possível carregar as revisões."))
      .finally(() => setLoading(false));
  }, [userId]);

  return { reviews, loading, error };
}
```

## Loading, Empty e Error states

Toda tela que busca dados precisa tratar explicitamente três estados, além do de sucesso:

- **Loading**: enquanto a requisição está em andamento (spinner, skeleton).
- **Empty**: quando a requisição teve sucesso mas não há dados (mensagem amigável, não uma tela em branco).
- **Error**: quando a requisição falhou (mensagem clara, opção de tentar de novo).

Ignorar qualquer um desses estados é uma das causas mais comuns de UI confusa em produção.

## Autenticação na integração

Ao chamar uma API autenticada, o frontend precisa anexar as credenciais (token JWT, cookie de sessão) em cada requisição — com Supabase, o próprio client já injeta o token da sessão automaticamente nas chamadas.

## Pontos importantes

- Trate loading, empty e error para toda tela que depende de dados assíncronos — não apenas o caminho de sucesso.
- Centralize a lógica de chamada de API em hooks/services reutilizáveis, em vez de duplicar `fetch` em cada componente.$md$,
  topic_count = 10,
  updated_at = now()
where slug = 'semana-3-integracao-full-stack';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-3-integracao-full-stack');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('React + API', 0),
  ('FastAPI', 1),
  ('Requisições HTTP', 2),
  ('Loading', 3),
  ('Empty States', 4),
  ('Error States', 5),
  ('Tratamento de erros', 6),
  ('Integração frontend/backend', 7),
  ('Autenticação', 8),
  ('Consumo de dados', 9)
) as t(title, order_index)
where study_contents.slug = 'semana-3-integracao-full-stack';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (4, 1, 'Segunda-feira', 'Docker', 'semana-4-docker', 'Containers, Dockerfile, multi-stage build e Docker Compose.', 90, 16)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Segunda-feira',
  description = 'Containers, Dockerfile, multi-stage build e Docker Compose.',
  content = $md$# Docker

## Containers

Um container empacota uma aplicação junto com tudo que ela precisa para rodar (dependências, runtime, configuração) em uma unidade isolada e portátil — o mesmo container roda igual na sua máquina, no CI e em produção.

## Dockerfile

Um Dockerfile é a receita para construir a imagem de um container, instrução por instrução:

```dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0"]
```

- **FROM**: imagem base de onde partir.
- **WORKDIR**: diretório de trabalho dentro do container.
- **RUN**: executa um comando durante a construção da imagem (ex: instalar dependências).
- **COPY**: copia arquivos do host para dentro da imagem.
- **EXPOSE**: documenta a porta que a aplicação usa (não abre a porta sozinho).
- **CMD**: comando padrão executado quando o container inicia.
- **ENTRYPOINT**: similar ao CMD, mas pensado para não ser sobrescrito facilmente — comumente combinado com CMD para argumentos padrão.

## Multi-stage build

Permite usar uma imagem maior (com ferramentas de build) para compilar a aplicação, e copiar só o resultado final para uma imagem final menor — reduzindo bastante o tamanho da imagem publicada:

```dockerfile
FROM node:20 AS build
WORKDIR /app
COPY . .
RUN npm install && npm run build

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
```

## Docker Compose, volumes e networks

**Docker Compose** define e orquestra múltiplos containers (ex: API + banco + Redis) em um único arquivo YAML. **Volumes** persistem dados fora do ciclo de vida do container (ex: dados do banco). **Networks** permitem que containers se comuniquem entre si pelo nome do serviço.

```yaml
services:
  api:
    build: .
    ports: ["8000:8000"]
  db:
    image: postgres:16
    volumes: ["pgdata:/var/lib/postgresql/data"]
volumes:
  pgdata:
```

## Pontos importantes

- Multi-stage build é a forma padrão de manter imagens de produção pequenas.
- Sem volume, dados dentro de um container somem quando ele é recriado — use volumes para o que precisa persistir.$md$,
  topic_count = 13,
  updated_at = now()
where slug = 'semana-4-docker';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-4-docker');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Containers', 0),
  ('Dockerfile', 1),
  ('Multi-stage Build', 2),
  ('FROM', 3),
  ('WORKDIR', 4),
  ('RUN', 5),
  ('COPY', 6),
  ('EXPOSE', 7),
  ('CMD', 8),
  ('ENTRYPOINT', 9),
  ('Docker Compose', 10),
  ('Volumes', 11),
  ('Networks', 12)
) as t(title, order_index)
where study_contents.slug = 'semana-4-docker';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (4, 2, 'Terça-feira', 'Kubernetes & Observabilidade', 'semana-4-kubernetes-observabilidade', 'Pods, Deployments, Services, Ingress e as bases de monitoramento com logs.', 90, 17)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Terça-feira',
  description = 'Pods, Deployments, Services, Ingress e as bases de monitoramento com logs.',
  content = $md$# Kubernetes & Observabilidade

## Kubernetes

Kubernetes é uma plataforma de orquestração de containers: gerencia automaticamente onde e como containers rodam, reinicia os que falham, e escala aplicações conforme demanda — em vez de gerenciar containers manualmente em servidores individuais.

## Pods, Deployments e Services

- **Pod**: menor unidade do Kubernetes — geralmente um container (ou um pequeno grupo intimamente relacionado) rodando junto.
- **Deployment**: descreve o estado desejado de um conjunto de Pods (quantas réplicas, qual imagem) e garante que a realidade convirja para esse estado — se um Pod cai, o Deployment sobe outro.
- **Service**: expõe um conjunto de Pods sob um endereço estável, já que Pods individuais são efêmeros e mudam de IP.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api
spec:
  replicas: 3
  template:
    spec:
      containers:
        - name: api
          image: minha-api:latest
```

## Ingress

O Ingress gerencia o acesso externo (HTTP/HTTPS) aos Services dentro do cluster, geralmente roteando por domínio ou path para diferentes serviços internos.

## Escalabilidade

Kubernetes permite escalar horizontalmente (mais réplicas de Pods) manualmente ou automaticamente (Horizontal Pod Autoscaler), conforme métricas como uso de CPU.

## Observabilidade: logs, monitoramento e ELK

**Observabilidade** é a capacidade de entender o que está acontecendo dentro do sistema a partir de dados externos: logs, métricas e traces. **ELK** (Elasticsearch, Logstash, Kibana) é uma stack popular para centralizar, indexar e visualizar logs de múltiplos serviços em um só lugar — essencial quando você tem vários Pods/containers gerando logs separadamente.

## Pontos importantes

- Deployments garantem que o número de réplicas desejado se mantenha, mesmo com falhas.
- Sem uma stack de observabilidade centralizada, depurar problemas em um sistema com múltiplos containers fica muito mais difícil.$md$,
  topic_count = 10,
  updated_at = now()
where slug = 'semana-4-kubernetes-observabilidade';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-4-kubernetes-observabilidade');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Kubernetes', 0),
  ('Pods', 1),
  ('Deployments', 2),
  ('Services', 3),
  ('Ingress', 4),
  ('Escalabilidade', 5),
  ('Logs', 6),
  ('Monitoramento', 7),
  ('ELK', 8),
  ('Observabilidade', 9)
) as t(title, order_index)
where study_contents.slug = 'semana-4-kubernetes-observabilidade';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (4, 3, 'Quarta-feira', 'CI/CD', 'semana-4-ci-cd', 'Integração e entrega contínua, com GitHub Actions e as etapas de um pipeline.', 90, 18)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Quarta-feira',
  description = 'Integração e entrega contínua, com GitHub Actions e as etapas de um pipeline.',
  content = $md$# CI/CD

## CI (Integração Contínua)

Toda vez que alguém envia código (push/PR), um pipeline automatizado roda verificações — lint, testes, build — antes de permitir o merge. Isso detecta problemas cedo, em vez de descobri-los em produção.

## CD (Entrega/Deploy Contínuo)

Depois que o código passa pela CI, a CD automatiza o processo de colocá-lo em produção (ou em um ambiente de staging) sem intervenção manual repetitiva.

## GitHub Actions

GitHub Actions é a ferramenta de CI/CD integrada ao GitHub, configurada por arquivos YAML na pasta `.github/workflows/`:

```yaml
name: CI
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: 20 }
      - run: npm install
      - run: npm run lint
      - run: npm run build
```

## Etapas típicas de um pipeline

1. **Lint** — verifica estilo e erros óbvios de código.
2. **Testes** — roda a suíte de testes automatizados.
3. **Build** — compila/empacota a aplicação.
4. **Deploy** — publica o resultado em um ambiente (Vercel, Render, etc).

## Vercel e Render

**Vercel** é uma plataforma de deploy focada em frontend (Next.js, Vite, etc), com deploy automático a cada push e preview URLs por Pull Request. **Render** é uma plataforma mais geral, que também hospeda APIs backend, bancos de dados e workers — útil quando o frontend está na Vercel mas o backend precisa rodar em outro lugar.

## Pontos importantes

- Um pipeline de CI que falha bloqueia o merge — é a rede de segurança antes do código chegar em produção.
- Deploy automático a cada push reduz o atrito de publicar, mas exige que a suíte de testes seja confiável.$md$,
  topic_count = 10,
  updated_at = now()
where slug = 'semana-4-ci-cd';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-4-ci-cd');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('CI', 0),
  ('CD', 1),
  ('GitHub Actions', 2),
  ('Lint', 3),
  ('Testes', 4),
  ('Build', 5),
  ('Deploy', 6),
  ('Vercel', 7),
  ('Render', 8),
  ('Pipeline', 9)
) as t(title, order_index)
where study_contents.slug = 'semana-4-ci-cd';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (4, 4, 'Quinta-feira', 'Arquitetura de APIs', 'semana-4-arquitetura-apis', 'Verbos HTTP, paginação, status codes, CORS e headers em APIs REST.', 90, 19)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Quinta-feira',
  description = 'Verbos HTTP, paginação, status codes, CORS e headers em APIs REST.',
  content = $md$# Arquitetura de APIs

## REST

REST (Representational State Transfer) é um estilo arquitetural para APIs onde recursos (usuários, revisões, perguntas) são acessados via URLs previsíveis, usando os verbos HTTP para indicar a ação.

## Verbos HTTP

- **GET** — buscar um recurso (não deve ter efeitos colaterais).
- **POST** — criar um novo recurso.
- **PUT** — substituir um recurso inteiro.
- **PATCH** — atualizar parcialmente um recurso.
- **DELETE** — remover um recurso.

```
GET    /reviews          -> lista revisões
POST   /reviews          -> cria uma revisão
GET    /reviews/{id}     -> busca uma revisão específica
PATCH  /reviews/{id}     -> atualiza parcialmente
DELETE /reviews/{id}     -> remove
```

## Paginação

Ao listar muitos registros, retornar tudo de uma vez é caro e lento. Paginação retorna um subconjunto por vez, geralmente com parâmetros como `?page=2&limit=20` (offset-based) ou um cursor (`?cursor=abc123`, cursor-based — mais estável quando dados mudam entre páginas).

## Status Codes

Já vistos anteriormente (200, 201, 400, 404, 422), mas vale reforçar a categoria geral: **2xx** sucesso, **3xx** redirecionamento, **4xx** erro do cliente (dado errado, sem permissão), **5xx** erro do servidor.

## CORS

CORS (Cross-Origin Resource Sharing) é o mecanismo do navegador que controla se um site em um domínio pode fazer requisições a uma API em outro domínio. O servidor precisa declarar explicitamente quais origens são permitidas, via headers como `Access-Control-Allow-Origin`.

## Headers e autenticação

Headers carregam metadados da requisição/resposta — incluindo autenticação, geralmente via `Authorization: Bearer <token>`. O servidor valida esse token a cada requisição para identificar o usuário.

## Pontos importantes

- Escolha o verbo HTTP certo para a ação — não use GET para operações que alteram dados.
- Sem CORS configurado corretamente, o frontend em um domínio diferente simplesmente não consegue chamar a API, mesmo que a requisição "exista" na rede.$md$,
  topic_count = 13,
  updated_at = now()
where slug = 'semana-4-arquitetura-apis';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-4-arquitetura-apis');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('REST', 0),
  ('HTTP', 1),
  ('GET', 2),
  ('POST', 3),
  ('PUT', 4),
  ('PATCH', 5),
  ('DELETE', 6),
  ('URLs', 7),
  ('Paginação', 8),
  ('Status Codes', 9),
  ('CORS', 10),
  ('Headers', 11),
  ('Autenticação', 12)
) as t(title, order_index)
where study_contents.slug = 'semana-4-arquitetura-apis';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (4, 5, 'Sexta-feira', 'Git & Metodologias Ágeis', 'semana-4-git-metodologias-ageis', 'Branches, merge, rebase e os rituais do Scrum e Kanban.', 90, 20)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Sexta-feira',
  description = 'Branches, merge, rebase e os rituais do Scrum e Kanban.',
  content = $md$# Git & Metodologias Ágeis

## Branches e merge

Uma **branch** é uma linha de desenvolvimento independente, permitindo trabalhar em uma funcionalidade sem afetar o código principal (`main`). **Merge** combina o histórico de uma branch de volta em outra, criando um commit de merge quando há divergência.

```bash
git checkout -b feature/revisoes
# ... commits ...
git checkout main
git merge feature/revisoes
```

## Rebase

Rebase reaplica os commits de uma branch sobre outra base, criando um histórico linear (sem commit de merge) — útil para manter o histórico limpo, mas deve ser evitado em branches já compartilhadas/publicadas, pois reescreve o histórico.

## Cherry-pick

Aplica um commit específico de uma branch em outra, sem trazer o restante do histórico daquela branch — útil para levar uma correção pontual sem misturar outras mudanças.

```bash
git cherry-pick <hash-do-commit>
```

## Stash

Guarda temporariamente mudanças não commitadas, permitindo trocar de branch com a "área de trabalho limpa" e recuperá-las depois:

```bash
git stash
git checkout outra-branch
git stash pop
```

## Conflitos

Acontecem quando duas branches alteram a mesma linha/trecho de forma diferente e o Git não consegue decidir automaticamente qual versão manter — exige resolução manual, escolhendo ou combinando as mudanças.

## Scrum e Kanban

**Scrum** organiza o trabalho em ciclos fixos chamados **Sprints** (geralmente 1-2 semanas), com rituais como **Planning** (planejamento do que entra na sprint), **Daily** (alinhamento diário curto) e **Retrospectiva** (reflexão sobre o que funcionou/não funcionou ao final da sprint). **Kanban** é mais fluido: trabalho flui continuamente por colunas (ex: "a fazer", "em progresso", "concluído"), sem ciclos fixos, com foco em limitar trabalho em progresso.

## Pontos importantes

- Rebase deixa o histórico mais limpo, mas nunca deve ser usado em branches que outras pessoas já baixaram/usam.
- Scrum funciona bem para entregas em ciclos previsíveis; Kanban funciona bem para fluxo contínuo de demandas variáveis (ex: suporte).$md$,
  topic_count = 13,
  updated_at = now()
where slug = 'semana-4-git-metodologias-ageis';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-4-git-metodologias-ageis');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Git', 0),
  ('Branch', 1),
  ('Merge', 2),
  ('Rebase', 3),
  ('Cherry-pick', 4),
  ('Stash', 5),
  ('Conflitos', 6),
  ('Scrum', 7),
  ('Kanban', 8),
  ('Sprint', 9),
  ('Daily', 10),
  ('Planning', 11),
  ('Retrospectiva', 12)
) as t(title, order_index)
where study_contents.slug = 'semana-4-git-metodologias-ageis';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (5, 1, 'Segunda-feira', 'Projetos do Portfólio', 'semana-5-projetos-portfolio', 'Dois projetos de referência para portfólio: PokeFast API (backend) e SmartFinance (frontend).', 90, 21)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Segunda-feira',
  description = 'Dois projetos de referência para portfólio: PokeFast API (backend) e SmartFinance (frontend).',
  content = $md$# Projetos do Portfólio

Dois projetos de referência que exercitam, na prática, boa parte do que foi estudado nas semanas anteriores.

## Projeto: PokeFast API

Uma API construída com **FastAPI** e **Python**, que consome a **PokéAPI** (uma API pública externa) de forma assíncrona e expõe endpoints próprios, organizados e testados.

Pontos de destaque para o portfólio:

- **Arquitetura**: separação clara entre rotas, serviços (lógica de negócio) e clientes de API externa.
- **Async**: chamadas à PokéAPI feitas de forma assíncrona (`async`/`await`), evitando bloquear a aplicação enquanto espera a resposta externa.
- **Consumo de API externa**: tratamento de erros e timeouts ao depender de um serviço de terceiros — a PokéAPI pode estar lenta ou fora do ar, e a aplicação precisa lidar bem com isso.
- **Paginação**: os próprios endpoints do PokeFast API devem paginar resultados, em vez de retornar listas inteiras de uma vez.
- **Organização de projeto**: pastas separadas para rotas, modelos, serviços e testes — refletindo os fundamentos de arquitetura já estudados.
- **Testes**: cobertura dos principais endpoints com Pytest, incluindo casos de erro (ex: Pokémon inexistente).

## Projeto: SmartFinance

Uma aplicação **React** com **TypeScript**, focada em um dashboard financeiro pessoal.

Pontos de destaque para o portfólio:

- **Recharts** e **Gráficos**: visualização de gastos/receitas ao longo do tempo, categorias, etc.
- **Context API**: estado compartilhado (ex: usuário, filtros ativos do dashboard) sem prop drilling.
- **Dashboard**: composição de vários cards/gráficos independentes, cada um buscando e tratando seus próprios dados (loading/empty/error).
- **PDF**: geração de relatório em PDF a partir dos dados exibidos, um recurso comum em ferramentas financeiras.
- **Organização de componentes**: componentes pequenos e reutilizáveis (cards de métrica, gráficos, filtros), seguindo os princípios de componentização já estudados em React.
- **Experiência do usuário**: atenção a estados de carregamento, formatação de valores monetários, feedback claro para ações do usuário.

## Pontos importantes

- Um bom projeto de portfólio não é sobre usar todas as tecnologias possíveis — é sobre mostrar decisões de arquitetura conscientes e código bem tratado (erros, testes, organização).
- Documentar o "porquê" das decisões no README do projeto ajuda muito na hora de falar sobre ele em entrevistas.$md$,
  topic_count = 18,
  updated_at = now()
where slug = 'semana-5-projetos-portfolio';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-5-projetos-portfolio');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Arquitetura', 0),
  ('FastAPI', 1),
  ('Python', 2),
  ('Async', 3),
  ('Consumo de API externa', 4),
  ('Paginação', 5),
  ('PokéAPI', 6),
  ('Organização de projeto', 7),
  ('Testes', 8),
  ('React', 9),
  ('TypeScript', 10),
  ('Recharts', 11),
  ('Context API', 12),
  ('Dashboard', 13),
  ('Gráficos', 14),
  ('PDF', 15),
  ('Organização de componentes', 16),
  ('Experiência do usuário', 17)
) as t(title, order_index)
where study_contents.slug = 'semana-5-projetos-portfolio';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (5, 2, 'Terça-feira', 'Soft Skills & Método STAR', 'semana-5-soft-skills-star', 'Como estruturar respostas de entrevista comportamental usando o método STAR.', 90, 22)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Terça-feira',
  description = 'Como estruturar respostas de entrevista comportamental usando o método STAR.',
  content = $md$# Soft Skills & Método STAR

## Entrevista comportamental

Diferente da entrevista técnica, a entrevista comportamental avalia como você lida com situações reais de trabalho: comunicação, trabalho em equipe, resolução de problemas, conflitos e como você recebe/dá feedback.

## Método STAR

STAR é uma estrutura para organizar respostas a perguntas comportamentais, contando uma história real de forma clara e objetiva:

- **Situação**: o contexto — onde, quando, com quem.
- **Tarefa**: qual era o seu objetivo ou responsabilidade naquela situação.
- **Ação**: o que você especificamente fez (não "nós", foque no seu papel).
- **Resultado**: o que aconteceu — idealmente com algum resultado mensurável ou aprendizado claro.

## Exemplos de perguntas para praticar com STAR

**"Conte sobre um problema difícil que você resolveu."**
Pense em um bug complexo, uma decisão técnica difícil ou um problema de produto. Estruture: qual era o problema (Situação/Tarefa), o que você investigou e decidiu fazer (Ação), e qual foi o desfecho (Resultado).

**"Conte sobre um conflito com um colega."**
Escolha um exemplo real, mas foque em como você comunicou o desacordo de forma profissional e chegou a uma solução — evite culpar a outra pessoa na narrativa.

**"Fale sobre uma situação em que você precisou aprender uma tecnologia rapidamente."**
Boa oportunidade para mostrar autonomia de aprendizado: como você buscou informação, praticou, e aplicou o que aprendeu sob prazo.

## Pontos importantes

- Prepare de 4 a 6 histórias reais de antemão, cobrindo temas comuns (conflito, prazo apertado, erro que você cometeu, liderança de iniciativa) — a maioria das perguntas comportamentais se encaixa em alguma delas.
- Seja específico e use "eu" para descrever sua ação individual, não apenas "nós"/"a equipe".$md$,
  topic_count = 11,
  updated_at = now()
where slug = 'semana-5-soft-skills-star';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-5-soft-skills-star');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Entrevista comportamental', 0),
  ('Método STAR', 1),
  ('Situação', 2),
  ('Tarefa', 3),
  ('Ação', 4),
  ('Resultado', 5),
  ('Comunicação', 6),
  ('Trabalho em equipe', 7),
  ('Resolução de problemas', 8),
  ('Conflitos', 9),
  ('Feedback', 10)
) as t(title, order_index)
where study_contents.slug = 'semana-5-soft-skills-star';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (5, 3, 'Quarta-feira', 'System Design', 'semana-5-system-design', 'Fundamentos de escalabilidade: cache, banco de dados, filas e distribuição de carga.', 90, 23)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Quarta-feira',
  description = 'Fundamentos de escalabilidade: cache, banco de dados, filas e distribuição de carga.',
  content = $md$# System Design

## Escalabilidade

Escalar significa manter a aplicação rápida e disponível conforme o número de usuários/dados cresce. Duas formas principais: **escalar verticalmente** (máquina mais potente) e **escalar horizontalmente** (mais máquinas/instâncias trabalhando em paralelo) — a segunda é geralmente preferida para crescimento sustentável.

## Cache e Redis

Como já visto na Semana 1, cache (com Redis, por exemplo) reduz a carga no banco de dados ao evitar recalcular/rebuscar os mesmos dados repetidamente — uma das formas mais eficazes de melhorar performance sob alta carga.

## Banco de dados e índices

Um **índice** de banco de dados acelera buscas em uma coluna (funciona como o índice de um livro), ao custo de espaço extra e escrita levemente mais lenta. Sem índices adequados nas colunas mais consultadas, queries ficam progressivamente mais lentas conforme a tabela cresce.

## Filas e processamento assíncrono

Sistemas de alta escala tiram trabalho pesado do caminho síncrono da requisição, delegando a filas (Celery, SQS, etc.) — assim a resposta ao usuário continua rápida mesmo quando a tarefa de fundo demora.

## Load Balancing

Um *load balancer* distribui requisições entre várias instâncias da aplicação, evitando que uma única instância fique sobrecarregada e permitindo escalar horizontalmente.

## CDN

Uma CDN (Content Delivery Network) distribui arquivos estáticos (imagens, JS, CSS) em servidores geograficamente próximos ao usuário, reduzindo latência.

## Code Splitting e Lazy Loading

No frontend, **code splitting** divide o JavaScript em pedaços menores, carregados sob demanda (**lazy loading**) — por exemplo, carregar o código de uma página só quando o usuário navega até ela, em vez de baixar a aplicação inteira de uma vez.

## Pergunta de revisão para praticar

**"O que você faria se o SmartFinance recebesse centenas de milhares de acessos simultâneos?"**
Pontos a considerar na resposta: cache das consultas mais frequentes, índices adequados nas tabelas mais acessadas, mover geração de relatórios/PDF para uma fila em background, servir os assets estáticos via CDN, e escalar a API horizontalmente atrás de um load balancer.

## Pontos importantes

- Escalabilidade raramente é "uma solução mágica" — é a combinação de cache, índices, filas e distribuição de carga aplicados nos pontos certos.
- Pense sempre em qual parte do sistema seria o primeiro gargalo sob carga alta, e ataque esse ponto primeiro.$md$,
  topic_count = 12,
  updated_at = now()
where slug = 'semana-5-system-design';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-5-system-design');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Escalabilidade', 0),
  ('Cache', 1),
  ('Redis', 2),
  ('Banco de dados', 3),
  ('Índices', 4),
  ('Filas', 5),
  ('Processamento assíncrono', 6),
  ('Load Balancing', 7),
  ('CDN', 8),
  ('Code Splitting', 9),
  ('Lazy Loading', 10),
  ('Arquitetura distribuída', 11)
) as t(title, order_index)
where study_contents.slug = 'semana-5-system-design';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (5, 4, 'Quinta-feira', 'Code Review', 'semana-5-code-review', 'Princípios de qualidade de código e boas práticas para revisar Pull Requests.', 90, 24)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Quinta-feira',
  description = 'Princípios de qualidade de código e boas práticas para revisar Pull Requests.',
  content = $md$# Code Review

## Por que Code Review importa

Revisão de código detecta bugs antes de chegarem em produção, espalha conhecimento pelo time e mantém um padrão de qualidade consistente — é tanto uma prática técnica quanto de comunicação.

## Legibilidade

Código é lido muito mais vezes do que é escrito. Nomes claros de variáveis/funções, funções pequenas com uma responsabilidade, e comentários só onde o "porquê" não é óbvio pelo próprio código — tudo isso importa mais do que "código esperto".

## Princípios: SOLID, DRY, KISS

- **SOLID**: conjunto de 5 princípios de design orientado a objetos (Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion) que ajudam a manter código flexível e desacoplado.
- **DRY** (Don't Repeat Yourself): evite duplicar a mesma lógica em vários lugares — centralize em uma função/módulo reutilizável.
- **KISS** (Keep It Simple, Stupid): prefira a solução mais simples que resolve o problema, evitando complexidade desnecessária "por precaução".

## O que observar em um Pull Request

- **Tratamento de erros**: a lógica lida com casos de falha (dado inválido, chamada externa fora do ar), ou só o caminho feliz?
- **Testes**: as mudanças têm cobertura de teste adequada, incluindo casos de borda?
- **Performance**: existe alguma query em loop (N+1), processamento desnecessariamente pesado, ou dado carregado em excesso?
- **Segurança**: dados de entrada são validados? Informações sensíveis estão expostas em logs ou respostas de API?
- **Manutenibilidade**: outra pessoa do time conseguiria entender e alterar esse código dali a 6 meses?

## Como dar feedback em um review

Feedback construtivo é específico, focado no código (não na pessoa), e distingue claramente entre "bloqueante" (precisa mudar antes do merge) e "sugestão" (nice-to-have, pode ser feito depois).

## Pontos importantes

- Um bom review pergunta "isso vai quebrar em produção?" e "outra pessoa entende isso sem contexto extra?" antes de aprovar.
- DRY e KISS às vezes competem entre si — duplicar um pouco de código simples é, às vezes, melhor do que criar uma abstração complexa cedo demais.$md$,
  topic_count = 11,
  updated_at = now()
where slug = 'semana-5-code-review';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-5-code-review');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Qualidade de código', 0),
  ('Legibilidade', 1),
  ('SOLID', 2),
  ('DRY', 3),
  ('KISS', 4),
  ('Tratamento de erros', 5),
  ('Testes', 6),
  ('Performance', 7),
  ('Segurança', 8),
  ('Manutenibilidade', 9),
  ('Revisão de Pull Request', 10)
) as t(title, order_index)
where study_contents.slug = 'semana-5-code-review';

insert into public.study_contents
  (week_number, day_of_week, day_name, title, slug, description, estimated_minutes, order_index)
values
  (5, 5, 'Sexta-feira', 'Preparação para Entrevista', 'semana-5-preparacao-entrevista', 'Checklist final de revisão técnica e comportamental antes das entrevistas.', 90, 25)
on conflict (slug) do nothing;

update public.study_contents set
  day_name = 'Sexta-feira',
  description = 'Checklist final de revisão técnica e comportamental antes das entrevistas.',
  content = $md$# Preparação para Entrevista

Esta última aula é um checklist de revisão final, reunindo tudo que foi estudado nas cinco semanas.

## Checklist técnico

- **Python**: estruturas de dados, complexidade, pilares de POO, decoradores/geradores.
- **JavaScript**: escopo, closures, métodos de array, Promises/async-await.
- **React**: componentes, props vs. estado, hooks (`useEffect`, `useMemo`, `useCallback`), fluxo de dados.
- **TypeScript**: interfaces, generics, utility types (`Partial`, `Pick`, `Omit`), union/intersection.
- **APIs**: verbos HTTP corretos, status codes, paginação, autenticação, CORS.
- **SQL**: relacionamentos (1:1, 1:N, N:N), índices, quando usar joins vs. queries separadas.
- **Docker**: Dockerfile, multi-stage build, Compose para orquestrar múltiplos serviços localmente.
- **Git**: branch, merge vs. rebase, resolução de conflitos, boas mensagens de commit.
- **System Design**: cache, filas, índices, load balancing — como cada peça ataca um gargalo diferente.

## Projetos do portfólio

Tenha pronto, para cada projeto (como o PokeFast API e o SmartFinance): o problema que ele resolve, as decisões de arquitetura tomadas e por quê, um desafio técnico enfrentado e como foi resolvido, e o que você faria diferente hoje.

## Perguntas comportamentais

Revise as histórias preparadas com o método STAR (Semana 5, Dia 2) — problema difícil resolvido, conflito com colega, aprendizado rápido sob prazo.

## Apresentação pessoal

Prepare uma resposta concisa (1-2 minutos) para "fale sobre você", conectando sua trajetória, o que você estudou nesse cronograma, e o que busca na próxima posição — sem apenas repetir o currículo.

## Pontos importantes

- Não tente "decorar" respostas — entenda os conceitos o suficiente para explicar com suas próprias palavras e adaptar a exemplos diferentes.
- Revisar os próprios projetos do portfólio em detalhe é tão importante quanto revisar teoria — é sobre eles que a conversa técnica provavelmente vai girar.$md$,
  topic_count = 12,
  updated_at = now()
where slug = 'semana-5-preparacao-entrevista';

delete from public.content_topics
where content_id = (select id from public.study_contents where slug = 'semana-5-preparacao-entrevista');

insert into public.content_topics (content_id, title, order_index)
select id, t.title, t.order_index
from public.study_contents, (values
  ('Revisão de Python', 0),
  ('Revisão de JavaScript', 1),
  ('Revisão de React', 2),
  ('Revisão de TypeScript', 3),
  ('Revisão de APIs', 4),
  ('Revisão de SQL', 5),
  ('Revisão de Docker', 6),
  ('Revisão de Git', 7),
  ('System Design', 8),
  ('Projetos do portfólio', 9),
  ('Perguntas comportamentais', 10),
  ('Apresentação pessoal', 11)
) as t(title, order_index)
where study_contents.slug = 'semana-5-preparacao-entrevista';
