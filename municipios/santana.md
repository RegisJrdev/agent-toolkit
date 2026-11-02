# santana

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `santana/santana-api` e `santana/santana-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.1`, Laravel `^10.0`, Sanctum `^3.2`. Faixas declaradas, não versões instaladas.
- Testes API: PHPUnit. Web: sem script `test:unit`.
- Migrations: carrega um nível de subpastas em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `stm-**-**`; Web `stm-**-**`. Push correspondente aciona workflow.

## Particularidades

Recursos Humanos e profissionais de RH, auditoria na Web e ponto de colaboradores. PDF usa fpdf/fpdf e FPDI. composer.lock versionado fixa Laravel v10.50.3/Sanctum v3.3.3; não prova versão instalada.

## Ferramentas e cuidados específicos

- Web: o reducer de `createPersistedState` em `src/store/index.js` exclui `Autorizacoes` da persistência.

## Referências no código

- API: `routes/appConfigurations.php`.
- API: `routes/recursosHumanos.php`.
- API: `routes/recursosHumanosProfissionais.php`.
- Web: `src/Services/RecursosHumanosService.js`.
- Web: `src/router/auditoria.js`.

Base da análise: 27/10/2026, API `a437d9b`, Web `6622c05`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
