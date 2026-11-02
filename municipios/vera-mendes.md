# vera-mendes

Caminhos de referência do checkout analisado (confirme os caminhos locais na sessão): `vera-mendes/vera-mendes-api` e `vera-mendes/vera-mendes-web`.

## Ambiente e comandos

- Manifesto API: PHP `^8.3`, Laravel `^12.0`, Sanctum `^4.0`. Faixas declaradas, não versões instaladas.
- Testes API: Pest declarado; confirmar configuração e instalação. Web: `yarn test:unit` declarado.
- Migrations: sem loader de subpastas ativo localizado em `app/Providers/AppServiceProvider.php`.
- Branch de dev: API `veramendes-**`; Web `veramendes-**`. Push correspondente aciona workflow.

## Particularidades

Diário de Atendimentos autônomo, tipos de atendimento, desenvolvimento de biblioteca, feedback de coordenação e relatórios próprios; também CAEE. Coordenador-orientador e professor-orientador possuem permissões próprias para o Diário de Atendimentos.

## Ferramentas e cuidados específicos

- API: Pest `^3.0` e PHPUnit `^11.5` declarados, sem `tests/Pest.php` nem testes em sintaxe Pest encontrados no checkout. `phpunit.xml` configura SQLite em memória e uma extensão de relatório; confirme a infraestrutura antes de executar a suíte.
- API: em `app/Exceptions/Handler.php`, validação de `v1/epublic/*` responde 422; fora desse prefixo, o handler genérico pode converter validação em 500 sem debug.
- Hikvision: `HikController` não resolve escola por dispositivo e chama o processamento de presença duas vezes para alunos. `config/hikvision.php` define intervalo padrão de 15 minutos, sobrescrito pelo ambiente.
- Notifiq: `NotifiqPresencasService` consulta eventos do dia sem restringir escola por usuário nesse fluxo; a Web filtra as escolas por perfil. O filtro visual não garante isolamento na API. A permissão de listagem não consta no JSON ADMIN, apesar do vínculo criado por migration; confira o efeito do `RoleSeeder`.
- Web: há configurações ESLint em `package.json` e `src/.eslintrc.js`; confirme o resultado do lint no checkout antes de afirmar conflito.

## Referências no código

- API: `routes/atendimentos.php`.
- API: `app/Http/Controllers/HikController.php`.
- API: `app/Services/notifiq/NotifiqPresencasService.php`.
- API: `app/Exceptions/Handler.php`.
- Web: `src/Pages/DiarioAtendimentos/`.
- Web: `src/Pages/Notifiq/IndexNotifiq.vue`.

Base da análise: 27/10/2026, API `d44d36c`, Web `df03381`. Confirme o código ao trocar de revisão; presença de módulo não comprova habilitação em produção.
