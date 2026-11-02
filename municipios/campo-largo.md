# campo-largo

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `campo-largo/campo-largo-api` e `campo-largo/campo-largo-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.2`, Laravel `^11.0`, Sanctum `^4.0`. Faixas declaradas, não versões instaladas.
- Testes API: PHPUnit. Web: sem script `test:unit`.
- Migrations: carrega um nível de subpastas em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `cp-**`; Web `cp-**-**`. Push correspondente aciona workflow.

## Particularidades

Censo Escolar com Actions, Strategies e Observers; aspectos da criança. Possui GestaoDeAulaDetalhadaResource fora do Mobile. Os padrões de branch de dev diferem entre API (cp-**) e Web (cp-**-**).

## Ferramentas e cuidados específicos

- API: `captainhook.json` configura pre-commit com lint PHP, `git pull origin main` e Pint no preset PSR-12, sem `--dirty`. Confira se o hook está instalado antes de um commit: ele pode atualizar o checkout e formatar arquivos fora da tarefa.

## Referências no código

- API: `app/Actions/CensoEscolar/ExcluirRespostasModuloAction.php`.
- API: `app/Actions/CensoEscolar/SalvarRespostasModuloAction.php`.
- API: `app/Actions/CensoEscolar/ShowCensoEtapaAction.php`.
- API: `app/Actions/CensoEscolar/ValidarEtapaCensoAction.php`.
- Web: `src/Services/CensoService.js`.
- Web: `src/router/censo-escolar.js`.

Base da análise: 27/10/2026, API `3dbfe41`, Web `492a053`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
