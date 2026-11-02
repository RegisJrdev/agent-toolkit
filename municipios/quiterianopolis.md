# quiterianopolis

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `quiterianopolis/quiterianopolis-api` e `quiterianopolis/quiterianopolis-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.1`, Laravel `^10.0`, Sanctum `^3.2`. Faixas declaradas, não versões instaladas.
- Testes API: PHPUnit. Web: sem script `test:unit`.
- Migrations: sem loader de subpastas ativo localizado em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `quiterianopolis-**`; Web `quiterianopolis-**`. Push correspondente aciona workflow.

## Particularidades

AvisoPolicy é registrada em AuthServiceProvider e contém regra por papel. Justificativas de falta e planejamento por circuito infantil são específicos. stevebauman/location declarado. Preservar esses contratos ao revisar a regra comum sobre autorização.

## Referências no código

- API: `app/Policies/AvisoPolicy.php`.
- API: `routes/justificativasFalta.php`.
- API: `routes/notifiq.php`.
- API: `routes/planosCircuitoInfantil.php`.
- Web: `src/Services/JustificativaFaltaService.js`.
- Web: `src/Services/planosCircuitoInfantilService.js`.

Base da análise: 27/10/2026, API `ac580ed`, Web `477398d`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
