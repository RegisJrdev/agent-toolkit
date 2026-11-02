# cajueiro-da-praia

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `cajueiro-da-praia/cajueiro-da-praia-api` e `cajueiro-da-praia/cajueiro-da-praia-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.2`, Laravel `^10.35`, Sanctum `^3.2`. Faixas declaradas, não versões instaladas.
- Testes API: PHPUnit. Web: sem script `test:unit`.
- Migrations: sem loader de subpastas ativo localizado em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `pmcp/**`; Web `pmcp/**`. Push correspondente aciona workflow.

## Particularidades

Permissões com PermissionsSeeder/RolesSeeder, sem JSON em public/permissions. vue-infinite-loading é usado por EInfiniteLoading. Scout e Discord Logger declarados. SQLite comentado em phpunit.xml. Há uso de FPDI em BoletinsService sem declaração direta correspondente no composer.json: validar dependência efetiva antes de usar.

Permissões: ler `database/seeders/PermissionsSeeder.php` e `RolesSeeder.php`; não aplicar automaticamente o procedimento de JSON/RoleSeeder dos outros municípios.

## Ferramentas e cuidados específicos

- API: Pint não está declarado no `composer.json`; não presuma disponibilidade de `vendor/bin/pint`.
- API: `database/seeders/DatabaseSeeder.php` tem `run()` vazio. O `--seed` do deploy não chama automaticamente `PermissionsSeeder`/`RolesSeeder`; confira o procedimento de aplicação das permissões.
- Web: o reducer de `createPersistedState` em `src/store/index.js` exclui `Autorizacoes` e `Professores` da persistência.

## Referências no código


- Web: `src/Services/PlanosBimestraisService.js`.
- Web: `src/router/guards/redirecionarSeForColaborador.js`.

Base da análise: 27/10/2026, API `cb54120`, Web `9b6e8a8`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
