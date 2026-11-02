# brasileira

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `brasileira/brasileira-api` e `brasileira/brasileira-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.1`, Laravel `^10.0`, Sanctum `^3.2`. Faixas declaradas, não versões instaladas.
- Testes API: PHPUnit. Web: sem script `test:unit`.
- Migrations: carrega um nível de subpastas em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `brasileira-**`; Web `brasileira-**`. Push correspondente aciona workflow.

## Particularidades

Pré-matrículas públicas, acompanhamento bimestral/consolidado e rota própria de Fundeb. ObserverServiceProvider exclusivo neste conjunto. PDF com FPDF/FPDI e integração Laravel Firebase declarados.

## Ferramentas e cuidados específicos

- API: `captainhook.json` configura pre-commit com `git pull origin main` e Pint no preset PSR-12, sem `--dirty`. Confira se o hook está instalado antes de um commit: ele pode atualizar o checkout e formatar arquivos fora da tarefa.
- Web: o reducer de `createPersistedState` em `src/store/index.js` exclui `Professores` e `Autorizacoes` da persistência.

## Referências no código

- API: `routes/abertura-prematriculas-public.php`.
- API: `routes/abertura-prematriculas.php`.
- API: `routes/acompanhamentosAnaliseConsolidado.php`.
- API: `routes/acompanhamentosBimestrais.php`.
- Web: `src/Services/AberturaPreMatriculasService.js`.
- Web: `src/Services/AcompanhamentosService.js`.

Base da análise: 27/10/2026, API `52f33a51`, Web `fe79661`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
