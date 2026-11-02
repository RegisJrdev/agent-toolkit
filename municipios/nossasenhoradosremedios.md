# nossasenhoradosremedios

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `nossasenhoradosremedios/nossasenhoradosremedios-api` e `nossasenhoradosremedios/nossasenhoradosremedios-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.1`, Laravel `^10.0`, Sanctum `^3.2`. Faixas declaradas, não versões instaladas.
- Testes API: PHPUnit. Web: sem script `test:unit`.
- Migrations: carrega um nível de subpastas em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `nossasenhoradosremedios-**`; Web `nossasenhoradosremedios-**`. Push correspondente aciona workflow.

## Particularidades

Gestão de aulas complementar e órgão emissor possuem rotas e services próprios. maatwebsite/excel está fixado em 3.1.68. Carrega migrations de subpastas.

## Referências no código

- API: `routes/gestoesDeAulasComplementar.php`.
- API: `routes/orgaoEmissor.php`.
- Web: `src/Services/AulasComplementaresService.js`.
- Web: `src/Services/GestoesDeAulasComplementarService.js`.

Base da análise: 27/10/2026, API `7e2cde7`, Web `cb9e82b`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
