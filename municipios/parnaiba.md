# parnaiba

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `parnaiba/parnaiba-api` e `parnaiba/parnaiba-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.2`, Laravel `^11.0`, Sanctum `^4.0`. Faixas declaradas, não versões instaladas.
- Testes API: PHPUnit. Web: `yarn test:unit` declarado.
- Migrations: carrega um nível de subpastas em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `parnaiba-**`; Web `parnaiba-**`. Push correspondente aciona workflow.

## Particularidades

Combina Censo Escolar, CAEE, descritores e habilidades. Actions de Censo incluem salvamento em lote. iio/libmergepdf é usado em RelatoriosController. Possui guard apenasAdminCenso distinto dos demais municípios com Censo.

## Ferramentas e cuidados específicos

- Web: `src/router/censo-escolar.js` usa `src/router/guards/apenasAdminCenso.js`, que permite somente `super-admin` no checkout, apesar do comentário mencionar admin.

## Referências no código

- API: `app/Actions/CensoEscolar/SalvarLoteRespostasAction.php`.
- API: `app/Actions/CensoEscolar/SalvarRespostasModuloAction.php`.
- API: `app/Actions/CensoEscolar/ShowCensoEtapaAction.php`.
- API: `app/Actions/CensoEscolar/ValidarEtapaCensoAction.php`.
- Web: `src/Services/CensoService.js`.
- Web: `src/Services/CodigosHabilidadesService.js`.

Base da análise: 27/10/2026, API `dcbce43`, Web `d0bc4b5`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
