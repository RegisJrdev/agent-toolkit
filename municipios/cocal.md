# cocal

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `cocal/cocal-api` e `cocal/cocal-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.1`, Laravel `^10.0`, Sanctum `^3.2`. Faixas declaradas, não versões instaladas.
- Testes API: PHPUnit. Web: sem script `test:unit`.
- Migrations: sem loader de subpastas ativo localizado em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `cocal-**`; Web `cocal-**`. Push correspondente aciona workflow.

## Particularidades

Profissionais de apoio e appConfigurations. Mantém estrutura próxima de Morro Cabeça no Tempo, mas os helpers, seeders e módulos não são idênticos; não reutilizar perfil sem conferir.

## Referências no código

- API: `routes/appConfigurations.php`.
- API: `routes/profissionaisDeApoio.php`.
- Web: `src/Services/ProfissionaisDeApoioService.js`.
- Web: `src/router/profissionaisDeApoio.js`.

Base da análise: 27/10/2026, API `a49da5e`, Web `6d4dcb3`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
