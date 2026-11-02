# luis-correia

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `luis-correia/luis-correia-api` e `luis-correia/luis-correia-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.3`, Laravel `^12.0`, Sanctum `^4.0`. Faixas declaradas, não versões instaladas.
- Testes API: Pest declarado; confirmar configuração e instalação. Web: sem script `test:unit`.
- Migrations: sem loader de subpastas ativo localizado em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `pmlc/**`; Web `pmlc/**`. Push correspondente aciona workflow.

## Particularidades

Busca Ativa, Sala de Situação, PEI, atendimentos auxiliares e variantes de planejamento anual/infantil/AEE. Usa API Resources no domínio BuscaAtiva. PermissionsSeeder/RolesSeeder diferem da família PermissionSeeder/RoleSeeder. config/snappy.php fixa /usr/local/bin/wkhtmltopdf; não pressupor binário de Composer.

Permissões: ler `database/seeders/PermissionsSeeder.php` e `RolesSeeder.php`; não aplicar automaticamente o procedimento de JSON/RoleSeeder dos outros municípios.

## Ferramentas e cuidados específicos

- API: Pest `^3.0` e PHPUnit `^11.5` declarados, sem `tests/Pest.php` nem testes em sintaxe Pest encontrados no checkout. `phpunit.xml` configura SQLite em memória; não trate a declaração de Pest como migração da suíte.
- API: Pint não está declarado no `composer.json`; não presuma disponibilidade de `vendor/bin/pint`.
- Web: o reducer de `createPersistedState` em `src/store/index.js` exclui `Franquias` da persistência.

## Referências no código

- API: `routes/atendimentosAuxiliares.php`.
- API: `routes/buscaAtiva.php`.
- API: `routes/condicoes.php`.
- API: `routes/peis.php`.
- Web: `src/Services/AtendimentosAuxiliaresService.js`.
- Web: `src/Services/BuscaAtivaService.js`.

Base da análise: 27/10/2026, API `1049df9`, Web `2300e6c`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
