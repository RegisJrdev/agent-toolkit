# morrocabecanotempo

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `morrocabecanotempo/morrocabecanotempo-api` e `morrocabecanotempo/morrocabecanotempo-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.1`, Laravel `^10.0`, Sanctum `^3.2`. Faixas declaradas, não versões instaladas.
- Testes API: PHPUnit. Web: sem script `test:unit`.
- Migrations: sem loader de subpastas ativo localizado em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `morrocabecanotempo-**`; Web `morrocabecanotempo-**`. Push correspondente aciona workflow.

## Particularidades

Integrações Notifiq/Epublic, planejamento mensal/infantil e BNCC semestral. Não foi encontrado módulo exclusivo entre os arquivos de rotas/services selecionados; isso não significa igualdade funcional com Cocal ou outros projetos.

## Referências no código

- API: `routes/notifiq.php`.


Base da análise: 27/10/2026, API `d0c4e52`, Web `9b5b8e3`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
