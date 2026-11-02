# novo-oriente

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `novo-oriente/novo-oriente-api` e `novo-oriente/novo-oriente-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.1`, Laravel `^10.0`, Sanctum `^3.2`. Faixas declaradas, não versões instaladas.
- Testes API: PHPUnit. Web: sem script `test:unit`.
- Migrations: carrega um nível de subpastas em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `novooriente-**`; Web `novooriente-**`. Push correspondente aciona workflow.

## Particularidades

Planejamento semanal infantil com rota e service próprios. Há uma cópia de CalendarioLetivoService.js em src/router/; a implementação registrada fica em src/Services/.

## Ferramentas e cuidados específicos

- Web: `src/Services/index.js` importa e registra `src/Services/CalendarioLetivoService.js`. A cópia em `src/router/CalendarioLetivoService.js` não tem import encontrado em `src`; use a implementação registrada como referência.

## Referências no código

- API: `routes/planosSemanaisInfantil.php`.
- Web: `src/Services/planosSemanaisInfantilService.js`.
- Web: `src/router/CalendarioLetivoService.js`.

Base da análise: 27/10/2026, API `c75f817`, Web `83a91eb`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
