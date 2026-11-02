# araioses

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `araioses/araioses-api` e `araioses/araioses-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.2`, Laravel `^11.0`, Sanctum `^4.0`. Faixas declaradas, não versões instaladas.
- Testes API: PHPUnit. Web: `yarn test:unit` declarado.
- Migrations: sem loader de subpastas ativo localizado em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `araioses-**`; Web `araioses-**`. Push correspondente aciona workflow.

## Particularidades

CAEE, descritores e códigos de habilidades aproximam este projeto de Parnaíba e Vera Mendes. Não possui o Diário de Atendimentos de Vera Mendes.

## Referências no código

- API: `routes/codigosHabilidades.php`.
- API: `routes/descritores.php`.
- API: `routes/gestoesDeAulasCAEE.php`.
- API: `routes/notifiq.php`.
- Web: `src/Services/CodigosHabilidadesService.js`.
- Web: `src/Services/DescritoresService.js`.

Base da análise: 27/10/2026, API `a112681`, Web `794e7b6`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
