# API: padrões compartilhados

Leia junto com `municipios/<municipio>.md`. As APIs usam Laravel com bootstrap clássico, Kernel, Handler e RouteServiceProvider. PHP, versão do framework, runner e integrações vêm do perfil; confirme o checkout e a versão instalada antes de usar uma API de biblioteca.

Antes de planejar, implementar ou revisar um módulo novo, criar camadas ou mudar suas responsabilidades, leia [a arquitetura compartilhada](arquitetura.md).

## Código novo

- Controller por recurso: valida com FormRequest, chama a operação de negócio e traduz o resultado HTTP. Não acrescente responsabilidades ao controller base legado.
- Action para uma operação: `app/Actions/<Dominio>/<Verbo><Entidade>Action.php`, método `handle`, dados validados e ids de contexto por parâmetro. Não recebe Request nem devolve resposta HTTP. Service para orquestrações e integrações. Preserve variantes existentes, como Actions invocáveis do Censo.
- Use injeção de dependências e transação quando várias escritas compõem uma operação. Não refatore controllers grandes fora do escopo.
- Filtre dados pela escola/franquia e pelo ano quando aplicável. Confira o pertencimento de recursos acessados por id. Helpers de usuário autenticado não devem resolver contexto em jobs, comandos ou rotas públicas: passe os ids explicitamente.
- FormRequest com mensagens pt-BR; autorização precisa estar na rota ou no mecanismo existente. Não capture toda Exception para devolver erro genérico.
- Models: confira `app/Models/MyModel.php` antes de herdar, defina fillable/casts. Prefira enum nativo em código novo; preserve enums legados.

## Padrões de desenvolvimento

Aplicam-se ao código novo e à lógica alterada no escopo da tarefa. Em ajuste pontual no legado, preserve o estilo e os contratos existentes; não use estes padrões como motivo para uma refatoração ampla. A divisão entre camadas está em [arquitetura.md](arquitetura.md).

### SOLID na prática

- **S — Responsabilidade única:** cada classe tem um motivo claro para mudar. Controller traduz HTTP, FormRequest valida entrada e Action executa uma operação de negócio. Se uma classe mistura essas responsabilidades, separe a lógica nova na camada adequada.
- **O — Aberto para extensão:** quando houver variações reais de uma regra ou integração, isole o comportamento variável em uma implementação própria. Não crie uma hierarquia para possibilidades futuras; condicionais simples continuam adequadas quando expressam diretamente a regra.
- **L — Substituição de Liskov:** implementações e subclasses preservam o contrato esperado pelo consumidor: entradas aceitas, resultado, falhas e efeitos da operação. Antes de estender `MyModel` ou trocar uma implementação, confira esses comportamentos; não altere silenciosamente o significado de métodos herdados.
- **I — Segregação de interfaces:** quando uma interface for necessária, exponha apenas as operações que seus consumidores precisam. Evite contratos genéricos que obrigam implementações a oferecer métodos sem uso ou lançar erro de operação não suportada.
- **D — Inversão de dependência:** receba colaboradores por injeção, sem instanciar Actions ou Services dentro da regra de negócio. Use uma abstração quando houver necessidade concreta de desacoplar um provedor externo ou suportar implementações distintas; não crie uma interface para cada classe por convenção.

### Clean Code

- Use nomes que expressem a intenção e o vocabulário do domínio, seguindo o idioma e as convenções do módulo. Prefira verbos para operações e evite nomes vagos como `processarDados` quando houver um nome de negócio específico.
- Mantenha métodos focados em uma operação e em um nível de abstração. Extraia trechos com responsabilidade própria; não fragmente apenas para cumprir um limite de linhas.
- Prefira retornos antecipados quando reduzirem aninhamento. Evite flags booleanas que mudam completamente o comportamento do método; operações distintas podem exigir métodos ou Actions distintos.
- Procure Actions, scopes, helpers e regras existentes antes de duplicar lógica. Extraia comportamento comum quando tiver o mesmo significado, sem acoplar regras diferentes só porque o código se parece.
- Dê nome a valores de domínio com constantes ou enums compatíveis com o PHP instalado. Preserve valores persistidos e contratos de enums existentes; não introduza números ou strings sem significado explícito.
- Comente decisões e restrições que o código não explica. Remova código morto e comentários obsoletos no trecho alterado, sem reformatar arquivos alheios ao pedido.
- Trate falhas no ponto que pode resolvê-las ou traduzi-las corretamente. Não silencie exceções, não devolva sucesso após falha e não use `catch` genérico para esconder erro inesperado.

### Convenções de backend

- Namespace acompanha a pasta e o mapeamento PSR-4 do projeto. Preserve a organização local de nomes, imports e arquivos.
- Declare tipos de parâmetros, propriedades e retornos quando o contrato for conhecido e a versão instalada permitir. Ao alterar assinaturas existentes, confira chamadas, herança e valores nulos; evite `mixed` quando houver um tipo preciso.
- Passe dados validados e contexto explicitamente. Evite arrays com significados ocultos e métodos com parâmetros demais; use uma estrutura própria apenas quando a complexidade justificar, sem tornar DTO obrigatório.
- Reutilize relações e scopes para consultas legíveis, mantendo visível o filtro de escola/franquia e ano. Carregue antecipadamente relações usadas em listas para evitar consultas por item; limite ou pagine coleções conforme o contrato do endpoint.
- Siga o formatter disponível no município e restrinja a formatação aos arquivos alterados. Não adicione ferramenta ou dependência só para impor uma preferência de estilo.
- Valide comportamento observável e regras de negócio, incluindo autorização e isolamento. Evite testes que apenas reproduzem a implementação ou dependem de detalhes internos sem necessidade.

## Rotas, permissões e respostas

- Registre rotas do domínio no RouteServiceProvider e confirme middleware de autenticação/autorização; não suponha que o grupo de `routes/api.php` já autentica.
- Mantenha nomes de permissão iguais na API e na Web. Confira `app/Http/Middleware/Can.php`, uso de `can:` e Policies existentes; Quiterianópolis registra `AvisoPolicy`.
- Na família `PermissionSeeder`/`RoleSeeder`, atualize o cadastro e os JSON de cada papel autorizado: o RoleSeeder recria vínculos a partir deles. Cajueiro, Luís Correia e São Bernardo usam outra variante (`PermissionsSeeder`/`RolesSeeder`); leia o seeder e seu fluxo antes de alterar permissões. Confira quem chama os seeders em `DatabaseSeeder`, sem presumir aplicação automática no deploy.
- Não use ids fixos de papel/usuário para conceder acesso. Confirme a emissão de abilities no login e informe quando relogar for necessário.
- Contrato novo: combine payload, paginação e erros com o consumidor; use status HTTP coerentes e mensagens pt-BR. Preserve envelopes/Resources dos endpoints existentes.
- Leia o Handler local antes de depender de 403/404/422: há variantes que convertem exceções em 500. Não copie o contrato de Vera Mendes para outro município.

## Banco e testes

- Migrations novas seguem a organização carregada pelo projeto; o perfil informa se subpastas são carregadas. Os loaders observados usam um nível de subpastas, não recursão arbitrária.
- Deploys incluem `migrate --force --seed`: seeders precisam ser idempotentes. Não rode deploy ou migration no ambiente compartilhado para testar uma alteração local.
- Use o runner disponível: PHPUnit ou Pest, conforme o perfil e os arquivos existentes. Depois de preparar o ambiente, `vendor/bin/phpunit` ou `vendor/bin/pest`; formatação com `vendor/bin/pint --dirty` somente onde Pint estiver disponível.
- Antes da suíte, confira `phpunit.xml` e o banco efetivo. SQLite não está configurado em todas as APIs. Quando houver SQLite, trate SQL específico de MySQL sem alterar o comportamento de produção.
- Teste o comportamento alterado, as permissões e o isolamento entre escolas. Autentique testes de rota sem desligar a autorização. Reutilize factories e a infraestrutura local de testes.
- Informe o que executou e as falhas reais; dependência declarada não comprova suíte operacional. `composer show <pacote>` informa a versão instalada.
