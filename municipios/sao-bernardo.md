# sao-bernardo

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `sao-bernardo/sao-bernardo-api` e `sao-bernardo/sao-bernardo-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.2`, Laravel `^11.0`, Sanctum `^4.0`. Faixas declaradas, não versões instaladas.
- Testes API: PHPUnit. Web: sem script `test:unit`.
- Migrations: sem loader de subpastas ativo localizado em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `pmsb/**`; Web `pmsb/**`. Push correspondente aciona workflow.

## Particularidades

Gestões, aulas e ementas de eletivos. Scout e Discord Logger declarados; PermissionsSeeder/RolesSeeder sem JSON de permissões. SQLite comentado. composer.lock fixa Laravel v11.51.0/Sanctum v4.3.1. Há migration em database/migrations/database/migrations: validar carregamento e origem.

Permissões: ler `database/seeders/PermissionsSeeder.php` e `RolesSeeder.php`; não aplicar automaticamente o procedimento de JSON/RoleSeeder dos outros municípios.

## Ferramentas e cuidados específicos

- API: Pint não está declarado no `composer.json`; não presuma disponibilidade de `vendor/bin/pint`.
- API: `database/seeders/DatabaseSeeder.php` chama somente `PedidosSeeder`. O `--seed` do deploy não chama automaticamente `PermissionsSeeder`/`RolesSeeder`; confira o procedimento de aplicação das permissões.
- Web: `createPersistedState()` está comentado em `src/store/index.js`; o plugin de persistência do Vuex está desativado. Isso não significa ausência de outros usos de localStorage.
- Web: em `src/plugins/Axios.js`, o tratamento de 403 redireciona professor para `acessoProfessor.home`; preserve esse comportamento ao alterar o interceptor.
- Web: `src/Services/AvisosService copy.js` existe, mas não foi encontrado import dela em `src`. O registro em `src/Services/index.js` usa `AvisosService.js`.

## Referências no código

- API: `routes/aulasEletivas.php`.
- API: `routes/ementas.php`.
- API: `routes/gestoesDeEletivos.php`.
- API: `routes/notifiqProfessor/configuracao.php`.
- Web: `src/Services/AulasEletivosService.js`.
- Web: `src/Services/AvisosService.js` (implementação registrada).

Base da análise: 27/10/2026, API `f8e37c5`, Web `589ffb0`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
