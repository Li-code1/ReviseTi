import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { Sparkles, PlayCircle, Code2, LayoutGrid, Database, GitBranch, Users, Briefcase, Shield, CheckSquare } from "lucide-react";

const CATEGORIES = [
  { key: "interview_python", label: "Python", icon: Code2 },
  { key: "interview_react", label: "React", icon: LayoutGrid },
  { key: "interview_api", label: "APIs / Backend", icon: GitBranch },
  { key: "interview_db", label: "Banco de Dados", icon: Database },
  { key: "interview_git", label: "Git", icon: GitBranch },
  { key: "interview_seguranca", label: "Segurança", icon: Shield },
  { key: "interview_comportamental", label: "Comportamental", icon: Users },
  { key: "interview_projeto_pokefast", label: "Projeto: PokeFast API", icon: Briefcase },
  { key: "interview_projeto_smartfinance", label: "Projeto: SmartFinance", icon: Briefcase },
  { key: "interview_arquitetura", label: "Arquitetura", icon: LayoutGrid },
];

const CHECKLIST_ITEMS = [
  "Consigo me apresentar em 1-2 minutos",
  "Consigo explicar meu projeto principal",
  "Consigo explicar minha arquitetura",
  "Consigo explicar minhas escolhas técnicas",
  "Consigo falar sobre desafios que enfrentei",
  "Consigo explicar conceitos de Python",
  "Consigo explicar conceitos de React",
  "Consigo explicar APIs e HTTP",
  "Consigo explicar banco de dados e SQL",
  "Consigo falar sobre testes",
  "Consigo falar sobre Git",
  "Consigo responder perguntas comportamentais com o método STAR",
];

const PRESENTATION_TEMPLATE = `Olá, meu nome é [SEU NOME]. Sou desenvolvedor(a) Full Stack com foco em Python no backend e React no frontend. Tenho interesse em desenvolvimento de aplicações web, APIs, integração entre frontend e backend e construção de soluções escaláveis. Durante minha preparação, desenvolvi projetos como [NOME DO PROJETO], trabalhando com [TECNOLOGIAS]. Um dos desafios que enfrentei foi [DESAFIO], que resolvi utilizando [SOLUÇÃO]. Neste momento, busco uma oportunidade na qual possa aplicar meus conhecimentos e continuar evoluindo como desenvolvedor(a).`;

interface PresentationFields {
  nome: string;
  experiencia: string;
  tecnologias: string;
  projeto: string;
  desafio: string;
  solucao: string;
  objetivo: string;
}

const EMPTY_FIELDS: PresentationFields = { nome: "", experiencia: "", tecnologias: "", projeto: "", desafio: "", solucao: "", objetivo: "" };
const STORAGE_KEY_FIELDS = "reviseti:interview:presentation";
const STORAGE_KEY_CHECKLIST = "reviseti:interview:checklist";

export default function Interview() {
  const [fields, setFields] = useState<PresentationFields>(EMPTY_FIELDS);
  const [checked, setChecked] = useState<Record<number, boolean>>({});

  useEffect(() => {
    try {
      const savedFields = localStorage.getItem(STORAGE_KEY_FIELDS);
      if (savedFields) setFields(JSON.parse(savedFields));
      const savedChecklist = localStorage.getItem(STORAGE_KEY_CHECKLIST);
      if (savedChecklist) setChecked(JSON.parse(savedChecklist));
    } catch {
      /* localStorage indisponível — segue com os padrões */
    }
  }, []);

  function updateField(key: keyof PresentationFields, value: string) {
    const next = { ...fields, [key]: value };
    setFields(next);
    localStorage.setItem(STORAGE_KEY_FIELDS, JSON.stringify(next));
  }

  function toggleChecklist(i: number) {
    const next = { ...checked, [i]: !checked[i] };
    setChecked(next);
    localStorage.setItem(STORAGE_KEY_CHECKLIST, JSON.stringify(next));
  }

  const personalized = PRESENTATION_TEMPLATE
    .replace("[SEU NOME]", fields.nome || "[SEU NOME]")
    .replace("[NOME DO PROJETO]", fields.projeto || "[NOME DO PROJETO]")
    .replace("[TECNOLOGIAS]", fields.tecnologias || "[TECNOLOGIAS]")
    .replace("[DESAFIO]", fields.desafio || "[DESAFIO]")
    .replace("[SOLUÇÃO]", fields.solucao || "[SOLUÇÃO]");

  const checkedCount = Object.values(checked).filter(Boolean).length;

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Preparação para entrevista</h1>
        <p className="mt-1 text-slate-500 dark:text-slate-400">
          Trilha: Desenvolvedor(a) Full Stack Python + React — foco em backend Python, APIs, banco de dados, frontend React e integração entre eles.
        </p>
      </div>

      <div className="card bg-brand-50 dark:bg-brand-900/20">
        <div className="flex items-start gap-3">
          <Sparkles className="mt-0.5 h-5 w-5 flex-shrink-0 text-brand-600 dark:text-brand-400" />
          <div>
            <p className="font-semibold">Simular entrevista</p>
            <p className="mt-1 text-sm text-slate-600 dark:text-slate-300">
              Perguntas técnicas, comportamentais e sobre os projetos-exemplo, em ordem aleatória.
            </p>
            <Link to="/study/category/interview" className="btn-primary mt-3 inline-flex">
              <PlayCircle className="h-4 w-4" /> Começar simulado
            </Link>
          </div>
        </div>
      </div>

      <section className="card">
        <h2 className="mb-1 text-lg font-semibold">Fale sobre você</h2>
        <p className="mb-4 text-sm text-slate-500 dark:text-slate-400">
          Use o modelo como referência. Adapte para sua experiência real — não decore, entenda a estrutura.
        </p>
        <div className="grid gap-3 sm:grid-cols-2">
          <input placeholder="Seu nome" value={fields.nome} onChange={(e) => updateField("nome", e.target.value)} className="input-field" />
          <input placeholder="Tecnologias (ex: Python, React, FastAPI)" value={fields.tecnologias} onChange={(e) => updateField("tecnologias", e.target.value)} className="input-field" />
          <input placeholder="Projeto principal" value={fields.projeto} onChange={(e) => updateField("projeto", e.target.value)} className="input-field" />
          <input placeholder="Objetivo profissional" value={fields.objetivo} onChange={(e) => updateField("objetivo", e.target.value)} className="input-field" />
          <input placeholder="Um desafio que você enfrentou" value={fields.desafio} onChange={(e) => updateField("desafio", e.target.value)} className="input-field sm:col-span-2" />
          <input placeholder="Como você resolveu esse desafio" value={fields.solucao} onChange={(e) => updateField("solucao", e.target.value)} className="input-field sm:col-span-2" />
        </div>
        <div className="mt-4 rounded-xl bg-slate-50 p-4 text-sm text-slate-700 dark:bg-slate-800 dark:text-slate-300">
          {personalized}
        </div>
      </section>

      <section>
        <h2 className="mb-3 text-lg font-semibold">Perguntas por tema</h2>
        <div className="grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-5">
          {CATEGORIES.map(({ key, label, icon: Icon }) => (
            <Link key={key} to={`/study/category/${key}`} className="card flex flex-col items-center gap-2 py-4 text-center transition hover:border-brand-300">
              <Icon className="h-5 w-5 text-brand-600 dark:text-brand-400" />
              <span className="text-sm font-medium">{label}</span>
            </Link>
          ))}
        </div>
      </section>

      <section className="card">
        <div className="mb-3 flex items-center justify-between">
          <h2 className="flex items-center gap-2 text-lg font-semibold">
            <CheckSquare className="h-5 w-5" /> Checklist pré-entrevista
          </h2>
          <span className="text-sm text-slate-500 dark:text-slate-400">{checkedCount}/{CHECKLIST_ITEMS.length}</span>
        </div>
        <div className="space-y-2">
          {CHECKLIST_ITEMS.map((item, i) => (
            <label key={i} className="flex cursor-pointer items-center gap-3 rounded-lg px-2 py-1.5 hover:bg-slate-50 dark:hover:bg-slate-800">
              <input type="checkbox" checked={!!checked[i]} onChange={() => toggleChecklist(i)} className="h-4 w-4 rounded border-slate-300 text-brand-600" />
              <span className={checked[i] ? "text-slate-400 line-through" : ""}>{item}</span>
            </label>
          ))}
        </div>
      </section>

      <p className="text-center text-xs text-slate-400">
        As respostas modelo sobre os projetos PokeFast API e SmartFinance são didáticas — adapte-as apenas com informações reais sobre o que você de fato construiu.
      </p>
    </div>
  );
}
