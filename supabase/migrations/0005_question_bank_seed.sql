-- ============================================================
-- ReviseTI — PROMPT 08 (parte 2/2): seed do banco de questões
-- Rode DEPOIS de 0004_question_bank.sql. Idempotente por question_key.
-- Total de questões neste seed: 310
-- ============================================================

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-core-python-poo'),
  'semana-1-core-python-poo-qual-estrutura-de-dados-em-python-mut-vel-e-ordena',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual estrutura de dados em Python é mutável e ordenada?',
  '[{"id": "a", "text": "Tupla"}, {"id": "b", "text": "Lista"}, {"id": "c", "text": "Frozenset"}, {"id": "d", "text": "String"}]'::jsonb,
  'b',
  'Lista',
  'Listas (`list`) são mutáveis — você pode adicionar, remover e alterar itens depois de criadas — e mantêm a ordem de inserção.',
  false,
  0
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-core-python-poo'),
  'semana-1-core-python-poo-qual-das-op-es-abaixo-imut-vel',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual das opções abaixo é imutável?',
  '[{"id": "a", "text": "list"}, {"id": "b", "text": "dict"}, {"id": "c", "text": "tuple"}, {"id": "d", "text": "set"}]'::jsonb,
  'c',
  'tuple',
  'Tuplas não podem ser alteradas após a criação; para ''modificar'' uma tupla, é preciso criar uma nova.',
  false,
  1
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-core-python-poo'),
  'semana-1-core-python-poo-um-set-em-python-permite-elementos-duplicados',
  'lesson',
  'true_false',
  'easy',
  'Um `set` em Python permite elementos duplicados.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'Sets armazenam apenas valores únicos — inserir um valor já existente não tem efeito.',
  false,
  2
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-core-python-poo'),
  'semana-1-core-python-poo-qual-a-complexidade-m-dia-de-busca-de-uma-chave-em',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual é a complexidade média de busca de uma chave em um dicionário Python?',
  '[{"id": "a", "text": "O(n)"}, {"id": "b", "text": "O(log n)"}, {"id": "c", "text": "O(1)"}, {"id": "d", "text": "O(n²)"}]'::jsonb,
  'c',
  'O(1)',
  'Dicionários usam hashing internamente, o que torna a busca por chave, em média, constante — O(1).',
  false,
  3
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-core-python-poo'),
  'semana-1-core-python-poo-o-que-o-c-digo-abaixo-imprime-python-nomes-ana-bet',
  'lesson',
  'code',
  'medium',
  'O que o código abaixo imprime?
```python
nomes = ["Ana", "Beto", "Caio"]
nomes.append("Duda")
print(len(nomes))
```',
  null,
  null,
  '4',
  '`append` adiciona um item ao final da lista, que passa de 3 para 4 elementos.',
  false,
  4
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-core-python-poo'),
  'semana-1-core-python-poo-qual-pilar-da-poo-permite-que-uma-subclasse-reapro',
  'lesson',
  'multiple_choice',
  'medium',
  'Qual pilar da POO permite que uma subclasse reaproveite comportamento de uma classe pai?',
  '[{"id": "a", "text": "Encapsulamento"}, {"id": "b", "text": "Herança"}, {"id": "c", "text": "Abstração"}, {"id": "d", "text": "Polimorfismo"}]'::jsonb,
  'b',
  'Herança',
  'Herança é o mecanismo pelo qual uma classe filha herda atributos e métodos de uma classe pai, podendo reutilizá-los ou sobrescrevê-los.',
  false,
  5
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-core-python-poo'),
  'semana-1-core-python-poo-no-exemplo-de-cachorro-e-gato-herdando-de-animal-c',
  'lesson',
  'multiple_choice',
  'medium',
  'No exemplo de `Cachorro` e `Gato` herdando de `Animal`, cada um implementando `emitir_som()` de forma diferente, qual conceito de POO está sendo demonstrado?',
  '[{"id": "a", "text": "Encapsulamento"}, {"id": "b", "text": "Composição"}, {"id": "c", "text": "Polimorfismo"}, {"id": "d", "text": "Sobrecarga de operadores"}]'::jsonb,
  'c',
  'Polimorfismo',
  'Polimorfismo é quando objetos de classes diferentes respondem ao mesmo método (`emitir_som`) de formas distintas.',
  false,
  6
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-core-python-poo'),
  'semana-1-core-python-poo-o-que-um-decorador-faz-em-python-em-termos-gerais',
  'lesson',
  'open',
  'medium',
  'O que um decorador faz em Python, em termos gerais?',
  null,
  null,
  'Envolve uma função para adicionar comportamento extra sem alterar o código da função original.',
  'Decoradores (`@algo`) recebem uma função e retornam outra, geralmente adicionando lógica antes/depois da execução original — como logging, autenticação ou cache.',
  false,
  7
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-core-python-poo'),
  'semana-1-core-python-poo-o-que-a-fun-o-abaixo-retorna-quando-chamada-como-l',
  'lesson',
  'code',
  'medium',
  'O que a função abaixo retorna quando chamada como `list(contador(3))`?
```python
def contador(limite):
    n = 0
    while n < limite:
        yield n
        n += 1
```',
  null,
  null,
  '[0, 1, 2]',
  'É um gerador: produz 0, 1 e 2 (parando antes de atingir o limite de 3), um valor por vez via `yield`.',
  false,
  8
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-core-python-poo'),
  'semana-1-core-python-poo-por-que-usar-um-ambiente-virtual-venv-em-um-projet',
  'lesson',
  'multiple_choice',
  'medium',
  'Por que usar um ambiente virtual (`venv`) em um projeto Python?',
  '[{"id": "a", "text": "Para deixar o código mais rápido"}, {"id": "b", "text": "Para isolar as dependências do projeto do restante do sistema"}, {"id": "c", "text": "Para compilar o código automaticamente"}, {"id": "d", "text": "Para gerar testes automaticamente"}]'::jsonb,
  'b',
  'Para isolar as dependências do projeto do restante do sistema',
  'Um venv evita conflitos de versão entre bibliotecas de projetos diferentes instalados na mesma máquina.',
  false,
  9
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-core-python-poo'),
  'semana-1-core-python-poo-por-que-buscar-um-elemento-em-uma-lista-grande-mai',
  'lesson',
  'open',
  'hard',
  'Por que buscar um elemento em uma lista grande é mais lento do que buscar uma chave em um dicionário do mesmo tamanho?',
  null,
  null,
  'Porque a busca em lista é O(n) (percorre item a item), enquanto a busca em dict é O(1) em média, via hashing.',
  'Dicionários calculam um hash da chave para localizar o valor diretamente, sem percorrer todos os elementos; listas não têm essa estrutura, então a busca é sequencial no pior caso.',
  false,
  10
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-core-python-poo'),
  'semana-1-core-python-poo-qual-a-sa-da-deste-c-digo-e-por-qu-python-def-adic',
  'lesson',
  'code',
  'hard',
  'Qual é a saída deste código e por quê?
```python
def adicionar_item(item, lista=[]):
    lista.append(item)
    return lista

print(adicionar_item("a"))
print(adicionar_item("b"))
```',
  null,
  null,
  '[''a''] e depois [''a'', ''b'']',
  'Valores padrão mutáveis (como `[]`) são criados uma única vez, na definição da função, e reutilizados entre chamadas — um erro comum e uma pegadinha clássica de Python.',
  false,
  11
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-assincronismo-fastapi'),
  'semana-1-assincronismo-fastapi-qual-palavra-chave-usada-para-pausar-a-execu-o-de-',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual palavra-chave é usada para pausar a execução de uma coroutine até um resultado estar pronto?',
  '[{"id": "a", "text": "yield"}, {"id": "b", "text": "await"}, {"id": "c", "text": "async"}, {"id": "d", "text": "return"}]'::jsonb,
  'b',
  'await',
  '`await` suspende a execução da função assíncrona até a operação aguardada terminar, sem bloquear o Event Loop.',
  false,
  12
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-assincronismo-fastapi'),
  'semana-1-assincronismo-fastapi-concorr-ncia-e-paralelismo-significam-exatamente-a',
  'lesson',
  'true_false',
  'easy',
  'Concorrência e paralelismo significam exatamente a mesma coisa.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'Concorrência é alternar entre tarefas (uma thread lidando com várias); paralelismo é executar tarefas literalmente ao mesmo tempo, em núcleos diferentes.',
  false,
  13
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-assincronismo-fastapi'),
  'semana-1-assincronismo-fastapi-o-que-o-fastapi-usa-para-validar-automaticamente-o',
  'lesson',
  'multiple_choice',
  'easy',
  'O que o FastAPI usa para validar automaticamente o corpo de uma requisição?',
  '[{"id": "a", "text": "Django Forms"}, {"id": "b", "text": "Pydantic"}, {"id": "c", "text": "Marshmallow"}, {"id": "d", "text": "JSON Schema manual"}]'::jsonb,
  'b',
  'Pydantic',
  'O FastAPI usa modelos Pydantic para descrever e validar automaticamente o formato esperado dos dados de entrada e saída.',
  false,
  14
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-assincronismo-fastapi'),
  'semana-1-assincronismo-fastapi-qual-status-http-o-fastapi-retorna-automaticamente',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual status HTTP o FastAPI retorna automaticamente quando os dados enviados não batem com o modelo Pydantic?',
  '[{"id": "a", "text": "400"}, {"id": "b", "text": "404"}, {"id": "c", "text": "422"}, {"id": "d", "text": "500"}]'::jsonb,
  'c',
  '422',
  '422 Unprocessable Entity indica que a requisição foi entendida, mas os dados não passaram na validação do schema.',
  false,
  15
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-assincronismo-fastapi'),
  'semana-1-assincronismo-fastapi-para-que-serve-o-depends-no-fastapi',
  'lesson',
  'open',
  'medium',
  'Para que serve o `Depends` no FastAPI?',
  null,
  null,
  'Para injetar dependências reutilizáveis (como autenticação ou conexão de banco) em várias rotas sem repetir código.',
  '`Depends` permite declarar uma função de dependência uma vez e reutilizá-la em quantas rotas precisarem dela, mantendo o código enxuto.',
  false,
  16
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-assincronismo-fastapi'),
  'semana-1-assincronismo-fastapi-qual-a-vantagem-de-organizar-rotas-usando-apiroute',
  'lesson',
  'multiple_choice',
  'medium',
  'Qual a vantagem de organizar rotas usando `APIRouter` em vez de um único arquivo?',
  '[{"id": "a", "text": "Deixa a API mais rápida"}, {"id": "b", "text": "Permite modularizar rotas por domínio, facilitando manutenção"}, {"id": "c", "text": "É obrigatório para o FastAPI funcionar"}, {"id": "d", "text": "Substitui a necessidade de testes"}]'::jsonb,
  'b',
  'Permite modularizar rotas por domínio, facilitando manutenção',
  '`APIRouter` organiza grupos de rotas relacionadas (ex: `/reviews`) em módulos separados, evitando um único arquivo gigante.',
  false,
  17
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-assincronismo-fastapi'),
  'semana-1-assincronismo-fastapi-correto-usar-async-def-para-uma-fun-o-que-faz-um-c',
  'lesson',
  'true_false',
  'medium',
  'É correto usar `async def` para uma função que faz um cálculo matemático pesado de CPU, sem I/O.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  '`async`/`await` ajuda quando a função espera I/O (rede, banco, arquivo); para processamento pesado de CPU, isso não traz ganho e pode até bloquear o Event Loop.',
  false,
  18
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-assincronismo-fastapi'),
  'semana-1-assincronismo-fastapi-o-que-est-incorreto-neste-trecho-de-rota-fastapi-p',
  'lesson',
  'code',
  'medium',
  'O que está incorreto neste trecho de rota FastAPI?
```python
@router.get("/users/{id}")
def get_user(id: int):
    resultado = await db.fetch_one(...)
    return resultado
```',
  null,
  null,
  'A função não está declarada como `async def`, mas usa `await` dentro dela.',
  '`await` só pode ser usado dentro de uma função declarada com `async def`; sem isso, o código não compila/roda.',
  false,
  19
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-assincronismo-fastapi'),
  'semana-1-assincronismo-fastapi-o-que-o-event-loop-de-forma-resumida',
  'lesson',
  'open',
  'medium',
  'O que é o Event Loop, de forma resumida?',
  null,
  null,
  'É o mecanismo que permite ao Python alternar entre tarefas assíncronas sem bloquear a execução, atendendo várias operações de I/O ''ao mesmo tempo''.',
  'Enquanto uma tarefa está esperando (ex: resposta de um banco), o Event Loop aproveita para processar outra tarefa pronta, maximizando o uso do tempo de espera.',
  false,
  20
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-assincronismo-fastapi'),
  'semana-1-assincronismo-fastapi-por-que-uma-api-que-faz-muitas-chamadas-de-rede-pa',
  'lesson',
  'open',
  'hard',
  'Por que uma API que faz muitas chamadas de rede (para outros serviços) se beneficia mais de `async`/`await` do que uma API que só faz cálculos internos?',
  null,
  null,
  'Porque a maior parte do tempo em chamadas de rede é espera (I/O), e o assíncrono permite atender outras requisições nesse intervalo, em vez de ficar ocioso.',
  'Em cargas ligadas a I/O, o assincronismo aumenta o throughput sem precisar de mais threads/processos; em cargas de CPU pura, não há tempo ocioso a aproveitar.',
  false,
  21
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-assincronismo-fastapi'),
  'semana-1-assincronismo-fastapi-essa-rota-fastapi-est-sujeita-a-qual-problema-comu',
  'lesson',
  'code',
  'hard',
  'Essa rota FastAPI está sujeita a qual problema comum, e como corrigir?
```python
@router.post("/reviews")
async def criar_revisao(review: ReviewCreate, user_id: str):
    ...
```',
  null,
  null,
  'O `user_id` está sendo recebido como parâmetro do cliente, permitindo que ele crie dados em nome de outro usuário.',
  'O `user_id` nunca deve vir do cliente — deve ser extraído do usuário autenticado via `Depends(get_current_user)`, para impedir que alguém insira dados como se fosse outra pessoa.',
  false,
  22
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-persistencia-sqlalchemy'),
  'semana-1-persistencia-sqlalchemy-o-que-significa-a-sigla-orm',
  'lesson',
  'multiple_choice',
  'easy',
  'O que significa a sigla ORM?',
  '[{"id": "a", "text": "Object-Relational Mapping"}, {"id": "b", "text": "Online Resource Management"}, {"id": "c", "text": "Object Routing Model"}, {"id": "d", "text": "Optimized Record Mapper"}]'::jsonb,
  'a',
  'Object-Relational Mapping',
  'Um ORM traduz tabelas do banco em classes e linhas em objetos, permitindo manipular dados via código orientado a objetos em vez de SQL cru.',
  false,
  23
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-persistencia-sqlalchemy'),
  'semana-1-persistencia-sqlalchemy-em-um-relacionamento-onde-um-usu-rio-tem-v-rias-re',
  'lesson',
  'multiple_choice',
  'easy',
  'Em um relacionamento onde um usuário tem várias revisões, esse é um relacionamento do tipo:',
  '[{"id": "a", "text": "1:1"}, {"id": "b", "text": "1:N"}, {"id": "c", "text": "N:N"}, {"id": "d", "text": "0:0"}]'::jsonb,
  'b',
  '1:N',
  'Um usuário (1) pode ter várias revisões (N) — cada revisão pertence a um único usuário.',
  false,
  24
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-persistencia-sqlalchemy'),
  'semana-1-persistencia-sqlalchemy-alembic-usado-para-gerenciar-migrations-do-sqlalch',
  'lesson',
  'true_false',
  'easy',
  'Alembic é usado para gerenciar migrations do SQLAlchemy.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'a',
  'Verdadeiro',
  'Alembic gera e versiona scripts que alteram o schema do banco de forma incremental e reversível.',
  false,
  25
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-persistencia-sqlalchemy'),
  'semana-1-persistencia-sqlalchemy-um-relacionamento-n-n-normalmente-implementado-usa',
  'lesson',
  'multiple_choice',
  'easy',
  'Um relacionamento N:N normalmente é implementado usando:',
  '[{"id": "a", "text": "Uma coluna extra na tabela principal"}, {"id": "b", "text": "Uma tabela associativa intermediária"}, {"id": "c", "text": "Um índice único"}, {"id": "d", "text": "Um trigger"}]'::jsonb,
  'b',
  'Uma tabela associativa intermediária',
  'Como cada lado pode se relacionar com vários registros do outro, uma tabela intermediária guarda os pares de IDs relacionados.',
  false,
  26
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-persistencia-sqlalchemy'),
  'semana-1-persistencia-sqlalchemy-qual-a-diferen-a-entre-lazy-loading-e-eager-loadin',
  'lesson',
  'open',
  'medium',
  'Qual a diferença entre lazy loading e eager loading?',
  null,
  null,
  'Lazy loading busca os dados relacionados só quando acessados; eager loading já traz os relacionados na mesma consulta inicial.',
  'Lazy loading é simples mas pode causar o problema de N+1 queries; eager loading (via `joinedload`/`selectinload`) evita isso ao antecipar a busca.',
  false,
  27
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-persistencia-sqlalchemy'),
  'semana-1-persistencia-sqlalchemy-para-carregar-a-lista-de-revis-es-de-v-rios-usu-ri',
  'lesson',
  'multiple_choice',
  'medium',
  'Para carregar a lista de revisões de vários usuários de uma vez, evitando duplicar linhas, qual estratégia costuma ser preferida?',
  '[{"id": "a", "text": "joinedload"}, {"id": "b", "text": "selectinload"}, {"id": "c", "text": "lazy=''dynamic'' sem otimização"}, {"id": "d", "text": "Nenhuma — sempre uma query por usuário"}]'::jsonb,
  'b',
  'selectinload',
  '`selectinload` faz uma segunda query com `IN (...)` para buscar os relacionados em lote, evitando duplicar linhas como pode acontecer com `JOIN` em listas grandes.',
  false,
  28
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-persistencia-sqlalchemy'),
  'semana-1-persistencia-sqlalchemy-o-que-o-problema-n-1-queries',
  'lesson',
  'open',
  'medium',
  'O que é o problema ''N+1 queries''?',
  null,
  null,
  'É quando, para listar N registros, o sistema faz uma query extra para cada um deles ao acessar dados relacionados, totalizando N+1 consultas.',
  'Isso acontece tipicamente com lazy loading em loops — para cada item de uma lista, uma nova query busca seus dados relacionados, ao invés de buscar tudo de uma vez.',
  false,
  29
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-persistencia-sqlalchemy'),
  'semana-1-persistencia-sqlalchemy-o-que-essa-migration-alembic-representa-bash-alemb',
  'lesson',
  'code',
  'medium',
  'O que essa migration Alembic representa?
```bash
alembic revision --autogenerate -m "cria tabela reviews"
alembic upgrade head
```',
  null,
  null,
  'Gera um novo arquivo de migration detectando mudanças no modelo, e depois aplica todas as migrations pendentes ao banco.',
  'O primeiro comando cria o script de migration comparando os modelos com o estado atual do banco; o segundo efetivamente executa as migrations pendentes.',
  false,
  30
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-persistencia-sqlalchemy'),
  'semana-1-persistencia-sqlalchemy-o-que-a-session-do-sqlalchemy-respons-vel-por-gere',
  'lesson',
  'multiple_choice',
  'medium',
  'O que a `Session` do SQLAlchemy é responsável por gerenciar?',
  '[{"id": "a", "text": "Apenas a conexão TCP com o banco"}, {"id": "b", "text": "A unidade de trabalho: objetos carregados e mudanças agrupadas em uma transação"}, {"id": "c", "text": "A geração de relatórios"}, {"id": "d", "text": "A criptografia dos dados"}]'::jsonb,
  'b',
  'A unidade de trabalho: objetos carregados e mudanças agrupadas em uma transação',
  'A Session rastreia os objetos que você manipula e agrupa as mudanças, enviando-as ao banco de forma consistente ao chamar `commit()`.',
  false,
  31
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-persistencia-sqlalchemy'),
  'semana-1-persistencia-sqlalchemy-por-que-alterar-o-schema-de-um-banco-em-produ-o-di',
  'lesson',
  'open',
  'hard',
  'Por que alterar o schema de um banco em produção diretamente via `ALTER TABLE` manual é arriscado, comparado a usar migrations versionadas?',
  null,
  null,
  'Porque não fica registrado, versionado nem reversível — outros ambientes (dev, staging, outros devs) ficam dessincronizados e é difícil saber o que mudou e quando.',
  'Migrations garantem que todo mundo aplique as mesmas mudanças, na mesma ordem, com possibilidade de reverter (`downgrade`) se algo der errado.',
  false,
  32
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-persistencia-sqlalchemy'),
  'semana-1-persistencia-sqlalchemy-esse-c-digo-lista-revis-es-de-50-usu-rios-e-para-c',
  'lesson',
  'code',
  'hard',
  'Esse código lista revisões de 50 usuários e, para cada um, acessa `usuario.reviews`. Qual problema de performance ele tem e como resolver com SQLAlchemy?
```python
usuarios = session.query(User).all()
for u in usuarios:
    print(len(u.reviews))
```',
  null,
  null,
  'Sofre do problema N+1: uma query para buscar usuários + uma query extra por usuário ao acessar `.reviews`. Resolve-se usando `selectinload(User.reviews)` na query original.',
  'Sem eager loading, cada acesso a `.reviews` dispara uma nova query lazy; `selectinload` antecipa essa busca em uma única query adicional para todos os usuários de uma vez.',
  false,
  33
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-mensageria-cache'),
  'semana-1-mensageria-cache-redis-comumente-usado-no-backend-como',
  'lesson',
  'multiple_choice',
  'easy',
  'Redis é comumente usado no backend como:',
  '[{"id": "a", "text": "Sistema de arquivos"}, {"id": "b", "text": "Banco de dados em memória, usado como cache"}, {"id": "c", "text": "Servidor web"}, {"id": "d", "text": "Compilador"}]'::jsonb,
  'b',
  'Banco de dados em memória, usado como cache',
  'Redis guarda dados em memória, o que torna a leitura extremamente rápida — ideal para cachear resultados custosos.',
  false,
  34
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-mensageria-cache'),
  'semana-1-mensageria-cache-o-que-significa-cache-miss',
  'lesson',
  'multiple_choice',
  'easy',
  'O que significa ''cache miss''?',
  '[{"id": "a", "text": "O dado foi encontrado no cache"}, {"id": "b", "text": "O dado não estava no cache e precisou ser buscado na fonte original"}, {"id": "c", "text": "O cache foi apagado"}, {"id": "d", "text": "O cache expirou automaticamente"}]'::jsonb,
  'b',
  'O dado não estava no cache e precisou ser buscado na fonte original',
  'Cache miss é quando a busca no cache não encontra o dado, obrigando a aplicação a buscá-lo na fonte (banco, API externa) e, geralmente, guardá-lo no cache para a próxima vez.',
  false,
  35
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-mensageria-cache'),
  'semana-1-mensageria-cache-celery-usado-para-processar-tarefas-de-forma-s-ncr',
  'lesson',
  'true_false',
  'easy',
  'Celery é usado para processar tarefas de forma síncrona, dentro do ciclo da requisição HTTP.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'Celery processa tarefas em background, fora do ciclo da requisição — por isso o usuário não fica esperando tarefas pesadas terminarem.',
  false,
  36
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-mensageria-cache'),
  'semana-1-mensageria-cache-ttl-no-contexto-de-cache-significa',
  'lesson',
  'multiple_choice',
  'easy',
  'TTL, no contexto de cache, significa:',
  '[{"id": "a", "text": "Time To Live — por quanto tempo o dado fica válido no cache"}, {"id": "b", "text": "Total Transfer Limit"}, {"id": "c", "text": "Type Transformation Layer"}, {"id": "d", "text": "Thread Task List"}]'::jsonb,
  'a',
  'Time To Live — por quanto tempo o dado fica válido no cache',
  'TTL define a expiração automática de uma chave de cache, uma das estratégias mais simples de invalidação.',
  false,
  37
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-mensageria-cache'),
  'semana-1-mensageria-cache-que-tipo-de-dado-bom-candidato-para-cache',
  'lesson',
  'open',
  'medium',
  'Que tipo de dado é bom candidato para cache?',
  null,
  null,
  'Dados lidos com frequência, caros de calcular/buscar, e que não mudam a cada requisição.',
  'Se o dado muda constantemente ou é crítico estar sempre atualizado, cachear exige mais cuidado (ou pode não valer a pena).',
  false,
  38
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-mensageria-cache'),
  'semana-1-mensageria-cache-o-que-esse-trecho-faz-na-pr-tica-python-chave-f-da',
  'lesson',
  'code',
  'medium',
  'O que esse trecho faz, na prática?
```python
chave = f"dashboard:{user_id}"
cache = r.get(chave)
if cache:
    return cache
dados = calcular_dashboard_caro(user_id)
r.set(chave, dados, ex=300)
return dados
```',
  null,
  null,
  'Implementa um cache simples: tenta ler do Redis primeiro; se não existir, calcula, salva no cache com expiração de 5 minutos (300s), e retorna.',
  'Esse é o padrão ''cache-aside'': a aplicação verifica o cache antes de recalcular, e popula o cache após um cache miss.',
  false,
  39
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-mensageria-cache'),
  'semana-1-mensageria-cache-qual-o-maior-desafio-de-trabalhar-com-cache-segund',
  'lesson',
  'multiple_choice',
  'medium',
  'Qual é o maior desafio de trabalhar com cache, segundo o conteúdo da aula?',
  '[{"id": "a", "text": "Escolher a linguagem de programação"}, {"id": "b", "text": "Saber quando invalidar o cache"}, {"id": "c", "text": "Instalar o Redis"}, {"id": "d", "text": "Nenhum, cache não tem desafios"}]'::jsonb,
  'b',
  'Saber quando invalidar o cache',
  'Guardar dados em cache é simples; o difícil é garantir que o cache não sirva dados desatualizados quando a fonte original muda.',
  false,
  40
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-mensageria-cache'),
  'semana-1-mensageria-cache-qual-a-diferen-a-entre-usar-celery-e-usar-backgrou',
  'lesson',
  'open',
  'medium',
  'Qual a diferença entre usar Celery e usar `BackgroundTasks` do FastAPI?',
  null,
  null,
  'Celery é uma fila de tarefas distribuída, com retry e persistência, para tarefas pesadas; `BackgroundTasks` é mais simples, para tarefas leves que não precisam de fila robusta.',
  'Se a tarefa é crítica (não pode se perder se o processo cair) ou muito pesada, Celery é mais indicado; para algo leve como enviar uma notificação simples, `BackgroundTasks` já resolve.',
  false,
  41
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-mensageria-cache'),
  'semana-1-mensageria-cache-um-endpoint-fica-lento-porque-recalcula-o-mesmo-re',
  'lesson',
  'open',
  'hard',
  'Um endpoint fica lento porque recalcula o mesmo relatório a cada requisição. Que solução você aplicaria e por quê?',
  null,
  null,
  'Cachear o resultado do relatório (ex: Redis, com TTL adequado), já que é um dado caro de calcular e não muda a cada request.',
  'Cache resolve exatamente esse cenário: evita repetir um cálculo custoso quando o resultado ainda é válido, reduzindo drasticamente a latência percebida pelo usuário.',
  false,
  42
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-mensageria-cache'),
  'semana-1-mensageria-cache-esse-endpoint-envia-um-email-de-boas-vindas-de-for',
  'lesson',
  'code',
  'hard',
  'Esse endpoint envia um email de boas-vindas de forma síncrona. Reescreva a ideia (sem código completo) explicando como usar Celery para melhorá-lo.
```python
@router.post("/register")
def register(data: UserCreate):
    criar_usuario(data)
    enviar_email_boas_vindas(data.email)  # lento
    return {"ok": True}
```',
  null,
  null,
  'Mover `enviar_email_boas_vindas` para uma task Celery (`enviar_email_boas_vindas.delay(...)`), enfileirando o envio em vez de bloquear a resposta da requisição.',
  'Assim, o endpoint responde rapidamente ao cliente enquanto o email é processado por um worker separado, em background — melhorando a experiência sem perder a tarefa.',
  false,
  43
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-testes-pytest'),
  'semana-1-testes-pytest-qual-status-http-indica-sucesso-na-cria-o-de-um-re',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual status HTTP indica sucesso na criação de um recurso via POST?',
  '[{"id": "a", "text": "200"}, {"id": "b", "text": "201"}, {"id": "c", "text": "204"}, {"id": "d", "text": "400"}]'::jsonb,
  'b',
  '201',
  '201 Created é o status apropriado quando uma requisição POST cria um novo recurso com sucesso.',
  false,
  44
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-testes-pytest'),
  'semana-1-testes-pytest-testes-unit-rios-geralmente-tocam-o-banco-de-dados',
  'lesson',
  'true_false',
  'easy',
  'Testes unitários geralmente tocam o banco de dados real de produção.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'Testes unitários testam uma unidade isolada de código, geralmente sem dependências externas como banco real; isso fica mais para testes de integração, e ainda assim usando um banco de teste.',
  false,
  45
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-testes-pytest'),
  'semana-1-testes-pytest-o-que-uma-fixture-do-pytest-normalmente-faz',
  'lesson',
  'multiple_choice',
  'easy',
  'O que uma fixture do Pytest normalmente faz?',
  '[{"id": "a", "text": "Deixa os testes mais lentos de propósito"}, {"id": "b", "text": "Prepara um contexto reutilizável entre vários testes"}, {"id": "c", "text": "Substitui a necessidade de asserts"}, {"id": "d", "text": "Gera relatórios de cobertura"}]'::jsonb,
  'b',
  'Prepara um contexto reutilizável entre vários testes',
  'Fixtures encapsulam setup comum (ex: um client de teste, dados iniciais) para não repetir esse código em cada função de teste.',
  false,
  46
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-testes-pytest'),
  'semana-1-testes-pytest-qual-status-http-normalmente-indica-que-os-dados-e',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual status HTTP normalmente indica que os dados enviados falharam na validação do Pydantic/FastAPI?',
  '[{"id": "a", "text": "200"}, {"id": "b", "text": "401"}, {"id": "c", "text": "422"}, {"id": "d", "text": "500"}]'::jsonb,
  'c',
  '422',
  '422 Unprocessable Entity é retornado automaticamente pelo FastAPI quando o corpo da requisição não bate com o schema esperado.',
  false,
  47
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-testes-pytest'),
  'semana-1-testes-pytest-para-que-serve-o-mocking-em-testes',
  'lesson',
  'open',
  'medium',
  'Para que serve o mocking em testes?',
  null,
  null,
  'Para substituir uma dependência real (API externa, envio de email) por uma versão controlada, isolando o teste de sistemas instáveis ou lentos.',
  'Com mock, você testa seu próprio código sem depender de serviços de terceiros estarem no ar, respondendo rápido ou de forma previsível.',
  false,
  48
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-testes-pytest'),
  'semana-1-testes-pytest-o-que-esse-teste-est-verificando-python-def-test-l',
  'lesson',
  'code',
  'medium',
  'O que esse teste está verificando?
```python
def test_listar_revisoes(client):
    response = client.get("/reviews")
    assert response.status_code == 200
```',
  null,
  null,
  'Verifica que o endpoint GET /reviews responde com sucesso (200 OK).',
  'É um teste de integração básico do endpoint, confirmando o status HTTP esperado numa chamada bem-sucedida.',
  false,
  49
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-testes-pytest'),
  'semana-1-testes-pytest-por-que-importante-testar-tamb-m-os-casos-de-erro-',
  'lesson',
  'multiple_choice',
  'medium',
  'Por que é importante testar também os casos de erro (não só o caminho feliz)?',
  '[{"id": "a", "text": "Não é importante, só o sucesso importa"}, {"id": "b", "text": "Porque falhas de validação, dados ausentes e erros de permissão são situações reais que o sistema deve tratar corretamente"}, {"id": "c", "text": "Porque aumenta artificialmente a cobertura"}, {"id": "d", "text": "Porque o Pytest exige isso"}]'::jsonb,
  'b',
  'Porque falhas de validação, dados ausentes e erros de permissão são situações reais que o sistema deve tratar corretamente',
  'Testar só o caminho feliz deixa brechas: bugs em tratamento de erro só aparecem em produção, quando já afetam usuários reais.',
  false,
  50
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-testes-pytest'),
  'semana-1-testes-pytest-o-que-caracteriza-uma-boa-estrat-gia-de-testes-pir',
  'lesson',
  'open',
  'medium',
  'O que caracteriza uma boa estratégia de testes (pirâmide de testes)?',
  null,
  null,
  'Muitos testes unitários rápidos na base, um número moderado de testes de integração, e poucos testes end-to-end mais lentos no topo.',
  'Essa distribuição equilibra velocidade de execução (testes unitários rodam rápido) com confiança de que o sistema funciona de ponta a ponta.',
  false,
  51
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-testes-pytest'),
  'semana-1-testes-pytest-esse-teste-usa-mock-para-o-envio-de-email-explique',
  'lesson',
  'code',
  'hard',
  'Esse teste usa mock para o envio de email. Explique o que `mock_email.assert_called_once()` verifica.
```python
@patch("app.services.enviar_email")
def test_cadastro_dispara_email(mock_email, client):
    client.post("/register", json={"email": "a@a.com"})
    mock_email.assert_called_once()
```',
  null,
  null,
  'Verifica que a função `enviar_email` foi chamada exatamente uma vez durante o teste — confirmando que o cadastro realmente dispara o envio de email, sem múltiplos disparos indevidos.',
  'Isso garante o comportamento esperado (email disparado) sem depender de um serviço de email real durante o teste.',
  false,
  52
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-testes-pytest'),
  'semana-1-testes-pytest-um-endpoint-de-cadastro-tem-um-teste-que-s-verific',
  'lesson',
  'open',
  'hard',
  'Um endpoint de cadastro tem um teste que só verifica `status_code == 201`. Que problema isso pode esconder, e o que adicionar ao teste?',
  null,
  null,
  'Pode esconder que o registro foi criado com dados errados/incompletos. Deveria também verificar o corpo da resposta (ou buscar o registro no banco) para confirmar que os dados salvos batem com o esperado.',
  'Um teste que só olha o status HTTP não garante que a lógica de negócio funcionou corretamente — testar o conteúdo do resultado é essencial para pegar bugs sutis.',
  false,
  53
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-html5-acessibilidade'),
  'semana-2-html5-acessibilidade-qual-tag-sem-ntica-representa-o-conte-do-principal',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual tag semântica representa o conteúdo principal e único de uma página?',
  '[{"id": "a", "text": "<section>"}, {"id": "b", "text": "<main>"}, {"id": "c", "text": "<div>"}, {"id": "d", "text": "<article>"}]'::jsonb,
  'b',
  '<main>',
  '`<main>` marca o conteúdo principal da página — deve haver apenas um por página.',
  false,
  54
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-html5-acessibilidade'),
  'semana-2-html5-acessibilidade-usar-div-para-tudo-equivalente-em-acessibilidade-a',
  'lesson',
  'true_false',
  'easy',
  'Usar `<div>` para tudo é equivalente, em acessibilidade, a usar tags semânticas.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  '`<div>` não comunica nada sobre o papel do conteúdo; tags semânticas ajudam leitores de tela e motores de busca a entender a estrutura.',
  false,
  55
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-html5-acessibilidade'),
  'semana-2-html5-acessibilidade-todo-campo-de-formul-rio-deve-ter-um-elemento-asso',
  'lesson',
  'multiple_choice',
  'easy',
  'Todo campo de formulário deve ter um elemento associado para acessibilidade:',
  '[{"id": "a", "text": "<span>"}, {"id": "b", "text": "<label>"}, {"id": "c", "text": "<b>"}, {"id": "d", "text": "<pre>"}]'::jsonb,
  'b',
  '<label>',
  '`<label>` associado ao input permite que leitores de tela anunciem o propósito do campo, e que clicar no texto foque o input.',
  false,
  56
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-html5-acessibilidade'),
  'semana-2-html5-acessibilidade-o-que-o-dom',
  'lesson',
  'multiple_choice',
  'easy',
  'O que é o DOM?',
  '[{"id": "a", "text": "Um banco de dados do navegador"}, {"id": "b", "text": "A representação em árvore do HTML que o navegador constrói"}, {"id": "c", "text": "Um protocolo de rede"}, {"id": "d", "text": "Uma linguagem de estilo"}]'::jsonb,
  'b',
  'A representação em árvore do HTML que o navegador constrói',
  'O DOM (Document Object Model) é a estrutura em árvore que o JavaScript manipula para atualizar a interface dinamicamente.',
  false,
  57
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-html5-acessibilidade'),
  'semana-2-html5-acessibilidade-por-que-colocar-scripts-no-fim-do-body-ou-usar-def',
  'lesson',
  'open',
  'medium',
  'Por que colocar scripts no fim do `<body>` (ou usar `defer`) é uma boa prática?',
  null,
  null,
  'Porque garante que o DOM já foi construído antes do script tentar manipular elementos da página.',
  'O navegador processa o HTML de cima para baixo; se o script rodar antes dos elementos existirem, tentativas de selecioná-los falham.',
  false,
  58
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-html5-acessibilidade'),
  'semana-2-html5-acessibilidade-qual-tag-mais-apropriada-para-um-post-de-blog-inde',
  'lesson',
  'multiple_choice',
  'medium',
  'Qual tag é mais apropriada para um post de blog independente, que faz sentido sozinho?',
  '[{"id": "a", "text": "<section>"}, {"id": "b", "text": "<article>"}, {"id": "c", "text": "<aside>"}, {"id": "d", "text": "<nav>"}]'::jsonb,
  'b',
  '<article>',
  '`<article>` representa conteúdo independente que poderia ser distribuído ou reutilizado isoladamente, como um post ou notícia.',
  false,
  59
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-html5-acessibilidade'),
  'semana-2-html5-acessibilidade-como-html-sem-ntico-beneficia-seo',
  'lesson',
  'open',
  'medium',
  'Como HTML semântico beneficia SEO?',
  null,
  null,
  'Motores de busca leem a estrutura semântica (headings, article, nav) para entender do que trata a página e como ela está organizada.',
  'Uma hierarquia clara de `<h1>` a `<h6>` e tags que indicam papel do conteúdo ajudam o ranqueamento e a indexação correta da página.',
  false,
  60
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-html5-acessibilidade'),
  'semana-2-html5-acessibilidade-uma-p-gina-pode-ter-v-rios-elementos-h1-desde-que-',
  'lesson',
  'true_false',
  'medium',
  'Uma página pode ter vários elementos `<h1>`, desde que estilizados de forma diferente.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'A boa prática é ter um único `<h1>` por página, representando o título principal; múltiplos `<h1>` prejudicam a hierarquia semântica.',
  false,
  61
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-html5-acessibilidade'),
  'semana-2-html5-acessibilidade-um-formul-rio-de-login-tem-inputs-sem-label-apenas',
  'lesson',
  'open',
  'hard',
  'Um formulário de login tem inputs sem `<label>`, apenas com `placeholder`. Por que isso é um problema de acessibilidade?',
  null,
  null,
  'Porque o placeholder desaparece ao digitar e não é lido de forma confiável por todos os leitores de tela; sem `<label>`, o usuário perde a referência do que o campo pede.',
  '`<label>` é a forma correta e persistente de descrever um campo; placeholder é um complemento, não substituto.',
  false,
  62
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-html5-acessibilidade'),
  'semana-2-html5-acessibilidade-o-que-est-semanticamente-errado-nesta-estrutura-ht',
  'lesson',
  'code',
  'hard',
  'O que está semanticamente errado nesta estrutura?
```html
<div class="header">...</div>
<div class="nav">...</div>
<div class="main-content">...</div>
```',
  null,
  null,
  'Todos os blocos usam `<div>` genérica em vez das tags semânticas equivalentes: `<header>`, `<nav>` e `<main>`.',
  'Usar `<div>` com classes que imitam nomes semânticos não dá os benefícios reais de acessibilidade e SEO que as tags nativas oferecem.',
  false,
  63
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-css3-layouts'),
  'semana-2-css3-layouts-na-ordem-do-box-model-o-que-fica-imediatamente-ent',
  'lesson',
  'multiple_choice',
  'easy',
  'Na ordem do Box Model, o que fica imediatamente entre o conteúdo e a borda?',
  '[{"id": "a", "text": "Margin"}, {"id": "b", "text": "Padding"}, {"id": "c", "text": "Outline"}, {"id": "d", "text": "Position"}]'::jsonb,
  'b',
  'Padding',
  'A ordem é: conteúdo → padding (espaço interno) → border (borda) → margin (espaço externo).',
  false,
  64
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-css3-layouts'),
  'semana-2-css3-layouts-flexbox-organiza-itens-em-duas-dimens-es-linhas-e-',
  'lesson',
  'true_false',
  'easy',
  'Flexbox organiza itens em duas dimensões (linhas e colunas simultaneamente).',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'Flexbox trabalha em uma dimensão por vez (linha OU coluna); para duas dimensões simultâneas, usa-se Grid.',
  false,
  65
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-css3-layouts'),
  'semana-2-css3-layouts-qual-valor-de-position-faz-um-elemento-ficar-fixo-',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual valor de `position` faz um elemento ficar fixo na tela, ignorando o scroll?',
  '[{"id": "a", "text": "static"}, {"id": "b", "text": "relative"}, {"id": "c", "text": "absolute"}, {"id": "d", "text": "fixed"}]'::jsonb,
  'd',
  'fixed',
  '`position: fixed` posiciona o elemento em relação à janela do navegador, permanecendo visível mesmo ao rolar a página.',
  false,
  66
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-css3-layouts'),
  'semana-2-css3-layouts-o-que-uma-media-query-faz',
  'lesson',
  'multiple_choice',
  'easy',
  'O que uma media query faz?',
  '[{"id": "a", "text": "Aplica estilos condicionalmente conforme características da tela (ex: largura)"}, {"id": "b", "text": "Carrega uma fonte customizada"}, {"id": "c", "text": "Compacta o CSS"}, {"id": "d", "text": "Cria uma animação"}]'::jsonb,
  'a',
  'Aplica estilos condicionalmente conforme características da tela (ex: largura)',
  'Media queries permitem, por exemplo, mostrar um layout diferente a partir de determinada largura de tela, base da responsividade.',
  false,
  67
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-css3-layouts'),
  'semana-2-css3-layouts-por-que-box-sizing-border-box-recomendado-na-maior',
  'lesson',
  'open',
  'medium',
  'Por que `box-sizing: border-box` é recomendado na maioria dos projetos?',
  null,
  null,
  'Porque faz com que padding e border sejam incluídos no width/height definido, evitando que o elemento fique maior do que o esperado.',
  'Sem `border-box`, padding e border SOMAM ao width definido; com `border-box`, o tamanho total do elemento continua sendo o valor definido em `width`.',
  false,
  68
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-css3-layouts'),
  'semana-2-css3-layouts-para-alinhar-itens-em-uma-nica-linha-horizontal-co',
  'lesson',
  'multiple_choice',
  'medium',
  'Para alinhar itens em uma única linha horizontal com espaçamento uniforme entre eles, qual propriedade de Flexbox usar?',
  '[{"id": "a", "text": "flex-direction: column"}, {"id": "b", "text": "justify-content: space-between"}, {"id": "c", "text": "position: absolute"}, {"id": "d", "text": "grid-template-columns"}]'::jsonb,
  'b',
  'justify-content: space-between',
  '`justify-content: space-between` distribui o espaço disponível igualmente entre os itens de um container flex.',
  false,
  69
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-css3-layouts'),
  'semana-2-css3-layouts-o-que-esse-css-produz-visualmente-css-grid-display',
  'lesson',
  'code',
  'medium',
  'O que esse CSS produz visualmente?
```css
.grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
}
```',
  null,
  null,
  'Um grid de 3 colunas de larguras iguais (1fr cada), com 16px de espaçamento entre os itens.',
  '`repeat(3, 1fr)` cria três faixas de mesma largura, e `gap` adiciona espaço uniforme entre linhas e colunas do grid.',
  false,
  70
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-css3-layouts'),
  'semana-2-css3-layouts-quando-usar-flexbox-em-vez-de-grid',
  'lesson',
  'open',
  'medium',
  'Quando usar Flexbox em vez de Grid?',
  null,
  null,
  'Quando o layout é predominantemente unidimensional — uma linha ou coluna de itens, como uma barra de navegação ou lista de cards em fileira.',
  'Grid brilha quando você precisa controlar linhas E colunas ao mesmo tempo, como o layout geral de uma página.',
  false,
  71
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-css3-layouts'),
  'semana-2-css3-layouts-por-que-este-elemento-fica-maior-do-que-os-200px-e',
  'lesson',
  'code',
  'hard',
  'Por que este elemento fica maior do que os 200px esperados?
```css
.card {
  width: 200px;
  padding: 20px;
  border: 2px solid #ccc;
}
```',
  null,
  null,
  'Porque, sem `box-sizing: border-box`, o padding (20px de cada lado) e a borda (2px de cada lado) são somados ao width, resultando em uma largura total maior que 200px.',
  'O tamanho real seria 200 + 20*2 + 2*2 = 244px. Adicionar `box-sizing: border-box` faz o width final permanecer em 200px.',
  false,
  72
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-css3-layouts'),
  'semana-2-css3-layouts-dois-elementos-com-position-absolute-dentro-de-um-',
  'lesson',
  'open',
  'hard',
  'Dois elementos com `position: absolute` dentro de um container sem `position` definida se comportam de forma inesperada. Por quê?',
  null,
  null,
  'Porque `position: absolute` posiciona o elemento em relação ao ancestral posicionado mais próximo (que tenha `position` diferente de `static`); se nenhum ancestral tiver isso, ele se posiciona relativo ao `<html>`.',
  'Para conter elementos absolutos dentro de um container específico, o container precisa ter `position: relative` (ou outro valor não-static).',
  false,
  73
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-tailwind-responsividade'),
  'semana-2-tailwind-responsividade-tailwind-css-descrito-como-um-framework',
  'lesson',
  'multiple_choice',
  'easy',
  'Tailwind CSS é descrito como um framework:',
  '[{"id": "a", "text": "Component-first"}, {"id": "b", "text": "Utility-first"}, {"id": "c", "text": "Semantic-first"}, {"id": "d", "text": "Animation-first"}]'::jsonb,
  'b',
  'Utility-first',
  'Em vez de escrever CSS customizado com nomes de classe semânticos, você compõe classes utilitárias pequenas diretamente na marcação.',
  false,
  74
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-tailwind-responsividade'),
  'semana-2-tailwind-responsividade-no-tailwind-classes-sem-prefixo-como-flex-valem-s-',
  'lesson',
  'true_false',
  'easy',
  'No Tailwind, classes sem prefixo (como `flex`) valem só para telas grandes.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'Tailwind é mobile-first: classes sem prefixo valem para qualquer tamanho de tela; prefixos como `lg:` aplicam a partir daquele breakpoint.',
  false,
  75
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-tailwind-responsividade'),
  'semana-2-tailwind-responsividade-o-que-a-classe-hover-bg-blue-700-faz',
  'lesson',
  'multiple_choice',
  'easy',
  'O que a classe `hover:bg-blue-700` faz?',
  '[{"id": "a", "text": "Aplica o fundo azul sempre"}, {"id": "b", "text": "Aplica o fundo azul só quando o mouse passa por cima do elemento"}, {"id": "c", "text": "Remove o fundo ao passar o mouse"}, {"id": "d", "text": "É inválida no Tailwind"}]'::jsonb,
  'b',
  'Aplica o fundo azul só quando o mouse passa por cima do elemento',
  'O prefixo `hover:` aplica a classe condicionalmente, só no estado de hover, sem precisar de CSS customizado ou JavaScript.',
  false,
  76
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-tailwind-responsividade'),
  'semana-2-tailwind-responsividade-o-que-este-trecho-faz-em-termos-de-responsividade-',
  'lesson',
  'code',
  'medium',
  'O que este trecho faz, em termos de responsividade?
```html
<div class="flex flex-col gap-4 lg:flex-row">
```',
  null,
  null,
  'Empilha os itens em coluna por padrão (mobile) e muda para linha (lado a lado) a partir do breakpoint `lg`.',
  'Classes sem prefixo valem para qualquer tela; `lg:flex-row` sobrescreve `flex-col` só a partir de telas grandes — abordagem mobile-first.',
  false,
  77
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-tailwind-responsividade'),
  'semana-2-tailwind-responsividade-qual-a-vantagem-pr-tica-de-extrair-um-componente-r',
  'lesson',
  'open',
  'medium',
  'Qual a vantagem prática de extrair um componente reutilizável em vez de duplicar uma longa string de classes Tailwind em vários lugares?',
  null,
  null,
  'Evita repetição e inconsistência: se o estilo precisar mudar, é alterado em um único lugar (o componente) em vez de em cada ocorrência duplicada.',
  'Isso segue o princípio DRY aplicado à UI — a combinação de classes vira a ''fonte da verdade'' visual daquele elemento.',
  false,
  78
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-tailwind-responsividade'),
  'semana-2-tailwind-responsividade-como-o-tailwind-ajuda-a-manter-consist-ncia-visual',
  'lesson',
  'multiple_choice',
  'medium',
  'Como o Tailwind ajuda a manter consistência visual entre componentes diferentes?',
  '[{"id": "a", "text": "Não ajuda, cada dev escolhe valores livremente"}, {"id": "b", "text": "Usa uma escala consistente de espaçamento e tipografia predefinida"}, {"id": "c", "text": "Gera CSS aleatório"}, {"id": "d", "text": "Exige um design system separado obrigatoriamente"}]'::jsonb,
  'b',
  'Usa uma escala consistente de espaçamento e tipografia predefinida',
  'A escala de valores (`p-1`...`p-96`, `text-xs`...`text-9xl`) evita que cada desenvolvedor escolha valores arbitrários, mantendo consistência.',
  false,
  79
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-tailwind-responsividade'),
  'semana-2-tailwind-responsividade-um-componente-tem-no-mobile-os-itens-muito-pr-ximo',
  'lesson',
  'open',
  'hard',
  'Um componente tem, no mobile, os itens muito próximos uns dos outros, dificultando o toque. Como corrigir isso pensando em mobile-first no Tailwind?',
  null,
  null,
  'Aumentar o `gap`/`padding` na versão sem prefixo (mobile) e, se necessário, reduzir esses valores só a partir de um breakpoint maior, já que o problema é justamente na tela pequena.',
  'Como Tailwind é mobile-first, o estilo ''base'' (sem prefixo) deve já atender bem o mobile; ajustes para telas maiores vêm depois, com `sm:`/`lg:` etc.',
  false,
  80
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-core-javascript'),
  'semana-2-core-javascript-qual-declara-o-de-vari-vel-tem-escopo-de-bloco-e-n',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual declaração de variável tem escopo de bloco e não pode ser reatribuída?',
  '[{"id": "a", "text": "var"}, {"id": "b", "text": "let"}, {"id": "c", "text": "const"}, {"id": "d", "text": "Todas as anteriores"}]'::jsonb,
  'c',
  'const',
  '`const` tem escopo de bloco (como `let`) e impede reatribuição da variável — embora o conteúdo de um objeto/array ainda possa ser alterado.',
  false,
  81
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-core-javascript'),
  'semana-2-core-javascript-var-tem-escopo-de-bloco-igual-let',
  'lesson',
  'true_false',
  'easy',
  '`var` tem escopo de bloco, igual `let`.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  '`var` tem escopo de FUNÇÃO, não de bloco; `let`/`const` têm escopo de bloco (dentro de `{ }`).',
  false,
  82
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-core-javascript'),
  'semana-2-core-javascript-o-que-document-queryselector-salvar-faz',
  'lesson',
  'multiple_choice',
  'easy',
  'O que `document.querySelector(''#salvar'')` faz?',
  '[{"id": "a", "text": "Cria um novo elemento com id ''salvar''"}, {"id": "b", "text": "Busca o primeiro elemento com id ''salvar'' no DOM"}, {"id": "c", "text": "Remove o elemento com id ''salvar''"}, {"id": "d", "text": "Estilo CSS do elemento"}]'::jsonb,
  'b',
  'Busca o primeiro elemento com id ''salvar'' no DOM',
  '`querySelector` recebe um seletor CSS e retorna o primeiro elemento correspondente encontrado no DOM.',
  false,
  83
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-core-javascript'),
  'semana-2-core-javascript-o-que-este-c-digo-imprime-javascript-console-log-x',
  'lesson',
  'code',
  'medium',
  'O que este código imprime?
```javascript
console.log(x);
var x = 10;
```',
  null,
  null,
  'undefined',
  '`var` sofre hoisting: a declaração é ''içada'' para o topo do escopo, mas a atribuição do valor não — por isso `x` existe mas ainda é `undefined` no momento do console.log.',
  false,
  84
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-core-javascript'),
  'semana-2-core-javascript-o-que-uma-closure-em-termos-simples',
  'lesson',
  'open',
  'medium',
  'O que é uma closure, em termos simples?',
  null,
  null,
  'É quando uma função ''lembra'' e continua acessando variáveis do escopo onde foi criada, mesmo depois que esse escopo já terminou de executar.',
  'Closures são a base de padrões como contadores privados, debounce e os hooks do React — permitem manter estado ''preso'' a uma função.',
  false,
  85
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-core-javascript'),
  'semana-2-core-javascript-qual-o-resultado-de-chamar-contador-duas-vezes-seg',
  'lesson',
  'code',
  'medium',
  'Qual o resultado de chamar `contador()` duas vezes seguidas?
```javascript
function criarContador() {
  let contagem = 0;
  return function () {
    contagem++;
    return contagem;
  };
}
const contador = criarContador();
contador();
contador();
```',
  null,
  null,
  'A segunda chamada retorna 2 (a primeira retorna 1).',
  'Graças à closure, `contagem` persiste entre as chamadas da função retornada — cada chamada incrementa o valor guardado no escopo da closure.',
  false,
  86
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-core-javascript'),
  'semana-2-core-javascript-por-que-let-const-s-o-geralmente-preferidos-a-var-',
  'lesson',
  'multiple_choice',
  'medium',
  'Por que `let`/`const` são geralmente preferidos a `var` em código novo?',
  '[{"id": "a", "text": "Porque `var` foi removido do JavaScript"}, {"id": "b", "text": "Porque o escopo de bloco de `let`/`const` evita bugs sutis de vazamento de variável"}, {"id": "c", "text": "Não há diferença real"}, {"id": "d", "text": "Porque `var` é mais lento"}]'::jsonb,
  'b',
  'Porque o escopo de bloco de `let`/`const` evita bugs sutis de vazamento de variável',
  'Com `var`, uma variável declarada dentro de um `if` ou `for` continua acessível fora dele, o que pode causar bugs difíceis de rastrear.',
  false,
  87
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-core-javascript'),
  'semana-2-core-javascript-por-que-este-c-digo-imprime-3-3-3-em-vez-de-0-1-2-',
  'lesson',
  'code',
  'hard',
  'Por que este código imprime `3, 3, 3` em vez de `0, 1, 2`, e como corrigir usando `let`?
```javascript
for (var i = 0; i < 3; i++) {
  setTimeout(() => console.log(i), 0);
}
```',
  null,
  null,
  'Porque `var` tem escopo de função, então todas as três funções do `setTimeout` compartilham a MESMA variável `i`, que já vale 3 quando elas executam. Trocar `var` por `let` cria uma nova `i` por iteração, resolvendo o problema.',
  'Esse é um exemplo clássico de como o escopo de bloco de `let` evita um bug muito comum em loops com callbacks assíncronos.',
  false,
  88
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-javascript-assincrono'),
  'semana-2-javascript-assincrono-qual-m-todo-de-array-retorna-um-novo-array-com-ite',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual método de array retorna um NOVO array com itens transformados, sem alterar o original?',
  '[{"id": "a", "text": "forEach"}, {"id": "b", "text": "map"}, {"id": "c", "text": "push"}, {"id": "d", "text": "splice"}]'::jsonb,
  'b',
  'map',
  '`map` cria um novo array aplicando uma função a cada item, sem modificar o array original — diferente de `forEach`, que não retorna nada.',
  false,
  89
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-javascript-assincrono'),
  'semana-2-javascript-assincrono-uma-promise-pendente-pode-terminar-em-sucesso-ou-e',
  'lesson',
  'true_false',
  'easy',
  'Uma `Promise` pendente pode terminar em sucesso ou em erro.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'a',
  'Verdadeiro',
  'Uma Promise representa um valor futuro que eventualmente é resolvido (sucesso, tratado com `.then`) ou rejeitado (erro, tratado com `.catch`).',
  false,
  90
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-javascript-assincrono'),
  'semana-2-javascript-assincrono-qual-m-todo-filtra-um-array-retornando-s-os-itens-',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual método filtra um array retornando só os itens que passam num teste?',
  '[{"id": "a", "text": "reduce"}, {"id": "b", "text": "filter"}, {"id": "c", "text": "find"}, {"id": "d", "text": "map"}]'::jsonb,
  'b',
  'filter',
  '`filter` retorna um novo array contendo apenas os elementos para os quais a função de teste retornou `true`.',
  false,
  91
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-javascript-assincrono'),
  'semana-2-javascript-assincrono-o-que-numeros-reduce-soma-n-soma-n-0-faz-com-numer',
  'lesson',
  'code',
  'medium',
  'O que `numeros.reduce((soma, n) => soma + n, 0)` faz com `numeros = [1, 2, 3, 4, 5]`?',
  null,
  null,
  'Retorna 15 (a soma de todos os elementos).',
  '`reduce` acumula um valor percorrendo o array; aqui, começa em 0 e vai somando cada número, resultando no total.',
  false,
  92
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-javascript-assincrono'),
  'semana-2-javascript-assincrono-por-que-async-await-costuma-ser-preferido-a-encade',
  'lesson',
  'open',
  'medium',
  'Por que `async`/`await` costuma ser preferido a encadear vários `.then()`?',
  null,
  null,
  'Porque deixa o código assíncrono com aparência mais linear e legível, parecido com código síncrono, facilitando o tratamento de erros com try/catch.',
  'Cadeias longas de `.then()` ficam difíceis de ler e depurar; `async`/`await` é açúcar sintático sobre Promises que resolve isso.',
  false,
  93
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-javascript-assincrono'),
  'semana-2-javascript-assincrono-esse-c-digo-tem-um-problema-de-tratamento-de-erro-',
  'lesson',
  'code',
  'medium',
  'Esse código tem um problema de tratamento de erro. Qual é?
```javascript
async function carregarDados() {
  const res = await fetch("/api/dados");
  return await res.json();
}
```',
  null,
  null,
  'Não verifica se `res.ok` é verdadeiro nem trata falhas de rede/parsing — se a requisição falhar ou retornar erro HTTP, o código não trata isso adequadamente.',
  'Faltam `try/catch` e uma verificação de `res.ok`, para lançar um erro tratável quando a resposta não for bem-sucedida.',
  false,
  94
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-javascript-assincrono'),
  'semana-2-javascript-assincrono-entre-microtasks-e-macrotasks-qual-tem-prioridade-',
  'lesson',
  'multiple_choice',
  'medium',
  'Entre microtasks e macrotasks, qual tem prioridade de execução no Event Loop?',
  '[{"id": "a", "text": "Macrotasks (setTimeout)"}, {"id": "b", "text": "Microtasks (Promises)"}, {"id": "c", "text": "Ambas têm a mesma prioridade"}, {"id": "d", "text": "Depende do navegador"}]'::jsonb,
  'b',
  'Microtasks (Promises)',
  'Microtasks (como as callbacks de Promises) são processadas antes das macrotasks (como `setTimeout`) a cada ciclo do Event Loop.',
  false,
  95
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-javascript-assincrono'),
  'semana-2-javascript-assincrono-como-voc-corrigiria-este-c-digo-para-tratar-erros-',
  'lesson',
  'code',
  'hard',
  'Como você corrigiria este código para tratar erros de forma adequada?
```javascript
async function carregarRevisoes() {
  const res = await fetch("/api/reviews");
  return await res.json();
}
```',
  null,
  null,
  'Envolver em try/catch, verificar `res.ok` antes de fazer parsing, e lançar/tratar um erro claro em caso de falha — retornando um valor de fallback ou propagando o erro para quem chamou tratar.',
  'Sem isso, uma falha de rede ou um erro HTTP (como 500) faz o código tentar interpretar uma resposta de erro como JSON válido, ou simplesmente propaga uma exceção não tratada.',
  false,
  96
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-javascript-assincrono'),
  'semana-2-javascript-assincrono-por-que-numeros-map-filter-reduce-encadeados-podem',
  'lesson',
  'open',
  'hard',
  'Por que `numeros.map(...).filter(...).reduce(...)` encadeados podem ser menos eficientes que um único loop manual em arrays muito grandes, mesmo sendo mais legíveis?',
  null,
  null,
  'Porque cada método (`map`, `filter`, `reduce`) percorre o array inteiro, criando arrays intermediários — um loop manual único percorreria os dados apenas uma vez.',
  'Na prática, para a maioria dos tamanhos de dados essa diferença é desprezível frente ao ganho de legibilidade; só vale otimizar isso se houver um gargalo de performance real e medido.',
  false,
  97
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-fundamentos-react'),
  'semana-3-fundamentos-react-o-que-o-virtual-dom',
  'lesson',
  'multiple_choice',
  'easy',
  'O que é o Virtual DOM?',
  '[{"id": "a", "text": "Uma cópia do DOM guardada no servidor"}, {"id": "b", "text": "Uma representação em memória da UI que o React usa para calcular mudanças eficientemente"}, {"id": "c", "text": "Um plugin do navegador"}, {"id": "d", "text": "Um banco de dados"}]'::jsonb,
  'b',
  'Uma representação em memória da UI que o React usa para calcular mudanças eficientemente',
  'O React compara a versão anterior e a nova do Virtual DOM (reconciliation) e atualiza no DOM real só o que mudou.',
  false,
  98
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-fundamentos-react'),
  'semana-3-fundamentos-react-em-react-os-dados-fluem-tipicamente-de-componentes',
  'lesson',
  'true_false',
  'easy',
  'Em React, os dados fluem tipicamente de componentes filhos para os pais.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'O fluxo de dados em React é unidirecional: de pais para filhos, via props. Comunicação de filho para pai acontece via callbacks passados como prop.',
  false,
  99
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-fundamentos-react'),
  'semana-3-fundamentos-react-props-em-um-componente-react-s-o',
  'lesson',
  'multiple_choice',
  'easy',
  'Props em um componente React são:',
  '[{"id": "a", "text": "Variáveis globais"}, {"id": "b", "text": "Parâmetros que um componente recebe do componente pai"}, {"id": "c", "text": "Estilos CSS"}, {"id": "d", "text": "Hooks"}]'::jsonb,
  'b',
  'Parâmetros que um componente recebe do componente pai',
  'Props (propriedades) são a forma padrão de passar dados de um componente pai para um filho.',
  false,
  100
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-fundamentos-react'),
  'semana-3-fundamentos-react-jsx',
  'lesson',
  'multiple_choice',
  'easy',
  'JSX é:',
  '[{"id": "a", "text": "Uma linguagem de banco de dados"}, {"id": "b", "text": "Uma extensão de sintaxe que permite escrever marcação HTML-like dentro do JavaScript"}, {"id": "c", "text": "Um framework CSS"}, {"id": "d", "text": "Um gerenciador de pacotes"}]'::jsonb,
  'b',
  'Uma extensão de sintaxe que permite escrever marcação HTML-like dentro do JavaScript',
  'JSX é compilado para chamadas de função (`React.createElement`), permitindo descrever a UI de forma declarativa.',
  false,
  101
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-fundamentos-react'),
  'semana-3-fundamentos-react-por-que-este-c-digo-considerado-incorreto-em-react',
  'lesson',
  'code',
  'medium',
  'Por que este código é considerado incorreto em React?
```javascript
function adicionarItem(lista, novoItem) {
  lista.push(novoItem);
  setLista(lista);
}
```',
  null,
  null,
  'Muta o array original (`lista.push`) em vez de criar uma nova referência — React não detecta a mudança corretamente sem uma nova referência.',
  'O correto seria `setLista([...lista, novoItem])`, criando um novo array. React compara referências para decidir se deve re-renderizar.',
  false,
  102
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-fundamentos-react'),
  'semana-3-fundamentos-react-o-que-acontece-quando-o-estado-ou-as-props-de-um-c',
  'lesson',
  'open',
  'medium',
  'O que acontece quando o estado ou as props de um componente mudam?',
  null,
  null,
  'O React re-renderiza aquele componente e seus componentes filhos.',
  'Essa é a base do modelo reativo do React: mudanças de dados disparam automaticamente uma nova renderização da UI correspondente.',
  false,
  103
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-fundamentos-react'),
  'semana-3-fundamentos-react-como-um-componente-filho-pode-avisar-o-componente-',
  'lesson',
  'multiple_choice',
  'medium',
  'Como um componente filho pode ''avisar'' o componente pai sobre um evento (ex: um clique)?',
  '[{"id": "a", "text": "Alterando diretamente uma variável global"}, {"id": "b", "text": "Recebendo uma função como prop e chamando-a"}, {"id": "c", "text": "Usando document.querySelector"}, {"id": "d", "text": "Não é possível"}]'::jsonb,
  'b',
  'Recebendo uma função como prop e chamando-a',
  'O pai passa uma função como prop (callback); o filho a invoca quando o evento ocorre, mantendo o fluxo de dados previsível.',
  false,
  104
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-fundamentos-react'),
  'semana-3-fundamentos-react-por-que-a-reconciliation-do-react-considerada-mais',
  'lesson',
  'open',
  'hard',
  'Por que a ''reconciliation'' do React é considerada mais eficiente do que recriar toda a página a cada mudança?',
  null,
  null,
  'Porque compara a árvore de Virtual DOM anterior com a nova e aplica no DOM real apenas as diferenças mínimas necessárias, evitando trabalho desnecessário do navegador.',
  'Manipular o DOM real é uma operação cara; minimizar essas operações via um algoritmo de diffing eficiente é o que torna o React performático mesmo com atualizações frequentes.',
  false,
  105
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-fundamentos-react'),
  'semana-3-fundamentos-react-esse-componente-tem-um-bug-de-imutabilidade-identi',
  'lesson',
  'code',
  'hard',
  'Esse componente tem um bug de imutabilidade. Identifique-o.
```jsx
function Lista({ itens }) {
  const [selecionados, setSelecionados] = useState([]);
  function toggle(item) {
    if (selecionados.includes(item)) {
      selecionados.splice(selecionados.indexOf(item), 1);
    } else {
      selecionados.push(item);
    }
    setSelecionados(selecionados);
  }
  ...
}
```',
  null,
  null,
  '`splice` e `push` mutam o array `selecionados` diretamente; o React pode não perceber a mudança de estado porque a referência do array não mudou.',
  'O correto seria criar um novo array em cada caso, por exemplo usando `filter` para remover e spread (`[...selecionados, item]`) para adicionar.',
  false,
  106
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-hooks-avancados'),
  'semana-3-hooks-avancados-qual-hook-executa-c-digo-fora-do-fluxo-normal-de-r',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual hook executa código fora do fluxo normal de renderização, como chamadas de API?',
  '[{"id": "a", "text": "useState"}, {"id": "b", "text": "useEffect"}, {"id": "c", "text": "useMemo"}, {"id": "d", "text": "useRef"}]'::jsonb,
  'b',
  'useEffect',
  '`useEffect` roda efeitos colaterais depois que o componente renderiza, ideal para chamadas de API, subscriptions, etc.',
  false,
  107
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-hooks-avancados'),
  'semana-3-hooks-avancados-um-array-de-depend-ncias-vazio-no-useeffect-faz-o-',
  'lesson',
  'true_false',
  'easy',
  'Um array de dependências vazio (`[]`) no `useEffect` faz o efeito rodar a cada renderização.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'Um array vazio `[]` faz o efeito rodar apenas uma vez, na montagem do componente. Sem array nenhum é que roda a cada renderização.',
  false,
  108
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-hooks-avancados'),
  'semana-3-hooks-avancados-qual-hook-memoiza-um-valor-calculado-recalculando-',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual hook memoiza um VALOR calculado, recalculando só quando as dependências mudam?',
  '[{"id": "a", "text": "useCallback"}, {"id": "b", "text": "useMemo"}, {"id": "c", "text": "useEffect"}, {"id": "d", "text": "useState"}]'::jsonb,
  'b',
  'useMemo',
  '`useMemo` guarda em cache o resultado de um cálculo, evitando recalculá-lo em toda renderização se as dependências não mudarem.',
  false,
  109
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-hooks-avancados'),
  'semana-3-hooks-avancados-por-que-importante-fazer-cleanup-em-um-useeffect-q',
  'lesson',
  'open',
  'medium',
  'Por que é importante fazer ''cleanup'' em um `useEffect` que cria um `setInterval`?',
  null,
  null,
  'Para evitar que o timer continue rodando depois que o componente saiu de tela (ou antes do efeito rodar de novo), causando vazamento de memória ou comportamento inesperado.',
  'A função retornada pelo `useEffect` é chamada antes do efeito rodar novamente e quando o componente desmonta — é o lugar certo para `clearInterval`.',
  false,
  110
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-hooks-avancados'),
  'semana-3-hooks-avancados-qual-o-prop-sito-do-array-userid-neste-useeffect-j',
  'lesson',
  'code',
  'medium',
  'Qual o propósito do array `[userId]` neste `useEffect`?
```jsx
useEffect(() => {
  fetchReviews(userId).then(setReviews);
}, [userId]);
```',
  null,
  null,
  'Faz o efeito rodar novamente sempre (e somente) que `userId` mudar de valor entre renderizações.',
  'O array de dependências informa ao React quando reexecutar o efeito; omitir `userId` faria buscar dados desatualizados se o usuário mudasse.',
  false,
  111
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-hooks-avancados'),
  'semana-3-hooks-avancados-quando-usecallback-mais-til',
  'lesson',
  'multiple_choice',
  'medium',
  'Quando `useCallback` é mais útil?',
  '[{"id": "a", "text": "Em todo componente, sempre"}, {"id": "b", "text": "Ao passar uma função como prop para um componente filho memoizado (`React.memo`), evitando recriá-la a cada render"}, {"id": "c", "text": "Apenas em componentes de classe"}, {"id": "d", "text": "Nunca, está obsoleto"}]'::jsonb,
  'b',
  'Ao passar uma função como prop para um componente filho memoizado (`React.memo`), evitando recriá-la a cada render',
  'Sem `useCallback`, uma nova função é criada a cada renderização, o que pode invalidar a memoização de um filho que depende de referência estável da função.',
  false,
  112
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-hooks-avancados'),
  'semana-3-hooks-avancados-o-que-pode-acontecer-se-as-depend-ncias-de-um-usee',
  'lesson',
  'open',
  'medium',
  'O que pode acontecer se as dependências de um `useEffect` estiverem incompletas (faltando alguma variável usada dentro dele)?',
  null,
  null,
  'O efeito pode usar valores desatualizados (stale) de variáveis que mudaram mas não dispararam a re-execução do efeito — um bug sutil e comum.',
  'O React (via lint de hooks) geralmente avisa sobre dependências faltando justamente para prevenir esse tipo de bug.',
  false,
  113
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-hooks-avancados'),
  'semana-3-hooks-avancados-esse-efeito-tem-um-problema-de-performance-qual-e-',
  'lesson',
  'code',
  'hard',
  'Esse efeito tem um problema de performance. Qual é, e como resolver com `useMemo`?
```jsx
function Dashboard({ reviews }) {
  const concluidas = reviews.filter(r => r.completed);
  return <p>{concluidas.length} concluídas</p>;
}
```',
  null,
  null,
  'O `filter` roda em TODA renderização do componente, mesmo que `reviews` não tenha mudado. `useMemo(() => reviews.filter(r => r.completed), [reviews])` evitaria recalcular sem necessidade.',
  'Para listas grandes ou cálculos custosos, recalcular a cada render é desperdício; `useMemo` memoiza o resultado até que `reviews` realmente mude.',
  false,
  114
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-hooks-avancados'),
  'semana-3-hooks-avancados-por-que-usar-usememo-usecallback-em-todo-component',
  'lesson',
  'open',
  'hard',
  'Por que usar `useMemo`/`useCallback` em TODO componente, mesmo sem necessidade real, pode ser contraproducente?',
  null,
  null,
  'Porque a própria memoização tem um custo (comparar dependências, manter cache), e usá-la sem necessidade adiciona complexidade e overhead sem ganho real de performance.',
  'Memoização deve ser aplicada onde há um cálculo genuinamente caro ou onde evita re-renderizações desnecessárias de filhos memoizados — não como prática padrão em tudo.',
  false,
  115
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-estado-global-nextjs'),
  'semana-3-estado-global-nextjs-o-que-a-context-api-resolve',
  'lesson',
  'multiple_choice',
  'easy',
  'O que a Context API resolve?',
  '[{"id": "a", "text": "Problemas de performance de rede"}, {"id": "b", "text": "O ''prop drilling'' — passar props manualmente por muitos níveis da árvore"}, {"id": "c", "text": "Erros de sintaxe"}, {"id": "d", "text": "Problemas de CSS"}]'::jsonb,
  'b',
  'O ''prop drilling'' — passar props manualmente por muitos níveis da árvore',
  'Context permite que um Provider disponibilize um valor que qualquer componente descendente pode ler diretamente, sem repassar prop por prop.',
  false,
  116
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-estado-global-nextjs'),
  'semana-3-estado-global-nextjs-no-app-router-do-next-js-componentes-s-o-client-co',
  'lesson',
  'true_false',
  'easy',
  'No App Router do Next.js, componentes são Client Components por padrão.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'No App Router, componentes são Server Components por padrão; é preciso declarar `''use client''` explicitamente para torná-los Client Components.',
  false,
  117
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-estado-global-nextjs'),
  'semana-3-estado-global-nextjs-rotas-din-micas-no-app-router-s-o-criadas-usando',
  'lesson',
  'multiple_choice',
  'easy',
  'Rotas dinâmicas no App Router são criadas usando:',
  '[{"id": "a", "text": "Arquivo routes.json"}, {"id": "b", "text": "Nome de pasta entre colchetes, como [slug]"}, {"id": "c", "text": "Decoradores Python"}, {"id": "d", "text": "Um arquivo XML"}]'::jsonb,
  'b',
  'Nome de pasta entre colchetes, como [slug]',
  '`app/contents/[slug]/page.tsx` captura qualquer valor de `slug` presente na URL.',
  false,
  118
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-estado-global-nextjs'),
  'semana-3-estado-global-nextjs-quando-um-componente-precisa-ser-um-client-compone',
  'lesson',
  'open',
  'medium',
  'Quando um componente PRECISA ser um Client Component no App Router?',
  null,
  null,
  'Quando usa hooks como `useState`/`useEffect`, ou precisa de interatividade no navegador (eventos de clique, etc).',
  'Server Components não têm acesso a essas APIs do navegador nem a hooks de estado — por isso a diretiva `''use client''` é necessária nesses casos.',
  false,
  119
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-estado-global-nextjs'),
  'semana-3-estado-global-nextjs-qual-a-vantagem-de-um-layout-tsx-compartilhado-ent',
  'lesson',
  'multiple_choice',
  'medium',
  'Qual a vantagem de um `layout.tsx` compartilhado entre páginas no App Router?',
  '[{"id": "a", "text": "Duplicar a sidebar em cada página"}, {"id": "b", "text": "Manter uma UI compartilhada (ex: sidebar) sem perder estado ao navegar entre páginas"}, {"id": "c", "text": "Deixar o build mais lento"}, {"id": "d", "text": "É obrigatório mesmo sem uso real"}]'::jsonb,
  'b',
  'Manter uma UI compartilhada (ex: sidebar) sem perder estado ao navegar entre páginas',
  'O layout envolve várias páginas, evitando remontar elementos comuns (como a sidebar) a cada navegação.',
  false,
  120
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-estado-global-nextjs'),
  'semana-3-estado-global-nextjs-o-que-este-context-faz-na-pr-tica-jsx-const-authco',
  'lesson',
  'code',
  'medium',
  'O que este Context faz, na prática?
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
```',
  null,
  null,
  'Cria um contexto de autenticação que disponibiliza o usuário atual (e uma forma de alterá-lo) para qualquer componente descendente, sem precisar passar via props.',
  'Qualquer componente dentro de `AuthProvider` pode usar `useContext(AuthContext)` para ler `user`/`setUser` diretamente.',
  false,
  121
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-estado-global-nextjs'),
  'semana-3-estado-global-nextjs-por-que-context-n-o-recomendado-para-estado-que-mu',
  'lesson',
  'open',
  'hard',
  'Por que Context não é recomendado para estado que muda com muita frequência (ex: a cada tecla digitada)?',
  null,
  null,
  'Porque toda mudança no valor do Context re-renderiza TODOS os componentes que o consomem, o que pode ser custoso se isso acontecer com muita frequência.',
  'Para estado de alta frequência de mudança, soluções mais granulares (estado local, ou bibliotecas de state management otimizadas) costumam performar melhor.',
  false,
  122
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-typescript'),
  'semana-3-typescript-o-que-partial-review-representa',
  'lesson',
  'multiple_choice',
  'easy',
  'O que `Partial<Review>` representa?',
  '[{"id": "a", "text": "Um tipo com metade das propriedades de Review"}, {"id": "b", "text": "Um tipo igual a Review mas com todas as propriedades opcionais"}, {"id": "c", "text": "Um erro de sintaxe"}, {"id": "d", "text": "Uma classe abstrata"}]'::jsonb,
  'b',
  'Um tipo igual a Review mas com todas as propriedades opcionais',
  '`Partial<T>` é um utility type que torna todas as propriedades de T opcionais — muito usado para representar atualizações parciais (PATCH).',
  false,
  123
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-typescript'),
  'semana-3-typescript-interface-e-type-em-typescript-s-o-id-nticos-em-to',
  'lesson',
  'true_false',
  'easy',
  '`interface` e `type` em TypeScript são idênticos em todos os aspectos, sem nenhuma diferença.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'Ambos descrevem formatos de objeto, mas `interface` pode ser reaberta/estendida, enquanto `type` é mais flexível para uniões e tipos compostos.',
  false,
  124
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-typescript'),
  'semana-3-typescript-o-que-pick-review-id-title-produz',
  'lesson',
  'multiple_choice',
  'easy',
  'O que `Pick<Review, "id" | "title">` produz?',
  '[{"id": "a", "text": "Um tipo com todas as propriedades de Review, exceto id e title"}, {"id": "b", "text": "Um novo tipo contendo apenas id e title de Review"}, {"id": "c", "text": "Um erro, pois Pick não existe"}, {"id": "d", "text": "O mesmo que Review"}]'::jsonb,
  'b',
  'Um novo tipo contendo apenas id e title de Review',
  '`Pick<T, K>` cria um novo tipo apenas com as propriedades escolhidas de T, útil para criar ''resumos'' de uma interface maior.',
  false,
  125
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-typescript'),
  'semana-3-typescript-qual-o-tipo-de-valor-dentro-do-bloco-if-typescript',
  'lesson',
  'code',
  'medium',
  'Qual é o tipo de `valor` dentro do bloco `if`?
```typescript
function formatar(valor: string | number) {
  if (typeof valor === "string") {
    return valor.toUpperCase();
  }
  return valor.toFixed(2);
}
```',
  null,
  null,
  'Dentro do `if`, TypeScript ''estreita'' (narrowing) o tipo de `valor` para `string`; fora dele, para `number`.',
  'Esse processo de type narrowing usa a checagem `typeof` para permitir acessar métodos específicos de cada tipo com segurança.',
  false,
  126
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-typescript'),
  'semana-3-typescript-qual-a-diferen-a-entre-omit-review-id-e-pick-revie',
  'lesson',
  'open',
  'medium',
  'Qual a diferença entre `Omit<Review, "id">` e `Pick<Review, "id">`?',
  null,
  null,
  '`Omit` retorna todas as propriedades de Review EXCETO `id`; `Pick` retorna SOMENTE a propriedade `id`.',
  'São opostos complementares: um remove propriedades específicas, o outro seleciona apenas as especificadas.',
  false,
  127
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-typescript'),
  'semana-3-typescript-o-que-caracteriza-um-union-type-como-easy-medium-h',
  'lesson',
  'multiple_choice',
  'medium',
  'O que caracteriza um ''union type'' como `"easy" | "medium" | "hard"`?',
  '[{"id": "a", "text": "O valor deve ser exatamente um desses três, nada mais"}, {"id": "b", "text": "O valor deve conter os três ao mesmo tempo"}, {"id": "c", "text": "É equivalente a `any`"}, {"id": "d", "text": "Só funciona com números"}]'::jsonb,
  'a',
  'O valor deve ser exatamente um desses três, nada mais',
  'Union types restringem um valor a um conjunto específico de opções válidas, dando segurança de tipo em vez de aceitar qualquer string.',
  false,
  128
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-typescript'),
  'semana-3-typescript-por-que-este-generic-garante-mais-seguran-a-de-tip',
  'lesson',
  'code',
  'hard',
  'Por que este generic garante mais segurança de tipo do que usar `any`?
```typescript
function primeiro<T>(lista: T[]): T | undefined {
  return lista[0];
}
```',
  null,
  null,
  'Porque o tipo de retorno é vinculado ao tipo de entrada — chamar `primeiro<string>(["a"])` garante que o retorno seja tratado como `string | undefined`, preservando a informação de tipo através da função.',
  'Com `any`, essa informação se perderia e erros de uso incorreto do valor retornado só apareceriam em tempo de execução, não de compilação.',
  false,
  129
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-typescript'),
  'semana-3-typescript-por-que-derivar-tipos-com-partial-pick-omit-a-part',
  'lesson',
  'open',
  'hard',
  'Por que derivar tipos com `Partial`/`Pick`/`Omit` a partir de uma interface principal é preferível a criar interfaces parecidas manualmente?',
  null,
  null,
  'Porque evita duplicação e desalinhamento: se a interface principal mudar, os tipos derivados acompanham automaticamente, sem precisar atualizar cada cópia manual.',
  'Manter várias interfaces quase idênticas manualmente é uma fonte comum de bugs quando uma é atualizada e as outras são esquecidas.',
  false,
  130
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-integracao-full-stack'),
  'semana-3-integracao-full-stack-quais-s-o-os-tr-s-estados-b-sicos-que-uma-tela-que',
  'lesson',
  'multiple_choice',
  'easy',
  'Quais são os três estados básicos que uma tela que busca dados assíncronos deve tratar, além do sucesso?',
  '[{"id": "a", "text": "Loading, Empty e Error"}, {"id": "b", "text": "Fast, Medium e Slow"}, {"id": "c", "text": "Red, Green e Blue"}, {"id": "d", "text": "Start, Middle e End"}]'::jsonb,
  'a',
  'Loading, Empty e Error',
  'Ignorar qualquer um desses estados é uma causa comum de UI confusa: usuário sem feedback durante carregamento, tela em branco sem dados, ou sem explicação em caso de falha.',
  false,
  131
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-integracao-full-stack'),
  'semana-3-integracao-full-stack-ao-usar-supabase-o-token-de-autentica-o-da-sess-o-',
  'lesson',
  'true_false',
  'easy',
  'Ao usar Supabase, o token de autenticação da sessão precisa ser anexado manualmente em cada chamada pelo desenvolvedor.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'O client do Supabase já injeta automaticamente o token da sessão ativa nas chamadas, sem o desenvolvedor precisar fazer isso manualmente.',
  false,
  132
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-integracao-full-stack'),
  'semana-3-integracao-full-stack-por-que-centralizar-a-l-gica-de-chamada-de-api-em-',
  'lesson',
  'open',
  'medium',
  'Por que centralizar a lógica de chamada de API em hooks/services é melhor do que duplicar `fetch` em cada componente?',
  null,
  null,
  'Evita duplicação de tratamento de erro/loading, facilita manutenção (um único lugar para ajustar a chamada) e mantém os componentes focados em apresentação.',
  'Isso segue o princípio de separação de responsabilidades: componentes cuidam da UI, services/hooks cuidam de buscar e formatar os dados.',
  false,
  133
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-integracao-full-stack'),
  'semana-3-integracao-full-stack-o-que-est-faltando-neste-hook-para-ser-considerado',
  'lesson',
  'code',
  'medium',
  'O que está faltando neste hook para ser considerado completo, segundo as boas práticas de integração?
```jsx
function useReviews(userId) {
  const [reviews, setReviews] = useState([]);
  useEffect(() => {
    fetch(`/api/reviews?user_id=${userId}`).then(r => r.json()).then(setReviews);
  }, [userId]);
  return reviews;
}
```',
  null,
  null,
  'Faltam os estados de loading e error — o hook não informa se a busca está em andamento nem se falhou, e não trata `response.ok`.',
  'Sem esses estados, a tela consumidora não consegue mostrar um spinner enquanto carrega nem uma mensagem de erro se a requisição falhar.',
  false,
  134
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-integracao-full-stack'),
  'semana-3-integracao-full-stack-empty-state-estado-vazio-deve-ser-mostrado-quando',
  'lesson',
  'multiple_choice',
  'medium',
  'Empty state (estado vazio) deve ser mostrado quando:',
  '[{"id": "a", "text": "A requisição ainda está carregando"}, {"id": "b", "text": "A requisição teve sucesso mas não retornou dados"}, {"id": "c", "text": "A requisição falhou"}, {"id": "d", "text": "Sempre, independente do resultado"}]'::jsonb,
  'b',
  'A requisição teve sucesso mas não retornou dados',
  'Um empty state bem feito (com mensagem amigável e call-to-action) evita que o usuário pense que algo quebrou quando simplesmente não há dados ainda.',
  false,
  135
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-integracao-full-stack'),
  'semana-3-integracao-full-stack-um-app-mostra-uma-tela-em-branco-quando-a-api-de-r',
  'lesson',
  'open',
  'hard',
  'Um app mostra uma tela em branco quando a API de revisões demora a responder. Que problema de integração isso evidencia, e como corrigir?',
  null,
  null,
  'Falta o tratamento do estado de ''loading'' — a tela deveria mostrar um indicador de carregamento (skeleton/spinner) enquanto espera a resposta, em vez de ficar em branco.',
  'Uma tela em branco durante o carregamento é um dos erros mais comuns e mais fáceis de evitar: sempre iniciar o estado como ''loading: true'' até a requisição terminar.',
  false,
  136
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-docker'),
  'semana-4-docker-qual-instru-o-do-dockerfile-define-a-imagem-base-d',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual instrução do Dockerfile define a imagem base de onde partir?',
  '[{"id": "a", "text": "WORKDIR"}, {"id": "b", "text": "FROM"}, {"id": "c", "text": "COPY"}, {"id": "d", "text": "RUN"}]'::jsonb,
  'b',
  'FROM',
  '`FROM` é sempre a primeira instrução relevante de um Dockerfile, definindo a imagem base sobre a qual a nova imagem será construída.',
  false,
  137
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-docker'),
  'semana-4-docker-a-instru-o-expose-abre-automaticamente-a-porta-no-',
  'lesson',
  'true_false',
  'easy',
  'A instrução `EXPOSE` abre automaticamente a porta no host.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  '`EXPOSE` apenas documenta qual porta a aplicação usa dentro do container; a publicação real da porta é feita ao rodar o container (`-p`) ou via Compose.',
  false,
  138
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-docker'),
  'semana-4-docker-o-que-um-volume-docker-usado-para-fazer',
  'lesson',
  'multiple_choice',
  'easy',
  'O que um Volume Docker é usado para fazer?',
  '[{"id": "a", "text": "Aumentar a velocidade da CPU"}, {"id": "b", "text": "Persistir dados fora do ciclo de vida do container"}, {"id": "c", "text": "Compactar a imagem"}, {"id": "d", "text": "Rodar múltiplos containers ao mesmo tempo"}]'::jsonb,
  'b',
  'Persistir dados fora do ciclo de vida do container',
  'Sem volume, dados dentro de um container somem quando ele é recriado; volumes garantem que dados como os de um banco sobrevivam a esse ciclo.',
  false,
  139
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-docker'),
  'semana-4-docker-qual-o-principal-benef-cio-de-um-multi-stage-build',
  'lesson',
  'open',
  'medium',
  'Qual o principal benefício de um multi-stage build?',
  null,
  null,
  'Permite usar uma imagem maior (com ferramentas de build) para compilar a aplicação e copiar só o resultado final para uma imagem menor, reduzindo o tamanho da imagem de produção.',
  'Isso evita que ferramentas de build (compiladores, dependências de desenvolvimento) fiquem na imagem final publicada, tornando-a mais enxuta e segura.',
  false,
  140
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-docker'),
  'semana-4-docker-o-que-este-dockerfile-faz-resumidamente-dockerfile',
  'lesson',
  'code',
  'medium',
  'O que este Dockerfile faz, resumidamente?
```dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0"]
```',
  null,
  null,
  'Constrói uma imagem Python, instala as dependências do projeto, copia o código, documenta a porta 8000 e define o comando padrão para iniciar a API com Uvicorn.',
  'A ordem (copiar requirements.txt e instalar antes de copiar o resto do código) é proposital: aproveita o cache de camadas do Docker quando só o código muda, sem reinstalar dependências.',
  false,
  141
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-docker'),
  'semana-4-docker-para-que-serve-o-docker-compose',
  'lesson',
  'multiple_choice',
  'medium',
  'Para que serve o Docker Compose?',
  '[{"id": "a", "text": "Substituir o Dockerfile"}, {"id": "b", "text": "Orquestrar e definir múltiplos containers (ex: API + banco + Redis) em um único arquivo"}, {"id": "c", "text": "Compactar imagens Docker"}, {"id": "d", "text": "Gerar testes automaticamente"}]'::jsonb,
  'b',
  'Orquestrar e definir múltiplos containers (ex: API + banco + Redis) em um único arquivo',
  'Compose usa um arquivo YAML para descrever os serviços que compõem a aplicação e como eles se conectam entre si.',
  false,
  142
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-docker'),
  'semana-4-docker-por-que-copiar-requirements-txt-e-rodar-pip-instal',
  'lesson',
  'open',
  'medium',
  'Por que copiar `requirements.txt` e rodar `pip install` ANTES de copiar o resto do código, em vez de copiar tudo de uma vez?',
  null,
  null,
  'Para aproveitar o cache de camadas do Docker: se só o código da aplicação mudar (não as dependências), o Docker reaproveita a camada já construída do `pip install`, tornando o build mais rápido.',
  'Se as dependências fossem copiadas junto com o resto do código em uma única camada, qualquer mudança no código forçaria reinstalar todas as dependências do zero.',
  false,
  143
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-docker'),
  'semana-4-docker-uma-imagem-docker-de-produ-o-ficou-com-1-2gb-porqu',
  'lesson',
  'open',
  'hard',
  'Uma imagem Docker de produção ficou com 1.2GB porque inclui compiladores e dependências de desenvolvimento usados só para o build. Como reduzir isso?',
  null,
  null,
  'Usar um multi-stage build: uma stage com as ferramentas de build compila a aplicação, e uma segunda stage, baseada em uma imagem mínima, copia apenas os artefatos finais necessários para rodar.',
  'Isso separa claramente ''o que é preciso para construir'' de ''o que é preciso para rodar'', resultando em uma imagem final bem menor e com menos superfície de ataque.',
  false,
  144
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-docker'),
  'semana-4-docker-qual-servi-o-nesse-docker-compose-yml-perderia-os-',
  'lesson',
  'code',
  'hard',
  'Qual serviço nesse `docker-compose.yml` perderia os dados ao ser recriado, e por quê?
```yaml
services:
  api:
    build: .
    ports: ["8000:8000"]
  db:
    image: postgres:16
```',
  null,
  null,
  'O serviço `db` perderia os dados, pois não tem um volume configurado para persistir os arquivos do PostgreSQL fora do container.',
  'Sem um `volumes: ["pgdata:/var/lib/postgresql/data"]` (e a declaração do volume `pgdata`), os dados do banco existem só dentro do container, sendo perdidos quando ele é removido/recriado.',
  false,
  145
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-kubernetes-observabilidade'),
  'semana-4-kubernetes-observabilidade-qual-a-menor-unidade-gerenci-vel-no-kubernetes',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual é a menor unidade gerenciável no Kubernetes?',
  '[{"id": "a", "text": "Node"}, {"id": "b", "text": "Pod"}, {"id": "c", "text": "Cluster"}, {"id": "d", "text": "Namespace"}]'::jsonb,
  'b',
  'Pod',
  'Um Pod geralmente contém um container (ou um pequeno grupo intimamente relacionado) e é a menor unidade que o Kubernetes agenda e gerencia.',
  false,
  146
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-kubernetes-observabilidade'),
  'semana-4-kubernetes-observabilidade-um-deployment-garante-que-o-n-mero-de-r-plicas-de-',
  'lesson',
  'true_false',
  'easy',
  'Um Deployment garante que o número de réplicas de Pods desejado se mantenha, recriando Pods que falham.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'a',
  'Verdadeiro',
  'Se um Pod gerenciado por um Deployment cai, o Deployment sobe outro automaticamente para manter o estado desejado.',
  false,
  147
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-kubernetes-observabilidade'),
  'semana-4-kubernetes-observabilidade-o-que-exp-e-um-conjunto-de-pods-sob-um-endere-o-es',
  'lesson',
  'multiple_choice',
  'easy',
  'O que expõe um conjunto de Pods sob um endereço estável no Kubernetes?',
  '[{"id": "a", "text": "Ingress"}, {"id": "b", "text": "Service"}, {"id": "c", "text": "ConfigMap"}, {"id": "d", "text": "Secret"}]'::jsonb,
  'b',
  'Service',
  'Como Pods são efêmeros e mudam de IP, o Service oferece um ponto de acesso estável para alcançá-los.',
  false,
  148
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-kubernetes-observabilidade'),
  'semana-4-kubernetes-observabilidade-qual-a-fun-o-do-ingress-em-um-cluster-kubernetes',
  'lesson',
  'open',
  'medium',
  'Qual a função do Ingress em um cluster Kubernetes?',
  null,
  null,
  'Gerenciar o acesso externo (HTTP/HTTPS) aos Services do cluster, geralmente roteando por domínio ou path para diferentes serviços internos.',
  'Sem Ingress, seria mais difícil expor múltiplos serviços internos de forma organizada sob domínios/URLs diferentes através de um único ponto de entrada.',
  false,
  149
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-kubernetes-observabilidade'),
  'semana-4-kubernetes-observabilidade-por-que-uma-stack-como-elk-elasticsearch-logstash-',
  'lesson',
  'multiple_choice',
  'medium',
  'Por que uma stack como ELK (Elasticsearch, Logstash, Kibana) é importante em um ambiente com múltiplos Pods?',
  '[{"id": "a", "text": "Para aumentar a velocidade dos Pods"}, {"id": "b", "text": "Para centralizar e indexar logs de vários serviços, facilitando encontrar e analisar problemas"}, {"id": "c", "text": "Para substituir o Kubernetes"}, {"id": "d", "text": "Para fazer backup automático do banco"}]'::jsonb,
  'b',
  'Para centralizar e indexar logs de vários serviços, facilitando encontrar e analisar problemas',
  'Sem centralização, depurar um problema exigiria acessar logs de cada Pod individualmente, o que é inviável em escala.',
  false,
  150
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-kubernetes-observabilidade'),
  'semana-4-kubernetes-observabilidade-o-que-significa-escalar-horizontalmente-uma-aplica',
  'lesson',
  'open',
  'medium',
  'O que significa escalar horizontalmente uma aplicação no Kubernetes?',
  null,
  null,
  'Aumentar o número de réplicas (Pods) rodando a aplicação, distribuindo a carga entre elas, em vez de aumentar os recursos de uma única instância.',
  'Isso pode ser feito manualmente ou automaticamente (Horizontal Pod Autoscaler), conforme métricas como uso de CPU.',
  false,
  151
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-kubernetes-observabilidade'),
  'semana-4-kubernetes-observabilidade-um-servi-o-no-kubernetes-est-apresentando-lentid-o',
  'lesson',
  'open',
  'hard',
  'Um serviço no Kubernetes está apresentando lentidão sob carga alta. Cite duas abordagens de observabilidade que ajudariam a diagnosticar a causa.',
  null,
  null,
  'Analisar logs centralizados (ex: via ELK) buscando erros/latência anormal, e observar métricas de uso de CPU/memória dos Pods para identificar se há recursos insuficientes ou gargalo em uma dependência específica.',
  'Observabilidade combina logs, métricas e (idealmente) traces para formar um quadro completo do que está acontecendo dentro do sistema sob carga.',
  false,
  152
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-ci-cd'),
  'semana-4-ci-cd-o-que-ci-integra-o-cont-nua-verifica-automaticamen',
  'lesson',
  'multiple_choice',
  'easy',
  'O que CI (Integração Contínua) verifica automaticamente a cada push/PR?',
  '[{"id": "a", "text": "Apenas a formatação do código"}, {"id": "b", "text": "Lint, testes e build, antes de permitir o merge"}, {"id": "c", "text": "Apenas se o código compila"}, {"id": "d", "text": "Nada, é só um nome"}]'::jsonb,
  'b',
  'Lint, testes e build, antes de permitir o merge',
  'CI detecta problemas cedo, antes que cheguem à branch principal ou à produção.',
  false,
  153
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-ci-cd'),
  'semana-4-ci-cd-a-vercel-focada-principalmente-em-hospedar-bancos-',
  'lesson',
  'true_false',
  'easy',
  'A Vercel é focada principalmente em hospedar bancos de dados.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'A Vercel é focada em hospedar frontend (Next.js, Vite, etc), com deploy automático a cada push; bancos de dados normalmente ficam em outros serviços.',
  false,
  154
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-ci-cd'),
  'semana-4-ci-cd-em-qual-pasta-ficam-os-workflows-do-github-actions',
  'lesson',
  'multiple_choice',
  'easy',
  'Em qual pasta ficam os workflows do GitHub Actions?',
  '[{"id": "a", "text": ".github/workflows/"}, {"id": "b", "text": "src/ci/"}, {"id": "c", "text": "workflows/"}, {"id": "d", "text": ".ci/actions/"}]'::jsonb,
  'a',
  '.github/workflows/',
  'Arquivos YAML dentro dessa pasta definem os pipelines de CI/CD executados pelo GitHub Actions.',
  false,
  155
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-ci-cd'),
  'semana-4-ci-cd-qual-a-diferen-a-entre-ci-e-cd',
  'lesson',
  'open',
  'medium',
  'Qual a diferença entre CI e CD?',
  null,
  null,
  'CI (Integração Contínua) verifica automaticamente cada mudança de código (lint, testes, build); CD (Entrega/Deploy Contínuo) automatiza colocar essa mudança em produção/staging.',
  'CI foca em garantir qualidade a cada mudança; CD foca em levar essa mudança validada até o ambiente de destino sem intervenção manual repetitiva.',
  false,
  156
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-ci-cd'),
  'semana-4-ci-cd-o-que-este-workflow-do-github-actions-faz-yaml-on-',
  'lesson',
  'code',
  'medium',
  'O que este workflow do GitHub Actions faz?
```yaml
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm install
      - run: npm run lint
      - run: npm run build
```',
  null,
  null,
  'A cada push ou pull request, faz checkout do código, instala dependências, roda o lint e o build — falhando o pipeline se algum desses passos falhar.',
  'Isso funciona como uma rede de segurança automática: mudanças que quebram o lint ou o build são sinalizadas antes de chegarem à branch principal.',
  false,
  157
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-ci-cd'),
  'semana-4-ci-cd-por-que-ter-deploy-autom-tico-a-cada-push-exige-um',
  'lesson',
  'multiple_choice',
  'medium',
  'Por que ter deploy automático a cada push exige uma suíte de testes confiável?',
  '[{"id": "a", "text": "Não exige, deploy automático é sempre seguro"}, {"id": "b", "text": "Porque, sem testes confiáveis, bugs podem ir parar em produção automaticamente e rapidamente"}, {"id": "c", "text": "Porque testes tornam o deploy mais lento e por isso são dispensáveis"}, {"id": "d", "text": "Porque só empresas grandes precisam de testes"}]'::jsonb,
  'b',
  'Porque, sem testes confiáveis, bugs podem ir parar em produção automaticamente e rapidamente',
  'A automação do deploy amplia tanto a velocidade de entrega quanto a velocidade com que um bug não detectado chega ao usuário final.',
  false,
  158
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-ci-cd'),
  'semana-4-ci-cd-uma-equipe-tem-ci-configurado-mas-os-testes-muitas',
  'lesson',
  'open',
  'hard',
  'Uma equipe tem CI configurado, mas os testes muitas vezes falham de forma aleatória e não relacionada ao código (flaky tests). Por que isso é um problema para a confiança no pipeline?',
  null,
  null,
  'Porque a equipe começa a ignorar falhas do CI (''deve ser flaky de novo''), perdendo a função do pipeline como rede de segurança — bugs reais podem passar despercebidos entre os falsos alarmes.',
  'Testes instáveis corroem a confiança no processo de CI/CD; vale mais investir em corrigir a causa da instabilidade do que conviver com ela.',
  false,
  159
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-arquitetura-apis'),
  'semana-4-arquitetura-apis-qual-verbo-http-apropriado-para-criar-um-novo-recu',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual verbo HTTP é apropriado para CRIAR um novo recurso?',
  '[{"id": "a", "text": "GET"}, {"id": "b", "text": "POST"}, {"id": "c", "text": "DELETE"}, {"id": "d", "text": "OPTIONS"}]'::jsonb,
  'b',
  'POST',
  'POST é o verbo convencional para criação de recursos em uma API REST.',
  false,
  160
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-arquitetura-apis'),
  'semana-4-arquitetura-apis-get-deve-ser-usado-para-opera-es-que-alteram-dados',
  'lesson',
  'true_false',
  'easy',
  'GET deve ser usado para operações que alteram dados no servidor.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'GET deve ser usado apenas para leitura, sem efeitos colaterais; alterações de dados devem usar POST, PUT, PATCH ou DELETE.',
  false,
  161
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-arquitetura-apis'),
  'semana-4-arquitetura-apis-qual-status-http-indica-que-o-recurso-solicitado-n',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual status HTTP indica que o recurso solicitado não existe?',
  '[{"id": "a", "text": "200"}, {"id": "b", "text": "401"}, {"id": "c", "text": "404"}, {"id": "d", "text": "500"}]'::jsonb,
  'c',
  '404',
  '404 Not Found indica que o servidor não encontrou o recurso correspondente à URL solicitada.',
  false,
  162
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-arquitetura-apis'),
  'semana-4-arquitetura-apis-qual-a-diferen-a-pr-tica-entre-put-e-patch',
  'lesson',
  'open',
  'medium',
  'Qual a diferença prática entre PUT e PATCH?',
  null,
  null,
  'PUT substitui o recurso inteiro; PATCH atualiza apenas parte dele.',
  'Usar PATCH para atualizações parciais evita ter que reenviar todos os campos de um recurso quando só um precisa mudar.',
  false,
  163
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-arquitetura-apis'),
  'semana-4-arquitetura-apis-o-que-o-cors-controla',
  'lesson',
  'multiple_choice',
  'medium',
  'O que o CORS controla?',
  '[{"id": "a", "text": "A velocidade da API"}, {"id": "b", "text": "Se um site em um domínio pode fazer requisições a uma API em outro domínio"}, {"id": "c", "text": "A criptografia dos dados"}, {"id": "d", "text": "O tamanho máximo de upload"}]'::jsonb,
  'b',
  'Se um site em um domínio pode fazer requisições a uma API em outro domínio',
  'CORS é um mecanismo do navegador; o servidor precisa declarar explicitamente quais origens são permitidas via headers como `Access-Control-Allow-Origin`.',
  false,
  164
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-arquitetura-apis'),
  'semana-4-arquitetura-apis-por-que-pagina-o-importante-ao-listar-muitos-regis',
  'lesson',
  'open',
  'medium',
  'Por que paginação é importante ao listar muitos registros em uma API?',
  null,
  null,
  'Porque retornar todos os registros de uma vez é caro (memória, tempo de resposta, tráfego) e desnecessário — o cliente geralmente só precisa de uma parte por vez.',
  'Estratégias comuns incluem offset-based (`page`/`limit`) e cursor-based (mais estável quando dados mudam entre as páginas).',
  false,
  165
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-arquitetura-apis'),
  'semana-4-arquitetura-apis-qual-o-problema-de-design-nesta-rota-get-getuserre',
  'lesson',
  'code',
  'medium',
  'Qual é o problema de design nesta rota?
```
GET /getUserReviews?userId=123
```',
  null,
  null,
  'Não segue as convenções REST: usa um verbo no path (`getUserReviews`) em vez de expressar o recurso via URL e usar o verbo HTTP para a ação, como `GET /users/123/reviews`.',
  'Em REST, a ação é comunicada pelo verbo HTTP (GET, POST...), não por palavras no nome do endpoint.',
  false,
  166
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-arquitetura-apis'),
  'semana-4-arquitetura-apis-uma-api-est-autenticada-via-authorization-bearer-t',
  'lesson',
  'open',
  'hard',
  'Uma API está autenticada via `Authorization: Bearer <token>`, mas o frontend em outro domínio não consegue chamá-la mesmo com o token correto. Qual configuração provavelmente está faltando?',
  null,
  null,
  'A configuração de CORS no servidor, permitindo explicitamente a origem do frontend (`Access-Control-Allow-Origin`) — sem isso, o navegador bloqueia a resposta mesmo que a requisição tenha sido processada.',
  'CORS é aplicado pelo navegador do lado do cliente; mesmo que o servidor processe a requisição corretamente, sem os headers certos o navegador impede o JavaScript de acessar a resposta.',
  false,
  167
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-git-metodologias-ageis'),
  'semana-4-git-metodologias-ageis-o-que-git-stash-faz',
  'lesson',
  'multiple_choice',
  'easy',
  'O que `git stash` faz?',
  '[{"id": "a", "text": "Apaga o histórico de commits"}, {"id": "b", "text": "Guarda temporariamente mudanças não commitadas"}, {"id": "c", "text": "Cria uma nova branch"}, {"id": "d", "text": "Faz o merge automático"}]'::jsonb,
  'b',
  'Guarda temporariamente mudanças não commitadas',
  'Isso permite trocar de branch com a área de trabalho ''limpa'' e recuperar as mudanças depois com `git stash pop`.',
  false,
  168
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-git-metodologias-ageis'),
  'semana-4-git-metodologias-ageis-no-scrum-o-trabalho-organizado-em-ciclos-fixos-cha',
  'lesson',
  'true_false',
  'easy',
  'No Scrum, o trabalho é organizado em ciclos fixos chamados Sprints.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'a',
  'Verdadeiro',
  'Sprints são ciclos fixos (geralmente 1-2 semanas) que estruturam o trabalho no Scrum, com rituais como Planning, Daily e Retrospectiva.',
  false,
  169
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-git-metodologias-ageis'),
  'semana-4-git-metodologias-ageis-o-que-git-cherry-pick-faz',
  'lesson',
  'multiple_choice',
  'easy',
  'O que `git cherry-pick` faz?',
  '[{"id": "a", "text": "Reverte todos os commits de uma branch"}, {"id": "b", "text": "Aplica um commit específico de uma branch em outra, sem trazer o restante do histórico"}, {"id": "c", "text": "Renomeia uma branch"}, {"id": "d", "text": "Apaga um arquivo do repositório"}]'::jsonb,
  'b',
  'Aplica um commit específico de uma branch em outra, sem trazer o restante do histórico',
  'Útil para levar uma correção pontual (ex: um hotfix) sem misturar outras mudanças daquela branch.',
  false,
  170
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-git-metodologias-ageis'),
  'semana-4-git-metodologias-ageis-por-que-rebase-deixa-o-hist-rico-mais-limpo-do-que',
  'lesson',
  'open',
  'medium',
  'Por que rebase deixa o histórico mais ''limpo'' do que merge, e por que ele deve ser evitado em branches já compartilhadas?',
  null,
  null,
  'Rebase reaplica commits sobre uma nova base, criando um histórico linear sem commit de merge — mas isso REESCREVE o histórico, o que causa problemas se outras pessoas já baixaram a branch original.',
  'Reescrever o histórico de uma branch compartilhada obriga quem já tem cópias locais a reconciliar divergências manualmente, gerando confusão e possíveis perdas de trabalho.',
  false,
  171
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-git-metodologias-ageis'),
  'semana-4-git-metodologias-ageis-qual-ritual-do-scrum-acontece-ao-final-de-cada-spr',
  'lesson',
  'multiple_choice',
  'medium',
  'Qual ritual do Scrum acontece ao final de cada Sprint para refletir sobre o que funcionou e o que não funcionou?',
  '[{"id": "a", "text": "Daily"}, {"id": "b", "text": "Planning"}, {"id": "c", "text": "Retrospectiva"}, {"id": "d", "text": "Backlog Grooming"}]'::jsonb,
  'c',
  'Retrospectiva',
  'A Retrospectiva é o momento dedicado a melhorar continuamente o processo da equipe, com base no que aconteceu na Sprint que terminou.',
  false,
  172
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-git-metodologias-ageis'),
  'semana-4-git-metodologias-ageis-quando-o-kanban-tende-a-ser-mais-adequado-do-que-o',
  'lesson',
  'open',
  'medium',
  'Quando o Kanban tende a ser mais adequado do que o Scrum?',
  null,
  null,
  'Quando o trabalho é um fluxo contínuo de demandas variáveis (como suporte), sem ciclos fixos previsíveis, ao contrário de entregas planejadas em Sprints.',
  'Kanban foca em limitar o trabalho em progresso e manter um fluxo constante, sem a estrutura de ciclos fixos do Scrum.',
  false,
  173
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-git-metodologias-ageis'),
  'semana-4-git-metodologias-ageis-duas-pessoas-alteram-a-mesma-linha-de-um-arquivo-e',
  'lesson',
  'open',
  'hard',
  'Duas pessoas alteram a mesma linha de um arquivo em branches diferentes e tentam mesclar. O Git não consegue decidir sozinho. O que fazer?',
  null,
  null,
  'Resolver o conflito manualmente: abrir o arquivo, examinar os marcadores de conflito do Git, decidir (ou combinar) qual versão manter, remover os marcadores e finalizar o merge com um novo commit.',
  'Conflitos acontecem quando o Git não tem como inferir automaticamente a intenção correta — cabe à pessoa desenvolvedora decidir com base no contexto do código.',
  false,
  174
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-projetos-portfolio'),
  'semana-5-projetos-portfolio-no-projeto-exemplo-pokefast-api-qual-linguagem-fra',
  'lesson',
  'multiple_choice',
  'easy',
  'No projeto-exemplo PokeFast API, qual linguagem/framework é usado no backend?',
  '[{"id": "a", "text": "Node.js com Express"}, {"id": "b", "text": "Python com FastAPI"}, {"id": "c", "text": "Java com Spring"}, {"id": "d", "text": "Ruby on Rails"}]'::jsonb,
  'b',
  'Python com FastAPI',
  'PokeFast API é apresentado como um case de estudo em Python/FastAPI, coerente com o eixo backend da trilha.',
  false,
  175
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-projetos-portfolio'),
  'semana-5-projetos-portfolio-no-projeto-exemplo-smartfinance-qual-o-foco-princi',
  'lesson',
  'multiple_choice',
  'easy',
  'No projeto-exemplo SmartFinance, qual é o foco principal do frontend?',
  '[{"id": "a", "text": "Um jogo em Canvas"}, {"id": "b", "text": "Um dashboard financeiro pessoal com gráficos"}, {"id": "c", "text": "Uma rede social"}, {"id": "d", "text": "Um editor de texto"}]'::jsonb,
  'b',
  'Um dashboard financeiro pessoal com gráficos',
  'SmartFinance é apresentado como um case de estudo em React/TypeScript focado em visualização de dados financeiros.',
  false,
  176
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-projetos-portfolio'),
  'semana-5-projetos-portfolio-um-bom-projeto-de-portf-lio-deve-necessariamente-u',
  'lesson',
  'true_false',
  'easy',
  'Um bom projeto de portfólio deve necessariamente usar todas as tecnologias possíveis do mercado.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'Um bom projeto de portfólio mostra decisões de arquitetura conscientes e código bem tratado — não é sobre acumular tecnologias.',
  false,
  177
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-projetos-portfolio'),
  'semana-5-projetos-portfolio-ao-estudar-o-pokefast-api-como-case-por-que-ele-co',
  'lesson',
  'open',
  'medium',
  'Ao estudar o PokeFast API como case, por que ele consome a PokéAPI de forma assíncrona?',
  null,
  null,
  'Porque consumir uma API externa envolve espera de rede (I/O), e o assincronismo evita bloquear a aplicação enquanto aguarda essa resposta.',
  'Isso conecta diretamente com o conceito de `async`/`await` estudado na Semana 1 — o case aplica a teoria em um cenário prático de integração externa.',
  false,
  178
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-projetos-portfolio'),
  'semana-5-projetos-portfolio-por-que-documentar-o-porqu-das-decis-es-t-cnicas-n',
  'lesson',
  'multiple_choice',
  'medium',
  'Por que documentar ''o porquê'' das decisões técnicas no README de um projeto ajuda em entrevistas?',
  '[{"id": "a", "text": "Não ajuda, entrevistadores não leem READMEs"}, {"id": "b", "text": "Porque força a pessoa a articular o raciocínio, o que facilita explicar o projeto verbalmente depois"}, {"id": "c", "text": "Porque aumenta o tamanho do repositório"}, {"id": "d", "text": "Porque é uma exigência do GitHub"}]'::jsonb,
  'b',
  'Porque força a pessoa a articular o raciocínio, o que facilita explicar o projeto verbalmente depois',
  'Documentar decisões técnicas é um ensaio para a própria entrevista: as perguntas que um recrutador faria já foram respondidas por escrito.',
  false,
  179
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-projetos-portfolio'),
  'semana-5-projetos-portfolio-no-case-smartfinance-por-que-tratar-loading-empty-',
  'lesson',
  'open',
  'medium',
  'No case SmartFinance, por que tratar loading/empty/error em cada card do dashboard separadamente (em vez de um loading global) é uma boa prática?',
  null,
  null,
  'Porque cada card busca e trata seus próprios dados de forma independente — um card lento ou com erro não trava a exibição dos demais.',
  'Isso é consistente com o padrão de integração estudado na Semana 3: cada seção de dados assíncronos deve gerenciar seu próprio ciclo de loading/empty/error.',
  false,
  180
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-projetos-portfolio'),
  'semana-5-projetos-portfolio-um-entrevistador-pergunta-como-voc-testaria-o-poke',
  'lesson',
  'open',
  'hard',
  'Um entrevistador pergunta ''como você testaria o PokeFast API?''. Com base no que foi estudado sobre testes (Semana 1), como estruturar essa resposta?',
  null,
  null,
  'Explicar a pirâmide de testes: testes unitários para lógica isolada, testes de integração para os endpoints (incluindo casos de erro, como Pokémon inexistente), e mocks para isolar a dependência da PokéAPI externa durante os testes.',
  'Conectar a resposta aos conceitos estudados (fixtures, mocking, status codes) demonstra que o conhecimento teórico foi realmente internalizado e aplicado.',
  false,
  181
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-projetos-portfolio'),
  'semana-5-projetos-portfolio-como-voc-responderia-por-que-escolheu-python-para-',
  'lesson',
  'open',
  'hard',
  'Como você responderia ''por que escolheu Python para o backend do PokeFast API'' sem inventar informações não definidas sobre o projeto?',
  null,
  null,
  'Falar de forma genérica e honesta sobre as razões que geralmente motivam essa escolha (ecossistema maduro para APIs com FastAPI, tipagem com Pydantic, produtividade), deixando claro quando algo é uma justificativa geral e não um fato específico não documentado do projeto.',
  'É importante nunca afirmar como certeza algo que não foi definido explicitamente sobre o projeto real — em entrevista, honestidade sobre o que foi ou não decidido vale mais do que inventar detalhes.',
  false,
  182
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-soft-skills-star'),
  'semana-5-soft-skills-star-o-que-a-letra-a-representa-no-m-todo-star',
  'lesson',
  'multiple_choice',
  'easy',
  'O que a letra ''A'' representa no método STAR?',
  '[{"id": "a", "text": "Ambiente"}, {"id": "b", "text": "Ação"}, {"id": "c", "text": "Avaliação"}, {"id": "d", "text": "Aprendizado"}]'::jsonb,
  'b',
  'Ação',
  'STAR = Situação, Tarefa, Ação, Resultado. A ''Ação'' é especificamente o que VOCÊ fez, não o que ''a equipe'' fez.',
  false,
  183
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-soft-skills-star'),
  'semana-5-soft-skills-star-no-m-todo-star-a-resposta-deve-focar-no-que-a-equi',
  'lesson',
  'true_false',
  'easy',
  'No método STAR, a resposta deve focar no que ''a equipe'' fez, evitando falar em primeira pessoa.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'O foco deve estar no que VOCÊ especificamente fez ("eu"), mesmo que o resultado tenha sido também fruto de trabalho em equipe.',
  false,
  184
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-soft-skills-star'),
  'semana-5-soft-skills-star-por-que-recomend-vel-preparar-de-4-a-6-hist-rias-r',
  'lesson',
  'open',
  'medium',
  'Por que é recomendável preparar de 4 a 6 histórias reais antes de uma entrevista comportamental?',
  null,
  null,
  'Porque a maioria das perguntas comportamentais se encaixa em temas recorrentes (conflito, prazo apertado, erro cometido, iniciativa) — poucas histórias bem preparadas cobrem várias perguntas diferentes.',
  'Preparar histórias com antecedência, estruturadas em STAR, evita respostas vagas ou inventadas na hora da pressão da entrevista.',
  false,
  185
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-soft-skills-star'),
  'semana-5-soft-skills-star-ao-responder-conte-sobre-um-conflito-com-um-colega',
  'lesson',
  'multiple_choice',
  'medium',
  'Ao responder ''conte sobre um conflito com um colega'', qual abordagem é mais profissional?',
  '[{"id": "a", "text": "Focar em culpar a outra pessoa"}, {"id": "b", "text": "Descrever a situação de forma neutra e focar em como você comunicou o desacordo e chegou a uma solução"}, {"id": "c", "text": "Dizer que nunca teve conflitos"}, {"id": "d", "text": "Evitar a pergunta"}]'::jsonb,
  'b',
  'Descrever a situação de forma neutra e focar em como você comunicou o desacordo e chegou a uma solução',
  'Entrevistadores avaliam maturidade e comunicação, não querem ouvir fofoca ou queixas — o foco deve estar na resolução construtiva.',
  false,
  186
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-soft-skills-star'),
  'semana-5-soft-skills-star-como-voc-estruturaria-em-star-uma-resposta-para-fa',
  'lesson',
  'open',
  'hard',
  'Como você estruturaria, em STAR, uma resposta para ''fale sobre uma situação em que precisou aprender uma tecnologia rapidamente''?',
  null,
  null,
  'Situação: contexto onde a tecnologia era necessária. Tarefa: o que precisava ser entregue com ela. Ação: como você estudou/praticou sob prazo. Resultado: o que foi entregue e o que você aprendeu com o processo.',
  'Essa pergunta é uma ótima oportunidade para mostrar autonomia de aprendizado — uma competência muito valorizada em desenvolvimento de software, onde tecnologias mudam constantemente.',
  false,
  187
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-system-design'),
  'semana-5-system-design-escalar-verticalmente-significa',
  'lesson',
  'multiple_choice',
  'easy',
  'Escalar verticalmente significa:',
  '[{"id": "a", "text": "Adicionar mais máquinas/instâncias"}, {"id": "b", "text": "Aumentar os recursos (CPU/memória) de uma única máquina"}, {"id": "c", "text": "Adicionar mais desenvolvedores"}, {"id": "d", "text": "Reduzir o número de usuários"}]'::jsonb,
  'b',
  'Aumentar os recursos (CPU/memória) de uma única máquina',
  'Escalar verticalmente é dar ''mais músculo'' a uma única instância; escalar horizontalmente é adicionar mais instâncias trabalhando em paralelo.',
  false,
  188
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-system-design'),
  'semana-5-system-design-um-ndice-de-banco-de-dados-acelera-buscas-sem-nenh',
  'lesson',
  'true_false',
  'easy',
  'Um índice de banco de dados acelera buscas sem nenhum custo adicional.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'Índices aceleram buscas, mas têm custo de espaço extra e tornam a escrita (insert/update) levemente mais lenta, já que o índice também precisa ser atualizado.',
  false,
  189
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-system-design'),
  'semana-5-system-design-o-que-uma-cdn-faz',
  'lesson',
  'multiple_choice',
  'easy',
  'O que uma CDN faz?',
  '[{"id": "a", "text": "Armazena senhas de forma criptografada"}, {"id": "b", "text": "Distribui arquivos estáticos em servidores próximos geograficamente ao usuário, reduzindo latência"}, {"id": "c", "text": "Substitui o banco de dados"}, {"id": "d", "text": "Gerencia autenticação"}]'::jsonb,
  'b',
  'Distribui arquivos estáticos em servidores próximos geograficamente ao usuário, reduzindo latência',
  'Uma CDN (Content Delivery Network) evita que todo usuário precise buscar arquivos estáticos de um único servidor central, muitas vezes distante.',
  false,
  190
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-system-design'),
  'semana-5-system-design-o-que-code-splitting-e-por-que-ele-melhora-a-perfo',
  'lesson',
  'open',
  'medium',
  'O que é code splitting e por que ele melhora a performance percebida pelo usuário?',
  null,
  null,
  'Code splitting divide o JavaScript em pedaços menores, carregados sob demanda (lazy loading), em vez de baixar a aplicação inteira de uma vez.',
  'Isso reduz o tempo até a página ficar interativa, já que o navegador só baixa o código necessário para a tela atual, adiando o resto.',
  false,
  191
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-system-design'),
  'semana-5-system-design-qual-o-papel-de-um-load-balancer-em-um-sistema-esc',
  'lesson',
  'multiple_choice',
  'medium',
  'Qual o papel de um load balancer em um sistema escalado horizontalmente?',
  '[{"id": "a", "text": "Armazenar dados em cache"}, {"id": "b", "text": "Distribuir requisições entre várias instâncias da aplicação"}, {"id": "c", "text": "Compilar o código"}, {"id": "d", "text": "Gerar relatórios de uso"}]'::jsonb,
  'b',
  'Distribuir requisições entre várias instâncias da aplicação',
  'Sem load balancing, uma única instância poderia ficar sobrecarregada mesmo havendo outras disponíveis para dividir a carga.',
  false,
  192
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-system-design'),
  'semana-5-system-design-por-que-cache-costuma-ser-citado-como-uma-das-form',
  'lesson',
  'open',
  'medium',
  'Por que cache costuma ser citado como uma das formas mais eficazes de melhorar performance sob alta carga?',
  null,
  null,
  'Porque reduz a carga no banco de dados ao evitar recalcular/rebuscar os mesmos dados repetidamente, sendo relativamente simples de implementar em pontos estratégicos.',
  'Esse conceito conecta diretamente com a Semana 1 (Redis/cache) — é a mesma ideia aplicada agora em escala de sistema inteiro.',
  false,
  193
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-system-design'),
  'semana-5-system-design-pergunta-de-revis-o-o-que-voc-faria-se-o-smartfina',
  'lesson',
  'open',
  'hard',
  'Pergunta de revisão: o que você faria se o SmartFinance recebesse centenas de milhares de acessos simultâneos?',
  null,
  null,
  'Cachear as consultas mais frequentes, garantir índices adequados nas tabelas mais acessadas, mover geração de relatórios/PDF para uma fila em background (Celery), servir assets estáticos via CDN, e escalar a API horizontalmente atrás de um load balancer.',
  'Essa resposta combina várias técnicas de system design estudadas (cache, índices, filas, CDN, escalabilidade horizontal), demonstrando visão de arquitetura de ponta a ponta.',
  false,
  194
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-system-design'),
  'semana-5-system-design-por-que-adicionar-mais-servidores-sozinho-nem-semp',
  'lesson',
  'open',
  'hard',
  'Por que ''adicionar mais servidores'' sozinho nem sempre resolve um problema de performance?',
  null,
  null,
  'Porque se o gargalo real está em outro ponto (ex: uma query lenta sem índice, ou um banco de dados único que não escala horizontalmente), adicionar mais servidores de aplicação não resolve — só move o gargalo, ou não o afeta.',
  'Escalabilidade eficaz exige identificar corretamente ONDE está o gargalo antes de escolher a solução (cache, índice, fila, mais instâncias, etc).',
  false,
  195
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-code-review'),
  'semana-5-code-review-o-que-a-sigla-dry-representa',
  'lesson',
  'multiple_choice',
  'easy',
  'O que a sigla DRY representa?',
  '[{"id": "a", "text": "Do it Right, Yes"}, {"id": "b", "text": "Don''t Repeat Yourself"}, {"id": "c", "text": "Design Requires Yielding"}, {"id": "d", "text": "Data Rarely Yields"}]'::jsonb,
  'b',
  'Don''t Repeat Yourself',
  'DRY é o princípio de evitar duplicar a mesma lógica em vários lugares, centralizando-a em uma função/módulo reutilizável.',
  false,
  196
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-code-review'),
  'semana-5-code-review-coment-rios-no-c-digo-devem-explicar-tudo-que-o-c-',
  'lesson',
  'true_false',
  'easy',
  'Comentários no código devem explicar tudo que o código faz, linha por linha.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'Comentários devem explicar o ''porquê'' quando não é óbvio pelo próprio código, não narrar linha a linha o que o código já deixa claro por si.',
  false,
  197
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-code-review'),
  'semana-5-code-review-qual-a-diferen-a-entre-um-coment-rio-de-review-blo',
  'lesson',
  'open',
  'medium',
  'Qual a diferença entre um comentário de review ''bloqueante'' e uma ''sugestão''?',
  null,
  null,
  'Um comentário bloqueante precisa ser resolvido antes do merge (ex: um bug real); uma sugestão é um nice-to-have que pode ser feito depois, sem impedir a aprovação.',
  'Distinguir claramente os dois tipos evita ambiguidade sobre o que realmente precisa ser corrigido antes de mesclar o código.',
  false,
  198
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-code-review'),
  'semana-5-code-review-o-que-o-princ-pio-kiss-keep-it-simple-stupid-recom',
  'lesson',
  'multiple_choice',
  'medium',
  'O que o princípio KISS (Keep It Simple, Stupid) recomenda?',
  '[{"id": "a", "text": "Sempre criar abstrações complexas por precaução"}, {"id": "b", "text": "Preferir a solução mais simples que resolve o problema"}, {"id": "c", "text": "Escrever o mínimo de testes possível"}, {"id": "d", "text": "Evitar comentários no código"}]'::jsonb,
  'b',
  'Preferir a solução mais simples que resolve o problema',
  'KISS defende evitar complexidade desnecessária — código simples é mais fácil de entender, manter e depurar.',
  false,
  199
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-code-review'),
  'semana-5-code-review-por-que-dry-e-kiss-s-vezes-competem-entre-si',
  'lesson',
  'open',
  'medium',
  'Por que DRY e KISS às vezes competem entre si?',
  null,
  null,
  'Porque eliminar toda duplicação (DRY) pode exigir criar abstrações genéricas complexas cedo demais, o que viola KISS; às vezes duplicar um pouco de código simples é preferível a uma abstração prematura complicada.',
  'Bom senso de engenharia é saber balancear os dois — nem duplicar tudo, nem abstrair tudo prematuramente.',
  false,
  200
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-code-review'),
  'semana-5-code-review-ao-revisar-um-pull-request-quais-tr-s-perguntas-aj',
  'lesson',
  'open',
  'hard',
  'Ao revisar um Pull Request, quais três perguntas ajudam a avaliar se ele está pronto para ser aprovado?',
  null,
  null,
  'Isso vai quebrar em produção? Outra pessoa do time entenderia esse código sem contexto extra? Os casos de erro (não só o caminho feliz) foram tratados e testados?',
  'Essas perguntas cobrem os pilares centrais de um bom review: correção, manutenibilidade e robustez contra falhas.',
  false,
  201
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-preparacao-entrevista'),
  'semana-5-preparacao-entrevista-ao-revisar-os-pr-prios-projetos-de-portf-lio-antes',
  'lesson',
  'open',
  'medium',
  'Ao revisar os próprios projetos de portfólio antes de uma entrevista, quais quatro pontos vale preparar para cada um?',
  null,
  null,
  'O problema que o projeto resolve, as decisões de arquitetura tomadas (e por quê), um desafio técnico enfrentado e como foi resolvido, e o que faria diferente hoje.',
  'Esses quatro pontos cobrem a maioria das perguntas que um entrevistador técnico faz sobre um projeto de portfólio.',
  false,
  202
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-preparacao-entrevista'),
  'semana-5-preparacao-entrevista-qual-a-melhor-forma-de-preparar-a-resposta-para-fa',
  'lesson',
  'multiple_choice',
  'medium',
  'Qual é a melhor forma de preparar a resposta para ''fale sobre você'' em uma entrevista?',
  '[{"id": "a", "text": "Decorar um texto genérico de internet, palavra por palavra"}, {"id": "b", "text": "Preparar uma estrutura (trajetória, o que estudou, o que busca) e adaptar naturalmente às próprias palavras"}, {"id": "c", "text": "Não se preparar, para soar mais espontâneo"}, {"id": "d", "text": "Focar apenas em listar certificados"}]'::jsonb,
  'b',
  'Preparar uma estrutura (trajetória, o que estudou, o que busca) e adaptar naturalmente às próprias palavras',
  'Uma estrutura ensaiada mas não decorada soa natural e evita divagar ou esquecer pontos importantes sob a pressão da entrevista.',
  false,
  203
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-preparacao-entrevista'),
  'semana-5-preparacao-entrevista-por-que-entender-os-conceitos-para-explicar-com-as',
  'lesson',
  'open',
  'hard',
  'Por que ''entender os conceitos para explicar com as próprias palavras'' é mais eficaz do que decorar respostas prontas, em uma entrevista técnica?',
  null,
  null,
  'Porque entrevistadores frequentemente fazem perguntas de acompanhamento ou variações do cenário original; quem decorou uma resposta trava diante de qualquer variação, enquanto quem entende o conceito consegue adaptar o raciocínio.',
  'Entrevistas técnicas testam compreensão, não memorização — a capacidade de aplicar um conceito a um cenário levemente diferente é o que realmente demonstra domínio.',
  false,
  204
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-quais-s-o-os-seis-pontos-sugeridos-para-estruturar',
  'interview_apresentacao',
  'open',
  'easy',
  'Quais são os seis pontos sugeridos para estruturar uma apresentação pessoal em entrevista?',
  null,
  null,
  'Quem você é, área de atuação, tecnologias, experiência/projetos, diferenciais, e o que está buscando.',
  'Essa estrutura garante uma apresentação organizada de 1-2 minutos, sem divagar nem esquecer informações relevantes.',
  true,
  205
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-modelo-de-apresenta-o-pessoal-deve-ser-usado-pal',
  'interview_apresentacao',
  'true_false',
  'easy',
  'O modelo de apresentação pessoal deve ser usado palavra por palavra, sem adaptações, na entrevista real.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'O modelo é uma referência estrutural — deve ser adaptado para a experiência real de cada pessoa, nunca apresentado como se fosse a história de outra pessoa.',
  true,
  206
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-por-que-importante-terminar-a-apresenta-o-pessoal-',
  'interview_apresentacao',
  'open',
  'medium',
  'Por que é importante terminar a apresentação pessoal falando sobre ''o que você busca'' na próxima oportunidade?',
  null,
  null,
  'Porque isso ajuda o entrevistador a entender se há alinhamento entre a vaga e os objetivos da pessoa candidata, e demonstra intencionalidade na busca.',
  'Uma apresentação que só lista o passado, sem conectar com o futuro desejado, perde a chance de mostrar alinhamento com a vaga.',
  true,
  207
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-adaptar-o-modelo-de-apresenta-o-pessoal-para-',
  'interview_apresentacao',
  'open',
  'hard',
  'Como adaptar o modelo de apresentação pessoal para alguém que está migrando de carreira e ainda não tem experiência profissional formal em desenvolvimento?',
  null,
  null,
  'Substituir ''experiência profissional'' por projetos de estudo/portfólio reais, destacando o processo de aprendizado, a disciplina na trilha de estudos, e conectando experiências anteriores (mesmo de outra área) com competências transferíveis, como resolução de problemas.',
  'Honestidade sobre o estágio atual da jornada, combinada com evidências concretas de estudo e prática, costuma ser mais convincente do que tentar disfarçar a falta de experiência formal.',
  true,
  208
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-qual-a-diferen-a-entre-lista-e-tupla-em-python',
  'interview_python',
  'open',
  'easy',
  'Qual a diferença entre lista e tupla em Python?',
  null,
  null,
  'Lista é mutável (pode ser alterada após criada); tupla é imutável.',
  'Essa é uma das perguntas mais recorrentes em entrevistas de Python — mostra domínio de fundamentos.',
  true,
  209
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-que-pep-8',
  'interview_python',
  'open',
  'easy',
  'O que é PEP 8?',
  null,
  null,
  'É o guia de estilo oficial para código Python, com convenções de formatação e nomenclatura.',
  'Seguir PEP 8 demonstra atenção à legibilidade e às convenções da comunidade Python.',
  true,
  210
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-que-s-o-args-e-kwargs-em-uma-fun-o-python',
  'interview_python',
  'open',
  'medium',
  'O que são *args e **kwargs em uma função Python?',
  null,
  null,
  '`*args` captura argumentos posicionais extras como uma tupla; `**kwargs` captura argumentos nomeados extras como um dicionário.',
  'Permitem criar funções flexíveis que aceitam um número variável de argumentos.',
  true,
  211
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-que-o-gil-global-interpreter-lock-no-cpython-res',
  'interview_python',
  'open',
  'medium',
  'O que é o GIL (Global Interpreter Lock) no CPython, resumidamente?',
  null,
  null,
  'É um mecanismo que impede múltiplas threads Python de executarem bytecode Python simultaneamente no mesmo processo, limitando paralelismo real de CPU com threads.',
  'É por isso que, para paralelismo real de CPU em Python, muitas vezes se usa multiprocessing em vez de threading.',
  true,
  212
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-que-este-c-digo-imprime-e-por-qu-python-def-f-a-',
  'interview_python',
  'code',
  'medium',
  'O que este código imprime e por quê?
```python
def f(a, lista=[]):
    lista.append(a)
    return lista
print(f(1))
print(f(2))
```',
  null,
  null,
  '[1] e depois [1, 2] — o valor padrão mutável é criado uma vez só e reutilizado entre chamadas.',
  'Clássica pegadinha de entrevista sobre valores padrão mutáveis em Python.',
  true,
  213
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-explique-a-diferen-a-entre-is-e-em-python',
  'interview_python',
  'open',
  'hard',
  'Explique a diferença entre `is` e `==` em Python.',
  null,
  null,
  '`==` compara igualdade de valor; `is` compara identidade — se são o mesmo objeto na memória.',
  'Dois objetos podem ter valores iguais (`==` verdadeiro) sem serem o mesmo objeto (`is` falso).',
  true,
  214
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-que-um-decorador-e-como-voc-criaria-um-decorador',
  'interview_python',
  'open',
  'hard',
  'O que é um decorador e como você criaria um decorador simples de logging?',
  null,
  null,
  'Um decorador é uma função que recebe outra função e retorna uma nova função com comportamento adicional. Um decorador de logging envolveria a função original, registrando algo antes/depois de chamá-la, e retornando o resultado normalmente.',
  'Decoradores são amplamente usados em frameworks como FastAPI (`@app.get(...)`) e Flask para adicionar comportamento sem alterar a função original.',
  true,
  215
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-que-o-virtual-dom-e-por-que-o-react-o-utiliza',
  'interview_react',
  'open',
  'easy',
  'O que é o Virtual DOM e por que o React o utiliza?',
  null,
  null,
  'É uma representação em memória da UI; o React o usa para calcular eficientemente quais partes do DOM real precisam ser atualizadas.',
  'Isso evita manipulações desnecessárias e custosas do DOM real a cada mudança de estado.',
  true,
  216
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-qual-a-diferen-a-entre-estado-state-e-propriedades',
  'interview_react',
  'open',
  'easy',
  'Qual a diferença entre estado (state) e propriedades (props) em React?',
  null,
  null,
  'State é dado interno e mutável de um componente; props são dados recebidos do componente pai, somente leitura para quem recebe.',
  'Um componente controla seu próprio state, mas não deve alterar props recebidas diretamente.',
  true,
  217
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-quando-voc-usaria-usememo-em-vez-de-calcular-um-va',
  'interview_react',
  'open',
  'medium',
  'Quando você usaria `useMemo` em vez de calcular um valor diretamente no corpo do componente?',
  null,
  null,
  'Quando o cálculo é genuinamente custoso e você quer evitar refazê-lo a cada renderização, recalculando só quando as dependências mudam.',
  'Usar `useMemo` sem necessidade real adiciona complexidade sem ganho de performance perceptível.',
  true,
  218
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-explique-o-conceito-de-lifting-state-up-elevar-o-e',
  'interview_react',
  'open',
  'medium',
  'Explique o conceito de ''lifting state up'' (elevar o estado) em React.',
  null,
  null,
  'É mover um estado compartilhado por múltiplos componentes para o ancestral comum mais próximo, passando-o para baixo via props.',
  'Isso evita duplicar/dessincronizar estado entre componentes irmãos que precisam do mesmo dado.',
  true,
  219
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-por-que-renderizar-uma-lista-sem-uma-key-est-vel-e',
  'interview_react',
  'open',
  'hard',
  'Por que renderizar uma lista sem uma `key` estável (ex: usando o índice do array) pode causar bugs?',
  null,
  null,
  'Porque o React usa a `key` para identificar quais itens mudaram/foram adicionados/removidos entre renderizações; usar o índice pode fazer o React associar erroneamente o estado de um item a outro quando a lista é reordenada ou filtrada.',
  'O ideal é usar um identificador único e estável do próprio dado (como um `id`), não a posição no array.',
  true,
  220
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-voc-explicaria-para-algu-m-n-o-t-cnico-por-qu',
  'interview_react',
  'open',
  'hard',
  'Como você explicaria, para alguém não técnico, por que o React re-renderiza um componente quando o estado muda?',
  null,
  null,
  'O React observa mudanças de dados (estado) e recalcula a interface correspondente automaticamente, comparando com a versão anterior e atualizando na tela só o que realmente mudou — como um mapa que se atualiza sozinho quando algo no território muda.',
  'Uma boa resposta em entrevista demonstra a capacidade de explicar conceitos técnicos de forma acessível, uma habilidade de comunicação valorizada em times multidisciplinares.',
  true,
  221
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-que-significa-rest-em-uma-api',
  'interview_api',
  'open',
  'easy',
  'O que significa REST em uma API?',
  null,
  null,
  'Representational State Transfer — um estilo arquitetural onde recursos são acessados via URLs previsíveis, usando verbos HTTP para indicar a ação.',
  'REST não é um protocolo rígido, mas um conjunto de convenções amplamente adotado para design de APIs.',
  true,
  222
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-qual-a-diferen-a-entre-autentica-o-e-autoriza-o',
  'interview_api',
  'open',
  'easy',
  'Qual a diferença entre autenticação e autorização?',
  null,
  null,
  'Autenticação confirma QUEM é o usuário; autorização define O QUE esse usuário tem permissão de fazer.',
  'Um usuário pode estar autenticado (identificado) mas não autorizado a acessar um recurso específico.',
  true,
  223
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-voc-projetaria-a-pagina-o-de-um-endpoint-que-',
  'interview_api',
  'open',
  'medium',
  'Como você projetaria a paginação de um endpoint que lista milhares de registros?',
  null,
  null,
  'Usando parâmetros como `page`/`limit` (offset-based) ou um cursor (cursor-based, mais estável quando dados mudam entre as páginas), retornando também metadados como total de páginas/registros.',
  'A escolha depende do caso: cursor-based evita duplicatas/saltos quando novos dados são inseridos durante a paginação.',
  true,
  224
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-voc-lidaria-com-uma-api-externa-que-s-vezes-f',
  'interview_api',
  'open',
  'medium',
  'Como você lidaria com uma API externa que às vezes fica fora do ar, da qual seu backend depende?',
  null,
  null,
  'Implementando timeout, retry com backoff, tratamento de erro claro (não deixar a exceção propagar sem controle), e possivelmente um circuit breaker para evitar sobrecarregar um serviço já instável.',
  'Dependências externas instáveis são uma realidade — o sistema deve degradar graciosamente, não quebrar completamente.',
  true,
  225
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-quais-cuidados-de-seguran-a-voc-tomaria-ao-projeta',
  'interview_api',
  'open',
  'hard',
  'Quais cuidados de segurança você tomaria ao projetar uma API que recebe dados de formulários de usuários?',
  null,
  null,
  'Validar e sanitizar todos os inputs no backend (nunca confiar só no frontend), usar autenticação/autorização adequadas, aplicar rate limiting, e nunca expor informações sensíveis em mensagens de erro.',
  'Segurança de API é uma camada essencial que não pode depender de validação do lado do cliente, que pode ser facilmente contornada.',
  true,
  226
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-voc-decidiria-entre-usar-rest-ou-outra-aborda',
  'interview_api',
  'open',
  'hard',
  'Como você decidiria entre usar REST ou outra abordagem (como GraphQL) para uma nova API?',
  null,
  null,
  'Depende do caso: REST é simples e amplamente compreendido, bom para CRUDs diretos; GraphQL pode ser melhor quando clientes diferentes precisam de formatos de dados muito variados, evitando over-fetching/under-fetching.',
  'Uma boa resposta reconhece trade-offs em vez de apresentar uma tecnologia como sempre superior à outra.',
  true,
  227
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-que-uma-chave-estrangeira-foreign-key',
  'interview_db',
  'open',
  'easy',
  'O que é uma chave estrangeira (foreign key)?',
  null,
  null,
  'É uma coluna que referencia a chave primária de outra tabela, criando um relacionamento entre elas.',
  'Chaves estrangeiras garantem integridade referencial — impedem, por exemplo, uma revisão referenciar um usuário inexistente.',
  true,
  228
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-quando-um-ndice-pode-piorar-a-performance-de-um-si',
  'interview_db',
  'open',
  'medium',
  'Quando um índice pode PIORAR a performance de um sistema?',
  null,
  null,
  'Em tabelas com muita escrita (insert/update/delete) e poucas leituras naquela coluna, o custo de manter o índice atualizado pode superar o benefício de buscas mais rápidas.',
  'Índices não são gratuitos — cada um adiciona overhead de escrita e espaço em disco.',
  true,
  229
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-explique-a-diferen-a-entre-um-relacionamento-1-n-e',
  'interview_db',
  'open',
  'medium',
  'Explique a diferença entre um relacionamento 1:N e N:N com um exemplo.',
  null,
  null,
  '1:N: um usuário tem várias revisões (cada revisão pertence a um único usuário). N:N: uma aula pode ter várias tags e uma tag pode estar em várias aulas — exige uma tabela associativa.',
  'Reconhecer o tipo de relacionamento certo evita modelagem incorreta do banco.',
  true,
  230
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-voc-investigaria-uma-query-que-est-lenta-em-p',
  'interview_db',
  'open',
  'hard',
  'Como você investigaria uma query que está lenta em produção?',
  null,
  null,
  'Analisando o plano de execução (EXPLAIN), verificando se há índices adequados nas colunas usadas em WHERE/JOIN, e observando se a query está trazendo mais dados do que o necessário.',
  'Adivinhar a causa sem medir é arriscado — ferramentas de análise de plano de execução são o primeiro passo padrão.',
  true,
  231
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-que-row-level-security-rls-e-por-que-ele-til-em-',
  'interview_db',
  'open',
  'hard',
  'O que é Row Level Security (RLS) e por que ele é útil em uma aplicação multi-usuário como o ReviseTI?',
  null,
  null,
  'RLS é um mecanismo do banco (usado pelo Supabase) que aplica automaticamente filtros de segurança nas consultas, garantindo que cada usuário só acesse suas próprias linhas — mesmo que o frontend tente burlar isso.',
  'RLS move a responsabilidade de isolamento de dados do frontend (que pode ser manipulado) para o próprio banco de dados, uma camada muito mais confiável.',
  true,
  232
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-qual-a-diferen-a-entre-git-merge-e-git-rebase',
  'interview_git',
  'open',
  'easy',
  'Qual a diferença entre `git merge` e `git rebase`?',
  null,
  null,
  'Merge combina o histórico de duas branches criando um commit de merge; rebase reaplica os commits sobre uma nova base, criando um histórico linear (sem commit de merge).',
  'Merge preserva o histórico exato de como as coisas aconteceram; rebase reescreve para parecer linear.',
  true,
  233
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-que-voc-faria-se-cometesse-um-commit-com-uma-inf',
  'interview_git',
  'open',
  'medium',
  'O que você faria se cometesse um commit com uma informação sensível (como uma senha) por engano?',
  null,
  null,
  'Trocar a credencial imediatamente (considerá-la comprometida) e, se possível, remover do histórico do Git (com ferramentas como filter-branch/BFG), avisando a equipe se a branch já foi compartilhada.',
  'Apenas remover em um novo commit NÃO apaga do histórico — a credencial continua visível em commits anteriores até ser reescrita ou trocada.',
  true,
  234
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-voc-organizaria-o-fluxo-de-branches-branching',
  'interview_git',
  'open',
  'hard',
  'Como você organizaria o fluxo de branches (branching strategy) de um time pequeno trabalhando em um mesmo projeto?',
  null,
  null,
  'Uma abordagem comum: uma branch principal estável (`main`), branches de feature criadas a partir dela para cada tarefa, revisão via Pull Request antes de mesclar, e testes automatizados (CI) rodando em cada PR.',
  'Não existe uma única resposta certa — o importante é demonstrar entendimento de por que cada prática (branch por feature, review, CI) existe.',
  true,
  235
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-voc-normalmente-lida-com-feedback-sobre-seu-c',
  'interview_comportamental',
  'open',
  'easy',
  'Como você normalmente lida com feedback sobre seu código durante um code review?',
  null,
  null,
  'Resposta pessoal — o importante é demonstrar abertura para feedback, sem levar críticas técnicas para o lado pessoal, e disposição para aprender com elas.',
  'Entrevistadores avaliam maturidade profissional nessa pergunta, não uma resposta ''certa'' única.',
  true,
  236
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-conte-sobre-uma-decis-o-t-cnica-dif-cil-que-voc-te',
  'interview_comportamental',
  'open',
  'medium',
  'Conte sobre uma decisão técnica difícil que você teve que tomar (ou tomaria) em um projeto.',
  null,
  null,
  'Resposta pessoal — estruture usando o método STAR: qual era a situação, o que precisava decidir, quais opções considerou, qual escolheu e por quê, e qual foi o resultado.',
  'Essa pergunta avalia raciocínio técnico e capacidade de justificar escolhas com trade-offs, não apenas conhecer a ''resposta certa''.',
  true,
  237
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-voc-prioriza-tarefas-quando-tem-v-rias-pend-n',
  'interview_comportamental',
  'open',
  'medium',
  'Como você prioriza tarefas quando tem várias pendências ao mesmo tempo?',
  null,
  null,
  'Resposta pessoal — pode mencionar critérios como urgência, impacto, dependências entre tarefas, e comunicação com a equipe sobre prioridades quando há conflito.',
  'Avaliadores buscam um processo de pensamento organizado, não uma fórmula mágica.',
  true,
  238
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-fale-sobre-um-bug-dif-cil-que-voc-j-enfrentou-ou-u',
  'interview_comportamental',
  'open',
  'hard',
  'Fale sobre um bug difícil que você já enfrentou (ou um cenário hipotético) e como investigaria a causa raiz.',
  null,
  null,
  'Estruturar com STAR: contexto do bug, o que fazia parecer difícil, passos de investigação (reproduzir, isolar variáveis, usar logs/debugger), e como confirmou e corrigiu a causa raiz.',
  'Essa pergunta avalia processo de debugging metódico, uma habilidade central para qualquer desenvolvedor(a).',
  true,
  239
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-explique-o-projeto-pokefast-api-qual-problema-ele-',
  'interview_projeto_pokefast',
  'open',
  'medium',
  'Explique o projeto PokeFast API: qual problema ele resolve?',
  null,
  null,
  'É um projeto-exemplo que expõe endpoints próprios consumindo a PokéAPI externa, servindo como case de estudo de consumo assíncrono de API, organização de projeto e testes em Python/FastAPI.',
  'Ao responder sobre um projeto-exemplo, é importante deixar claro que é um case didático, sem inventar detalhes que não foram definidos.',
  true,
  240
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-o-pokefast-api-trata-o-cen-rio-de-a-pok-api-e',
  'interview_projeto_pokefast',
  'open',
  'medium',
  'Como o PokeFast API trata o cenário de a PokéAPI externa estar lenta ou fora do ar?',
  null,
  null,
  'Ao estudar esse cenário, considere tratamento de erros e timeouts como prática esperada ao depender de serviços de terceiros, evitando afirmar um comportamento específico não documentado do projeto real.',
  'Esse é um exemplo de como responder com honestidade quando um detalhe específico não está definido: apresentar a prática esperada de forma genérica, sem fingir certeza sobre a implementação real.',
  true,
  241
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-voc-testaria-os-endpoints-do-pokefast-api-inc',
  'interview_projeto_pokefast',
  'open',
  'hard',
  'Como você testaria os endpoints do PokeFast API, incluindo casos de erro?',
  null,
  null,
  'Com testes de integração usando um client de teste (como o TestClient do FastAPI), cobrindo o caminho de sucesso (Pokémon existente) e casos de erro (Pokémon inexistente, falha na API externa simulada via mock).',
  'Conectar a resposta aos conceitos de testes e mocking estudados na Semana 1 demonstra aplicação prática do conteúdo.',
  true,
  242
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-voc-escalaria-o-pokefast-api-se-ele-recebesse',
  'interview_projeto_pokefast',
  'open',
  'hard',
  'Como você escalaria o PokeFast API se ele recebesse um grande aumento de tráfego?',
  null,
  null,
  'Considerando cache das respostas mais consultadas (já que dados de Pokémon mudam raramente), paginação nos endpoints que listam múltiplos itens, e escalabilidade horizontal da API atrás de um load balancer.',
  'Resposta genérica e didática, aplicando os conceitos de performance e system design ao contexto específico desse projeto-exemplo.',
  true,
  243
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-explique-o-projeto-smartfinance-qual-problema-ele-',
  'interview_projeto_smartfinance',
  'open',
  'medium',
  'Explique o projeto SmartFinance: qual problema ele resolve?',
  null,
  null,
  'É um projeto-exemplo de dashboard financeiro pessoal em React/TypeScript, servindo como case de estudo de visualização de dados, componentização e boas práticas de UX em aplicações de dados.',
  'Como projeto-exemplo didático, o foco está em demonstrar os padrões de arquitetura frontend estudados, não em alegar funcionalidades específicas não definidas.',
  true,
  244
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-o-smartfinance-trata-os-estados-de-loading-em',
  'interview_projeto_smartfinance',
  'open',
  'medium',
  'Como o SmartFinance trata os estados de loading/empty/error dos gráficos do dashboard?',
  null,
  null,
  'Seguindo a prática estudada de tratar cada card/gráfico com seu próprio ciclo de loading/empty/error, para que um problema em uma parte do dashboard não trave a exibição das demais.',
  'Essa resposta conecta o projeto-exemplo com o conceito de integração full stack estudado na Semana 3.',
  true,
  245
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-voc-estruturaria-os-componentes-de-gr-fico-do',
  'interview_projeto_smartfinance',
  'open',
  'hard',
  'Como você estruturaria os componentes de gráfico do SmartFinance para que fossem reutilizáveis?',
  null,
  null,
  'Extraindo cada tipo de gráfico em um componente próprio (ex: um componente de card de métrica, outro de gráfico de linha), recebendo os dados já formatados via props, evitando duplicar a mesma combinação de configuração em vários lugares.',
  'Isso reflete o princípio de componentização estudado na Semana 3 de React, aplicado ao contexto de um dashboard.',
  true,
  246
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-que-melhorias-de-seguran-a-voc-consideraria-import',
  'interview_projeto_smartfinance',
  'open',
  'hard',
  'Que melhorias de segurança você consideraria importantes em um app como o SmartFinance, que lida com dados financeiros?',
  null,
  null,
  'Validação rigorosa de inputs, autenticação e autorização adequadas (isolamento de dados por usuário via RLS, por exemplo), e nunca expor dados sensíveis em logs ou respostas de erro.',
  'Dados financeiros exigem atenção redobrada à segurança — essa resposta conecta boas práticas gerais de segurança de API ao contexto sensível desse projeto-exemplo.',
  true,
  247
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-voc-decidiria-entre-processar-uma-tarefa-de-f',
  'interview_arquitetura',
  'open',
  'medium',
  'Como você decidiria entre processar uma tarefa de forma síncrona (na própria requisição) ou assíncrona (em uma fila)?',
  null,
  null,
  'Se a tarefa é rápida e o usuário precisa do resultado imediato na resposta, processar de forma síncrona; se é lenta, não crítica para a resposta imediata, ou pode falhar e precisar de retry, mover para uma fila (ex: Celery).',
  'Essa decisão conecta diretamente os conceitos de mensageria/performance da Semana 1 com decisões práticas de arquitetura.',
  true,
  248
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-explique-com-trade-offs-quando-voc-optaria-por-mon',
  'interview_arquitetura',
  'open',
  'hard',
  'Explique, com trade-offs, quando você optaria por monolito versus microsserviços em um projeto novo.',
  null,
  null,
  'Um monolito é mais simples de desenvolver e implantar no início, bom para times pequenos e produtos em validação; microsserviços trazem escalabilidade e times independentes, mas adicionam complexidade operacional (deploy, comunicação entre serviços, observabilidade).',
  'Uma boa resposta evita dizer que uma abordagem é ''sempre melhor'' — arquitetura é sobre trade-offs adequados ao contexto (tamanho do time, estágio do produto, necessidade real de escala).',
  true,
  249
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-voc-garantiria-que-uma-altera-o-de-schema-de-',
  'interview_arquitetura',
  'open',
  'hard',
  'Como você garantiria que uma alteração de schema de banco de dados não quebre a aplicação em produção durante o deploy?',
  null,
  null,
  'Usando migrations versionadas e testadas, preferindo mudanças retrocompatíveis (aditivas) quando possível, e coordenando a ordem de deploy entre aplicação e banco para evitar janelas onde o código espera um schema que ainda não existe (ou já foi removido).',
  'Esse tipo de pergunta avalia maturidade sobre operações em produção, não apenas conhecimento teórico de migrations.',
  true,
  250
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-preparacao-entrevista'),
  'semana-5-preparacao-entrevista-qual-das-op-es-abaixo-faz-parte-do-checklist-de-re',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual das opções abaixo faz parte do checklist de revisão técnica final sugerido?',
  '[{"id": "a", "text": "Revisão de Python, JavaScript, React e TypeScript"}, {"id": "b", "text": "Revisão de culinária"}, {"id": "c", "text": "Revisão de idiomas estrangeiros"}, {"id": "d", "text": "Revisão de finanças pessoais"}]'::jsonb,
  'a',
  'Revisão de Python, JavaScript, React e TypeScript',
  'O checklist final cobre as tecnologias centrais da trilha Full Stack Python + React estudadas ao longo das 5 semanas.',
  false,
  251
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-preparacao-entrevista'),
  'semana-5-preparacao-entrevista-revisar-os-pr-prios-projetos-de-portf-lio-t-o-impo',
  'lesson',
  'true_false',
  'easy',
  'Revisar os próprios projetos de portfólio é tão importante quanto revisar teoria antes de uma entrevista.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'a',
  'Verdadeiro',
  'É sobre os projetos do portfólio que a conversa técnica provavelmente vai girar — dominar seus detalhes é essencial.',
  false,
  252
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-preparacao-entrevista'),
  'semana-5-preparacao-entrevista-por-que-revisar-git-faz-parte-da-prepara-o-t-cnica',
  'lesson',
  'open',
  'medium',
  'Por que revisar Git faz parte da preparação técnica final, mesmo sendo uma ferramenta e não uma linguagem?',
  null,
  null,
  'Porque fluência em Git (branches, merge, resolução de conflitos) é esperada no dia a dia de qualquer time de desenvolvimento, e é um tópico comum em entrevistas técnicas.',
  'Ferramentas de colaboração como Git são tão avaliadas quanto conhecimento de linguagens, pois refletem a capacidade de trabalhar em equipe.',
  false,
  253
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-soft-skills-star'),
  'semana-5-soft-skills-star-o-que-significa-a-letra-s-e-a-letra-t-no-m-todo-st',
  'lesson',
  'open',
  'medium',
  'O que significa a letra ''S'' e a letra ''T'' no método STAR?',
  null,
  null,
  'S = Situação (o contexto: onde, quando, com quem); T = Tarefa (qual era o objetivo ou responsabilidade naquela situação).',
  'Situação e Tarefa estabelecem o contexto antes de descrever a Ação tomada e o Resultado alcançado.',
  false,
  254
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-soft-skills-star'),
  'semana-5-soft-skills-star-por-que-importante-escolher-exemplos-reais-ao-resp',
  'lesson',
  'open',
  'hard',
  'Por que é importante escolher exemplos REAIS ao responder perguntas comportamentais, em vez de inventar situações?',
  null,
  null,
  'Porque entrevistadores frequentemente fazem perguntas de aprofundamento sobre os detalhes da situação; uma história inventada é mais difícil de sustentar sob perguntas de acompanhamento específicas.',
  'Além da questão ética, histórias reais têm detalhes naturais e consistentes que tornam a resposta mais crível e específica.',
  false,
  255
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-code-review'),
  'semana-5-code-review-um-pull-request-s-deve-ser-aprovado-se-o-c-digo-se',
  'lesson',
  'true_false',
  'easy',
  'Um Pull Request só deve ser aprovado se o código seguir exatamente o mesmo estilo do revisor.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'O foco do review deve ser correção, legibilidade e manutenibilidade — não impor preferências estilísticas pessoais do revisor quando o código já é claro e segue os padrões do projeto.',
  false,
  256
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-code-review'),
  'semana-5-code-review-o-que-o-princ-pio-solid-busca-promover-no-design-d',
  'lesson',
  'open',
  'medium',
  'O que o princípio SOLID busca promover no design de código orientado a objetos?',
  null,
  null,
  'Um conjunto de 5 princípios (Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion) que ajudam a manter código flexível e desacoplado.',
  'Seguir SOLID facilita estender e manter o código ao longo do tempo, reduzindo o acoplamento entre partes do sistema.',
  false,
  257
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-system-design'),
  'semana-5-system-design-o-que-throughput-em-performance-de-sistemas-e-como',
  'lesson',
  'open',
  'medium',
  'O que é ''throughput'' em performance de sistemas, e como se diferencia de ''latência''?',
  null,
  null,
  'Throughput é a quantidade de requisições processadas por unidade de tempo; latência é o tempo que uma única requisição leva para ser respondida.',
  'Um sistema pode ter baixa latência mas baixo throughput (rápido para poucos, mas não escala), ou o contrário — são métricas complementares, não a mesma coisa.',
  false,
  258
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-integracao-full-stack'),
  'semana-3-integracao-full-stack-o-que-este-hook-customizado-tenta-resolver-e-o-que',
  'lesson',
  'code',
  'medium',
  'O que este hook customizado tenta resolver, e o que falta nele?
```jsx
function useReviews(userId) {
  const [reviews, setReviews] = useState([]);
  useEffect(() => {
    fetch(`/api/reviews?user=${userId}`).then(r => r.json()).then(setReviews);
  }, [userId]);
  return { reviews };
}
```',
  null,
  null,
  'Tenta centralizar a busca de revisões de um usuário. Falta tratar loading, error, e verificar `response.ok` antes de fazer parsing do JSON.',
  'Um hook de integração completo deve sempre expor os três estados (loading/error/dados) para a tela consumidora poder reagir adequadamente a cada um.',
  false,
  259
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-integracao-full-stack'),
  'semana-3-integracao-full-stack-como-voc-decidiria-se-uma-chamada-de-api-deve-ser-',
  'lesson',
  'open',
  'hard',
  'Como você decidiria se uma chamada de API deve ser feita no componente pai e passada via props, ou diretamente no componente filho que a usa?',
  null,
  null,
  'Se os dados são usados só por aquele componente filho, buscar ali mesmo simplifica; se vários componentes precisam do mesmo dado, buscar no pai (ou em um hook compartilhado/contexto) evita chamadas duplicadas e inconsistência entre eles.',
  'A decisão depende do escopo de uso do dado — centralizar demais gera acoplamento desnecessário, descentralizar demais gera chamadas repetidas e possível inconsistência.',
  false,
  260
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-git-metodologias-ageis'),
  'semana-4-git-metodologias-ageis-explique-a-diferen-a-entre-scrum-e-kanban-em-termo',
  'lesson',
  'open',
  'hard',
  'Explique a diferença entre Scrum e Kanban em termos de como o trabalho é planejado e entregue.',
  null,
  null,
  'Scrum organiza o trabalho em ciclos fixos (Sprints) com planejamento antecipado do que entra em cada ciclo; Kanban é um fluxo contínuo sem ciclos fixos, com foco em limitar o trabalho em progresso e entregar assim que pronto.',
  'A escolha entre os dois depende do tipo de demanda: Scrum funciona bem para entregas planejadas; Kanban para fluxo contínuo e imprevisível (como suporte).',
  false,
  261
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-kubernetes-observabilidade'),
  'semana-4-kubernetes-observabilidade-por-que-reiniciar-o-pod-pode-mascarar-um-problema-',
  'lesson',
  'open',
  'hard',
  'Por que ''reiniciar o Pod'' pode mascarar um problema real de observabilidade em vez de resolvê-lo?',
  null,
  null,
  'Porque reiniciar pode aliviar o sintoma temporariamente (ex: memory leak reseta ao reiniciar), mas sem investigar logs e métricas para entender a causa raiz, o problema tende a se repetir.',
  'Isso reforça a importância de логs e métricas centralizados: sem eles, times recorrem a soluções paliativas (restart) em vez de corrigir a causa real.',
  false,
  262
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-ci-cd'),
  'semana-4-ci-cd-o-que-um-pipeline-quebrado-e-por-que-a-equipe-deve',
  'lesson',
  'open',
  'hard',
  'O que é um ''pipeline quebrado'' e por que a equipe deve tratá-lo como prioridade máxima ao invés de continuar mesclando código?',
  null,
  null,
  'É quando o CI falha na branch principal, indicando que o código naquele estado não é confiável (não builda, não passa nos testes, etc). Continuar mesclando por cima de um pipeline quebrado acumula problemas e dificulta identificar qual mudança causou a falha.',
  'Manter o pipeline sempre ''verde'' na branch principal é uma prática essencial para a confiabilidade contínua da entrega.',
  false,
  263
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-arquitetura-apis'),
  'semana-4-arquitetura-apis-como-versionar-uma-api-ex-v1-reviews-ajuda-a-evolu',
  'lesson',
  'open',
  'hard',
  'Como versionar uma API (ex: `/v1/reviews`) ajuda a evoluir um sistema sem quebrar clientes existentes?',
  null,
  null,
  'Permite introduzir mudanças incompatíveis (breaking changes) em uma nova versão (`/v2/...`), enquanto clientes antigos continuam usando `/v1/...` até migrarem, evitando quebrar integrações existentes de uma hora para outra.',
  'Versionamento de API é uma prática comum quando múltiplos clientes (apps, integrações de terceiros) dependem de contratos estáveis.',
  false,
  264
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-tailwind-responsividade'),
  'semana-2-tailwind-responsividade-um-componente-usa-lg-hidden-para-esconder-algo-no-',
  'lesson',
  'open',
  'hard',
  'Um componente usa `lg:hidden` para esconder algo no desktop, mas o elemento continua ocupando espaço no mobile de forma inesperada. O que investigar?',
  null,
  null,
  'Verificar se o elemento realmente deveria estar visível no mobile (checar a lógica de exibição condicional) e se não há conflito com outra classe de display aplicada ao mesmo elemento.',
  'Classes de visibilidade responsivas do Tailwind seguem a cascata normal do CSS — conflitos entre classes podem gerar comportamento inesperado se não geridos com cuidado.',
  false,
  265
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-estado-global-nextjs'),
  'semana-3-estado-global-nextjs-por-que-um-server-component-n-o-pode-usar-usestate',
  'lesson',
  'open',
  'hard',
  'Por que um Server Component não pode usar `useState`, e o que fazer se aquele trecho específico da UI precisar de interatividade?',
  null,
  null,
  'Server Components rodam no servidor e não têm acesso a hooks de estado do navegador; para a parte que precisa de interatividade, extrai-se um componente separado marcado com `''use client''`.',
  'A estratégia recomendada é manter o máximo possível como Server Components (mais leve, sem JS extra ao cliente) e isolar a interatividade em Client Components pequenos e específicos.',
  false,
  266
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-por-que-funciona-na-minha-m-quina-um-problema-que-',
  'interview_docker_deploy',
  'open',
  'easy',
  'Por que ''funciona na minha máquina'' é um problema que o Docker ajuda a resolver?',
  null,
  null,
  'Porque o container empacota a aplicação com todas as suas dependências e configuração, garantindo que rode da mesma forma em qualquer ambiente (dev, CI, produção).',
  'Diferenças de versão de bibliotecas ou configuração do sistema operacional entre máquinas são uma causa clássica desse problema — o container elimina essa variável.',
  true,
  267
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-que-voc-verificaria-primeiro-se-um-container-de-',
  'interview_docker_deploy',
  'open',
  'medium',
  'O que você verificaria primeiro se um container de produção está reiniciando constantemente (crash loop)?',
  null,
  null,
  'Os logs do container para identificar o erro que está causando o crash, e se as variáveis de ambiente/configurações necessárias (como string de conexão do banco) estão corretamente definidas.',
  'Um crash loop quase sempre tem uma causa registrada nos logs — é o primeiro lugar a olhar antes de qualquer suposição.',
  true,
  268
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-voc-faria-o-deploy-de-uma-nova-vers-o-de-uma-',
  'interview_docker_deploy',
  'open',
  'hard',
  'Como você faria o deploy de uma nova versão de uma API sem downtime perceptível para os usuários?',
  null,
  null,
  'Usando uma estratégia como rolling update (substituir instâncias antigas por novas gradualmente, mantendo algumas sempre disponíveis) ou blue-green deployment (nova versão sobe em paralelo, e o tráfego é redirecionado só quando ela está validada).',
  'Ambas estratégias evitam o cenário de derrubar todas as instâncias antigas antes de as novas estarem prontas para receber tráfego.',
  true,
  269
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-que-essa-query-faz-sql-select-week-number-count-',
  'interview_sql_pratico',
  'code',
  'medium',
  'O que essa query faz?
```sql
SELECT week_number, COUNT(*) 
FROM study_contents 
GROUP BY week_number 
ORDER BY week_number;
```',
  null,
  null,
  'Conta quantos conteúdos existem em cada semana, agrupando por `week_number` e ordenando o resultado pela própria semana.',
  '`GROUP BY` agrupa linhas com o mesmo valor na coluna indicada, permitindo agregações (como `COUNT`) por grupo.',
  true,
  270
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-por-que-usar-select-em-produ-o-geralmente-desacons',
  'interview_sql_pratico',
  'open',
  'medium',
  'Por que usar `SELECT *` em produção é geralmente desaconselhado?',
  null,
  null,
  'Porque traz colunas desnecessárias (desperdiçando banda e memória), e é frágil a mudanças de schema — adicionar uma coluna nova muda silenciosamente o que a query retorna.',
  'Especificar explicitamente as colunas necessárias deixa a intenção da query clara e evita efeitos colaterais de mudanças futuras no schema.',
  true,
  271
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-essa-query-est-sujeita-a-qual-risco-de-seguran-a-e',
  'interview_sql_pratico',
  'code',
  'hard',
  'Essa query está sujeita a qual risco de segurança, e qual é a forma correta de evitá-lo?
```python
query = f"SELECT * FROM users WHERE email = ''{email}''"
cursor.execute(query)
```',
  null,
  null,
  'SQL Injection: se `email` vier de input do usuário sem sanitização, alguém pode injetar SQL malicioso. A forma correta é usar queries parametrizadas (`cursor.execute("SELECT * FROM users WHERE email = %s", (email,))`).',
  'ORMs como o SQLAlchemy já protegem contra isso por padrão quando usados corretamente — o risco aparece principalmente ao concatenar strings SQL manualmente.',
  true,
  272
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-por-que-armazenar-senhas-em-texto-puro-no-banco-de',
  'interview_seguranca',
  'open',
  'medium',
  'Por que armazenar senhas em texto puro no banco de dados é uma falha grave de segurança?',
  null,
  null,
  'Porque, em caso de vazamento do banco, todas as senhas ficam expostas diretamente; senhas devem ser armazenadas com hash (e salt), nunca em texto puro.',
  'Ferramentas de autenticação como o Supabase Auth já cuidam disso corretamente — reforçando por que reinventar autenticação própria costuma ser arriscado.',
  true,
  273
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-que-o-princ-pio-do-menor-privil-gio-aplicado-a-p',
  'interview_seguranca',
  'open',
  'hard',
  'O que é o princípio do menor privilégio, aplicado a permissões de acesso a dados?',
  null,
  null,
  'Cada usuário ou serviço deve ter apenas as permissões mínimas necessárias para realizar sua função — nada além disso.',
  'Isso limita o dano potencial caso uma credencial seja comprometida, e é a lógica por trás de políticas RLS específicas por operação (select/insert/update/delete).',
  true,
  274
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-mensageria-cache'),
  'semana-1-mensageria-cache-uma-dead-letter-queue-armazena-mensagens-que-falha',
  'lesson',
  'true_false',
  'medium',
  'Uma dead-letter queue armazena mensagens que falharam repetidamente no processamento, para análise posterior.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'a',
  'Verdadeiro',
  'Em vez de perder ou tentar reprocessar uma mensagem problemática indefinidamente, ela é movida para uma fila separada para investigação manual.',
  false,
  275
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-testes-pytest'),
  'semana-1-testes-pytest-testes-de-integra-o-s-o-sempre-mais-r-pidos-de-exe',
  'lesson',
  'true_false',
  'medium',
  'Testes de integração são sempre mais rápidos de executar do que testes unitários.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'Testes de integração geralmente envolvem mais componentes reais (banco, rede simulada), sendo mais lentos que testes unitários isolados.',
  false,
  276
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-javascript-assincrono'),
  'semana-2-javascript-assincrono-array-prototype-some-retorna-true-assim-que-encont',
  'lesson',
  'true_false',
  'medium',
  '`Array.prototype.some()` retorna `true` assim que encontra o primeiro elemento que satisfaz a condição, sem percorrer o array inteiro.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'a',
  'Verdadeiro',
  '`some` interrompe a busca assim que encontra um elemento que satisfaz o teste, otimizando o caso em que a resposta é `true`.',
  false,
  277
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-core-javascript'),
  'semana-2-core-javascript-o-que-hoisting-faz-especificamente-com-declara-es-',
  'lesson',
  'open',
  'medium',
  'O que ''hoisting'' faz especificamente com declarações `function` tradicionais, diferente de funções em `const`?',
  null,
  null,
  'Declarações `function nome() {}` são içadas por completo (incluindo o corpo), podendo ser chamadas antes de aparecerem no código; funções atribuídas a `const`/`let` só têm a variável içada (não o valor), então não podem ser chamadas antes da atribuição.',
  'Essa diferença é uma fonte comum de confusão para quem está aprendendo escopo e hoisting em JavaScript.',
  false,
  278
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-hooks-avancados'),
  'semana-3-hooks-avancados-um-useeffect-sem-array-de-depend-ncias-roda-depois',
  'lesson',
  'true_false',
  'medium',
  'Um `useEffect` sem array de dependências roda depois de toda renderização do componente.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'a',
  'Verdadeiro',
  'Omitir o array de dependências (diferente de passar um array vazio) faz o efeito rodar a cada renderização, o que raramente é o comportamento desejado.',
  false,
  279
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-fundamentos-react'),
  'semana-3-fundamentos-react-um-componente-react-pode-retornar-m-ltiplos-elemen',
  'lesson',
  'true_false',
  'medium',
  'Um componente React pode retornar múltiplos elementos raiz sem precisar de um wrapper, usando Fragments (`<>...</>`).',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'a',
  'Verdadeiro',
  'Fragments permitem agrupar múltiplos elementos sem adicionar um nó extra desnecessário ao DOM, como uma `<div>` só para satisfazer a regra de um único elemento raiz.',
  false,
  280
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-um-usu-rio-reporta-que-o-app-perdeu-meus-dados-qua',
  'interview_cenarios',
  'open',
  'medium',
  'Um usuário reporta que ''o app perdeu meus dados quando fiquei sem internet''. Como você investigaria isso em um app com suporte offline?',
  null,
  null,
  'Verificar se a escrita local (IndexedDB) realmente aconteceu antes da fila de sincronização, se a fila processou corretamente ao voltar online, e se há algum caso de limpeza de dados locais (ex: logout) acontecendo indevidamente.',
  'Esse cenário conecta diretamente com a arquitetura offline-first estudada: escrita local otimista + fila de sincronização + isolamento por usuário.',
  true,
  281
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-um-dashboard-demora-muito-para-carregar-porque-faz',
  'interview_cenarios',
  'open',
  'medium',
  'Um dashboard demora muito para carregar porque faz 15 chamadas separadas ao backend ao abrir a tela. Como você melhoraria isso?',
  null,
  null,
  'Agrupando consultas relacionadas em menos chamadas (ex: um endpoint que retorna várias métricas de uma vez), usando `Promise.all` para paralelizar as que não podem ser agrupadas, e avaliando se algum dado pode ser cacheado.',
  'Esse é um problema real de performance de integração full stack: menos round-trips de rede geralmente significam carregamento mais rápido.',
  true,
  282
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-como-voc-lidaria-com-um-requisito-de-os-dados-deve',
  'interview_cenarios',
  'open',
  'hard',
  'Como você lidaria com um requisito de ''os dados devem aparecer em tempo real para todos os usuários conectados''?',
  null,
  null,
  'Considerar WebSockets ou Server-Sent Events para push de atualizações em tempo real, em vez de polling constante; avaliar o volume de usuários simultâneos para dimensionar a infraestrutura necessária.',
  'Tempo real muda fundamentalmente a arquitetura de comunicação cliente-servidor — de request/response tradicional para conexões persistentes.',
  true,
  283
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-este-endpoint-fastapi-insere-uma-revis-o-sem-valid',
  'interview_cenarios',
  'code',
  'hard',
  'Este endpoint FastAPI insere uma revisão sem validar o dono do content_id relacionado. Qual o risco, e como corrigir?
```python
@router.post("/reviews")
async def criar_revisao(review: ReviewCreate, user = Depends(get_current_user)):
    return await db.reviews.insert(review.dict())
```',
  null,
  null,
  'O risco é menor se o RLS do banco já impedir inserção com `user_id` de outra pessoa, mas o código deveria explicitamente atribuir `user_id = user.id` (nunca confiar em um valor vindo do corpo da requisição) antes de inserir.',
  'Mesmo com RLS como camada de segurança, é boa prática o backend nunca aceitar `user_id` do cliente — sempre usar o usuário autenticado extraído da sessão.',
  true,
  284
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-docker'),
  'semana-4-docker-um-dockerignore-funciona-de-forma-parecida-com-um-',
  'lesson',
  'true_false',
  'medium',
  'Um `.dockerignore` funciona de forma parecida com um `.gitignore`, evitando copiar arquivos desnecessários para dentro da imagem.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'a',
  'Verdadeiro',
  'Isso evita copiar coisas como `node_modules` ou arquivos de configuração local para dentro da imagem, mantendo-a menor e o build mais rápido.',
  false,
  285
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-kubernetes-observabilidade'),
  'semana-4-kubernetes-observabilidade-se-um-pod-est-consumindo-mais-mem-ria-do-que-o-lim',
  'lesson',
  'multiple_choice',
  'medium',
  'Se um Pod está consumindo mais memória do que o limite configurado, o Kubernetes normalmente:',
  '[{"id": "a", "text": "Ignora o limite e deixa continuar"}, {"id": "b", "text": "Encerra (OOMKilled) e reinicia o Pod"}, {"id": "c", "text": "Aumenta automaticamente o limite"}, {"id": "d", "text": "Pausa o cluster inteiro"}]'::jsonb,
  'b',
  'Encerra (OOMKilled) e reinicia o Pod',
  'Isso é conhecido como ''OOMKilled'' (Out Of Memory Killed) — o Kubernetes protege o node encerrando o Pod que excede seu limite de memória.',
  false,
  286
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-html5-acessibilidade'),
  'semana-2-html5-acessibilidade-qual-atributo-html-fornece-um-texto-alternativo-pa',
  'lesson',
  'multiple_choice',
  'medium',
  'Qual atributo HTML fornece um texto alternativo para imagens, essencial para acessibilidade?',
  '[{"id": "a", "text": "title"}, {"id": "b", "text": "alt"}, {"id": "c", "text": "src"}, {"id": "d", "text": "data-label"}]'::jsonb,
  'b',
  'alt',
  'O atributo `alt` é lido por leitores de tela e exibido caso a imagem não carregue — essencial para acessibilidade e SEO.',
  false,
  287
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-css3-layouts'),
  'semana-2-css3-layouts-qual-das-op-es-altera-o-comportamento-de-layout-de',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual das opções altera o comportamento de layout de um elemento entre bloco, inline e flex?',
  '[{"id": "a", "text": "color"}, {"id": "b", "text": "display"}, {"id": "c", "text": "font-size"}, {"id": "d", "text": "text-align"}]'::jsonb,
  'b',
  'display',
  'A propriedade `display` define o modelo de layout do elemento — `block`, `inline`, `flex`, `grid`, entre outros.',
  false,
  288
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-core-python-poo'),
  'semana-1-core-python-poo-qual-pilar-da-poo-se-refere-a-esconder-detalhes-in',
  'lesson',
  'multiple_choice',
  'medium',
  'Qual pilar da POO se refere a esconder detalhes internos de implementação, expondo só o necessário?',
  '[{"id": "a", "text": "Herança"}, {"id": "b", "text": "Polimorfismo"}, {"id": "c", "text": "Encapsulamento"}, {"id": "d", "text": "Abstração"}]'::jsonb,
  'c',
  'Encapsulamento',
  'Encapsulamento protege o estado interno de um objeto, expondo apenas a interface necessária para interagir com ele.',
  false,
  289
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-assincronismo-fastapi'),
  'semana-1-assincronismo-fastapi-qual-biblioteca-o-fastapi-usa-para-valida-o-de-dad',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual biblioteca o FastAPI usa para validação de dados baseada em type hints do Python?',
  '[{"id": "a", "text": "Marshmallow"}, {"id": "b", "text": "Pydantic"}, {"id": "c", "text": "Cerberus"}, {"id": "d", "text": "WTForms"}]'::jsonb,
  'b',
  'Pydantic',
  'Pydantic usa as anotações de tipo do Python para validar e serializar dados automaticamente.',
  false,
  290
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-typescript'),
  'semana-3-typescript-o-que-intersection-types-a-b-fazem-em-typescript',
  'lesson',
  'multiple_choice',
  'easy',
  'O que `Intersection Types` (`A & B`) fazem em TypeScript?',
  '[{"id": "a", "text": "Escolhem entre A ou B"}, {"id": "b", "text": "Combinam A e B em um único tipo com as propriedades de ambos"}, {"id": "c", "text": "Removem propriedades em comum"}, {"id": "d", "text": "Não existe esse conceito"}]'::jsonb,
  'b',
  'Combinam A e B em um único tipo com as propriedades de ambos',
  'Diferente de union (`|`, que significa ''ou''), intersection (`&`) significa ''e'' — o tipo resultante precisa satisfazer ambos simultaneamente.',
  false,
  291
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-projetos-portfolio'),
  'semana-5-projetos-portfolio-ao-falar-sobre-um-projeto-de-portf-lio-em-entrevis',
  'lesson',
  'true_false',
  'medium',
  'Ao falar sobre um projeto de portfólio em entrevista, é aceitável afirmar tecnologias que o projeto não usa, se isso soar mais impressionante.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'Além de antiético, entrevistadores técnicos frequentemente fazem perguntas de aprofundamento que expõem inconsistências quando algo é inventado.',
  false,
  292
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-persistencia-sqlalchemy'),
  'semana-1-persistencia-sqlalchemy-em-sqlalchemy-o-que-mapped-column-primary-key-true',
  'lesson',
  'multiple_choice',
  'easy',
  'Em SQLAlchemy, o que `mapped_column(primary_key=True)` indica?',
  '[{"id": "a", "text": "Que a coluna é opcional"}, {"id": "b", "text": "Que a coluna é a chave primária da tabela"}, {"id": "c", "text": "Que a coluna é um índice secundário"}, {"id": "d", "text": "Que a coluna é criptografada"}]'::jsonb,
  'b',
  'Que a coluna é a chave primária da tabela',
  'A chave primária identifica unicamente cada linha da tabela.',
  false,
  293
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-tailwind-responsividade'),
  'semana-2-tailwind-responsividade-no-tailwind-o-breakpoint-sm-aplica-estilos-para-te',
  'lesson',
  'true_false',
  'easy',
  'No Tailwind, o breakpoint `sm:` aplica estilos para telas MENORES que o definido.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'Breakpoints no Tailwind são ''min-width'' por padrão: `sm:` aplica a partir daquele tamanho de tela PARA CIMA, não para baixo.',
  false,
  294
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-arquitetura-apis'),
  'semana-4-arquitetura-apis-qual-verbo-http-usado-para-remover-um-recurso',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual verbo HTTP é usado para REMOVER um recurso?',
  '[{"id": "a", "text": "GET"}, {"id": "b", "text": "POST"}, {"id": "c", "text": "DELETE"}, {"id": "d", "text": "HEAD"}]'::jsonb,
  'c',
  'DELETE',
  'DELETE é o verbo convencional em REST para remoção de um recurso identificado pela URL.',
  false,
  295
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-que-list-comprehension-em-python-como-x-2-for-x-',
  'interview_python',
  'multiple_choice',
  'easy',
  'O que `list comprehension` em Python, como `[x*2 for x in range(5)]`, produz?',
  '[{"id": "a", "text": "Um gerador"}, {"id": "b", "text": "Uma nova lista com os valores transformados"}, {"id": "c", "text": "Um erro de sintaxe"}, {"id": "d", "text": "Um dicionário"}]'::jsonb,
  'b',
  'Uma nova lista com os valores transformados',
  'List comprehensions são uma forma concisa de criar listas aplicando uma transformação (e opcionalmente um filtro) a um iterável.',
  true,
  296
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-qual-hook-usado-para-guardar-uma-refer-ncia-mut-ve',
  'interview_react',
  'multiple_choice',
  'easy',
  'Qual hook é usado para guardar uma referência mutável que não causa re-renderização quando alterada?',
  '[{"id": "a", "text": "useState"}, {"id": "b", "text": "useRef"}, {"id": "c", "text": "useMemo"}, {"id": "d", "text": "useReducer"}]'::jsonb,
  'b',
  'useRef',
  '`useRef` mantém um valor mutável entre renderizações sem disparar uma nova renderização quando ele muda — útil para referências a elementos DOM ou valores que não afetam a UI diretamente.',
  true,
  297
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-docker'),
  'semana-4-docker-qual-a-diferen-a-entre-cmd-e-entrypoint-em-um-dock',
  'lesson',
  'open',
  'medium',
  'Qual a diferença entre `CMD` e `ENTRYPOINT` em um Dockerfile?',
  null,
  null,
  '`CMD` define o comando padrão, facilmente sobrescrito ao rodar o container com outro comando; `ENTRYPOINT` é pensado para não ser sobrescrito facilmente, geralmente combinado com `CMD` para fornecer argumentos padrão.',
  'Uma combinação comum é usar `ENTRYPOINT` para o executável fixo e `CMD` para argumentos padrão que podem ser substituídos.',
  false,
  298
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-por-que-separar-um-componente-de-apresenta-o-visua',
  'interview_react',
  'open',
  'medium',
  'Por que separar um componente de apresentação (visual) de um componente ''container'' (lógica de dados) pode facilitar testes e reuso?',
  null,
  null,
  'Porque o componente visual fica puro (recebe dados via props e apenas renderiza), podendo ser testado e reutilizado independentemente de como os dados são buscados, enquanto o container cuida só da lógica de obtenção de dados.',
  'Esse padrão facilita testar a UI isoladamente (sem precisar mockar chamadas de API) e reaproveitar o mesmo visual com fontes de dados diferentes.',
  true,
  299
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-core-python-poo'),
  'semana-1-core-python-poo-uma-classe-filha-pode-sobrescrever-um-m-todo-herda',
  'lesson',
  'true_false',
  'easy',
  'Uma classe filha pode sobrescrever um método herdado da classe pai.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'a',
  'Verdadeiro',
  'Isso é chamado de ''override'' — a subclasse fornece sua própria implementação de um método já definido na superclasse.',
  false,
  300
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-javascript-assincrono'),
  'semana-2-javascript-assincrono-qual-m-todo-de-array-retorna-o-primeiro-elemento-q',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual método de array retorna o PRIMEIRO elemento que satisfaz uma condição?',
  '[{"id": "a", "text": "filter"}, {"id": "b", "text": "find"}, {"id": "c", "text": "map"}, {"id": "d", "text": "reduce"}]'::jsonb,
  'b',
  'find',
  '`find` retorna o primeiro elemento correspondente (ou `undefined` se nenhum for encontrado), diferente de `filter`, que retorna todos os que correspondem.',
  false,
  301
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-fundamentos-react'),
  'semana-3-fundamentos-react-um-componente-funcional-em-react-simplesmente-uma-',
  'lesson',
  'true_false',
  'easy',
  'Um componente funcional em React é simplesmente uma função JavaScript que retorna JSX.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'a',
  'Verdadeiro',
  'Componentes funcionais são funções que recebem props e retornam a descrição da UI em JSX.',
  false,
  302
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-4-arquitetura-apis'),
  'semana-4-arquitetura-apis-qual-a-diferen-a-entre-um-erro-401-e-um-erro-403',
  'lesson',
  'open',
  'medium',
  'Qual a diferença entre um erro 401 e um erro 403?',
  null,
  null,
  '401 Unauthorized indica que a pessoa não está autenticada (ou as credenciais são inválidas); 403 Forbidden indica que está autenticada, mas não tem permissão para aquele recurso específico.',
  'Confundir os dois é comum, mas a distinção entre ''quem você é'' (401) e ''o que você pode fazer'' (403) é importante para APIs bem projetadas.',
  false,
  303
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-testes-pytest'),
  'semana-1-testes-pytest-o-que-o-testclient-do-fastapi-permite-fazer-nos-te',
  'lesson',
  'multiple_choice',
  'easy',
  'O que o `TestClient` do FastAPI permite fazer nos testes?',
  '[{"id": "a", "text": "Simular requisições HTTP à API sem precisar de um servidor rodando de verdade"}, {"id": "b", "text": "Gerar dados fake automaticamente"}, {"id": "c", "text": "Substituir o banco de dados"}, {"id": "d", "text": "Compilar o código mais rápido"}]'::jsonb,
  'a',
  'Simular requisições HTTP à API sem precisar de um servidor rodando de verdade',
  'O TestClient permite testar rotas da aplicação diretamente em memória, sem precisar subir um servidor real durante os testes.',
  false,
  304
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  null,
  'interview-o-que-significa-uma-mensagem-de-commit-boa-e-por-q',
  'interview_git',
  'open',
  'medium',
  'O que significa uma mensagem de commit ''boa'', e por que isso importa para o time?',
  null,
  null,
  'Uma boa mensagem descreve claramente o que mudou e por quê, de forma concisa; isso ajuda o time a entender o histórico do projeto sem precisar abrir cada diff para entender a intenção da mudança.',
  'Mensagens vagas como ''fix'' ou ''ajustes'' dificultam muito a investigação de bugs e o entendimento do histórico do projeto no futuro.',
  true,
  305
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-1-mensageria-cache'),
  'semana-1-mensageria-cache-o-que-idempot-ncia-no-contexto-de-processamento-de',
  'lesson',
  'open',
  'hard',
  'O que é idempotência, no contexto de processamento de mensagens/eventos, e por que ela é importante?',
  null,
  null,
  'É a propriedade de uma operação poder ser executada múltiplas vezes com o mesmo resultado final, sem efeitos colaterais duplicados; importante porque filas podem, em certos cenários, entregar a mesma mensagem mais de uma vez.',
  'Sem idempotência, reprocessar uma mensagem (ex: um pagamento) por engano poderia causar duplicação indevida do efeito (cobrar duas vezes, por exemplo).',
  false,
  306
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-3-hooks-avancados'),
  'semana-3-hooks-avancados-qual-hook-o-mais-b-sico-para-declarar-estado-local',
  'lesson',
  'multiple_choice',
  'easy',
  'Qual hook é o mais básico para declarar estado local em um componente funcional?',
  '[{"id": "a", "text": "useEffect"}, {"id": "b", "text": "useState"}, {"id": "c", "text": "useContext"}, {"id": "d", "text": "useReducer"}]'::jsonb,
  'b',
  'useState',
  '`useState` é o hook fundamental para adicionar estado local a um componente funcional, retornando o valor atual e uma função para atualizá-lo.',
  false,
  307
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-2-css3-layouts'),
  'semana-2-css3-layouts-o-que-especificidade-significa-em-css-e-como-ela-c',
  'lesson',
  'open',
  'medium',
  'O que ''especificidade'' significa em CSS, e como ela é calculada de forma simplificada?',
  null,
  null,
  'É o critério que decide qual regra CSS ''vence'' quando várias se aplicam ao mesmo elemento; de forma simplificada, um ID pesa mais que uma classe, que pesa mais que um seletor de elemento.',
  'Entender especificidade evita a armadilha de usar `!important` para ''forçar'' estilos, que só mascara o problema real de organização do CSS.',
  false,
  308
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();

insert into public.official_questions
  (content_id, question_key, category, question_type, difficulty, question, options, correct_option, answer, explanation, is_interview_question, order_index)
values (
  (select id from public.study_contents where slug = 'semana-5-system-design'),
  'semana-5-system-design-adicionar-um-ndice-em-uma-coluna-sempre-acelera-to',
  'lesson',
  'true_false',
  'medium',
  'Adicionar um índice em uma coluna sempre acelera TODAS as operações naquela tabela.',
  '[{"id": "a", "text": "Verdadeiro"}, {"id": "b", "text": "Falso"}]'::jsonb,
  'b',
  'Falso',
  'Índices aceleram buscas (SELECT) que usam aquela coluna, mas tornam escritas (INSERT/UPDATE/DELETE) levemente mais lentas, pois o índice também precisa ser atualizado.',
  false,
  309
)
on conflict (question_key) do update set
  category = excluded.category,
  question_type = excluded.question_type,
  difficulty = excluded.difficulty,
  question = excluded.question,
  options = excluded.options,
  correct_option = excluded.correct_option,
  answer = excluded.answer,
  explanation = excluded.explanation,
  is_interview_question = excluded.is_interview_question,
  updated_at = now();
