# guaribas

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `guaribas/guaribas-api` e `guaribas/guaribas-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.3`, Laravel `^12.0`, Sanctum `^4.0`. Faixas declaradas, não versões instaladas.
- Testes API: Pest declarado, com `tests/Pest.php` e testes em sintaxe Pest; confirmar instalação e execução. Web: sem script `test:unit`.
- Migrations: carrega um nível de subpastas em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `guaribas-**`; Web `guaribas-**`. Push correspondente aciona workflow.

## Particularidades

Planejamento semestral/infantil, semestres, profissionais de apoio, solicitações de deleção e carteirinha. LaTeX/LaraTeX usado em Notifiq/CarteirinhaController; exige investigar binários externos para renderização. qrcode.vue declarado na Web. Snappy resolve binários por WKHTML_PDF_BINARY/WKHTML_IMG_BINARY.

## Ferramentas e cuidados específicos

- API: Pest `^3.8` declarado e `tests/Pest.php` presente, vinculando `Tests\TestCase` e `RefreshDatabase` aos testes Feature. `tests/TestCase.php` ativa seed; `phpunit.xml` configura SQLite em memória. Isso não comprova execução bem-sucedida.
- API: `captainhook.json` configura pre-commit com `git pull origin main`, `pest --coverage --min=3.0` e Pint no preset PSR-12, sem `--dirty`. Confira instalação do hook, driver de cobertura e efeitos sobre o checkout antes de um commit.
- API: `config/laratex.php` usa `LARATEX_PATH`, com padrão `pdflatex`; confira o executável no ambiente de renderização.
- Web: o reducer de `createPersistedState` em `src/store/index.js` exclui `Etapas` e `Turmas` da persistência.

## Referências no código

- API: `routes/notifiq/carteirinha.php`.
- API: `routes/notifiq/frequencia.php`.
- API: `routes/notifiqProfessor/configuracao.php`.
- API: `routes/planosSemestrais.php`.
- Web: `src/Services/CarteirinhaService.js`.
- Web: `src/Services/ProfissionaisDeApoioService.js`.

Base da análise: 27/10/2026, API `f041ef8`, Web `e5ca007`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
