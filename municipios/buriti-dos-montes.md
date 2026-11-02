# buriti-dos-montes

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `buriti-dos-montes/buriti-dos-montes-api` e `buriti-dos-montes/buriti-dos-montes-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.1`, Laravel `^10.0`, Sanctum `^3.2`. Faixas declaradas, não versões instaladas.
- Testes API: PHPUnit. Web: sem script `test:unit`.
- Migrations: carrega um nível de subpastas em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `bdm-**-**`; Web `bdm-**-**`. Push correspondente aciona workflow.

## Particularidades

Censo Escolar com Actions, Strategies e Observers; rotinas e migração de turmas/matrículas na Web. Exportação PDF no navegador usa html2canvas/jsPDF em src/components/Turmas/Line.vue. @quasar/cli está declarado, mas os scripts de aplicação continuam no Vue CLI; não caracteriza migração para Quasar.

## Ferramentas e cuidados específicos

- API: `captainhook.json` configura pre-commit com lint PHP e `php artisan test --colors`; isso não comprova hook instalado nem suíte operacional.

## Referências no código

- API: `app/Actions/CensoEscolar/ExcluirRespostasModuloAction.php`.
- API: `app/Actions/CensoEscolar/SalvarRespostasModuloAction.php`.
- API: `app/Actions/CensoEscolar/ShowCensoEtapaAction.php`.
- API: `app/Actions/CensoEscolar/ValidarEtapaCensoAction.php`.
- Web: `src/Services/CensoService.js`.
- Web: `src/Services/PlanosMensaisService.js`.

Base da análise: 27/10/2026, API `cdd1a91`, Web `3b47808`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
