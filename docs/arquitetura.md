# Arquitetura compartilhada

Padrão para funcionalidades novas nas APIs Laravel e nas aplicações Web Vue dos municípios. Leia junto com [as regras da API](api.md), [as regras da Web](web.md), conforme o escopo, e com `municipios/<municipio>.md`.

Leia esta doc antes de planejar, implementar ou revisar um módulo novo, criar camadas ou mudar responsabilidades entre elas. Ajustes pontuais no legado preservam a estrutura existente. Particularidades municipais prevalecem sobre a organização genérica, mantendo autorização e isolamento dos dados.

## Fluxo de uma funcionalidade

```text
Web: página → service HTTP → API
API: rota e autorização → FormRequest + controller → Action → models/banco
                                                    ↓
                                       Service, quando houver orquestração
Web: resposta → service HTTP → estado da página/componentes
```

O controller chama uma Action quando a operação é um caso de uso simples. Quando o caso de uso coordena várias operações ou integrações, pode chamar um Service que organiza esse fluxo e reutiliza Actions. Evite dependências circulares entre Actions e Services.

## Responsabilidades na API

| Camada | Responsabilidade | Local padrão |
|---|---|---|
| Rota e autorização | Definir endpoint, autenticação e permissão | `routes/`, middleware e Policies existentes |
| FormRequest | Validar entrada e fornecer mensagens em pt-BR | `app/Http/Requests/` |
| Controller | Traduzir HTTP, resolver contexto autenticado e chamar o caso de uso | `app/Http/Controllers/` |
| Action | Executar uma operação de negócio com dados e contexto explícitos | `app/Actions/<Dominio>/<Verbo><Entidade>Action.php` |
| Service | Coordenar operações ou encapsular uma integração | `app/Services/` |
| Model | Mapear persistência, relações, casts e scopes reutilizáveis | `app/Models/` |

- Controller por recurso, com métodos curtos. Use FormRequest e injeção de dependências; não acrescente regras ao controller base legado.
- Action nova usa `handle`, recebe dados já validados e ids de contexto. Não recebe Request nem devolve resposta HTTP. Devolve o resultado da operação ou sinaliza falha pelo tratamento de erros do projeto.
- Actions podem ser reutilizadas em controllers, jobs e comandos. Preserve convenções locais existentes, como Actions invocáveis do Censo.
- Service deve ter um propósito claro. Não crie uma classe que apenas repassa chamadas nem uma classe que concentra todas as operações de um domínio.
- Model não monta resposta HTTP nem resolve o usuário autenticado para decidir qual escola acessar. Reutilize scopes e relações existentes sem esconder o contexto da operação.
- Mantenha no projeto seus mecanismos de bootstrap, autorização e tratamento de erros. Não migre Kernel, Handler ou RouteServiceProvider como efeito colateral de uma funcionalidade.

## Contexto escolar e consistência

- Resolva escola/franquia e ano letivo no servidor, a partir do usuário autenticado e das regras da operação. Não confie em ids enviados pela Web para definir o acesso; telas de rede que escolhem escola também precisam validar essa autorização.
- Passe o contexto necessário explicitamente para Actions e Services. Jobs, comandos e rotas públicas não podem depender de helpers que exigem usuário logado.
- Filtre consultas e valide o pertencimento antes de ler, alterar ou excluir um recurso por id. Uma permissão de ação não substitui o isolamento entre escolas.
- Quando várias escritas representam uma única operação, mantenha a transação no ponto que coordena essas escritas.
- Considere falhas e repetição de chamadas em integrações. Uma transação de banco não desfaz uma chamada externa; defina a ordem e o tratamento da falha conforme a operação, sem criar infraestrutura desnecessária.

## Responsabilidades na Web

| Camada | Responsabilidade | Local padrão |
|---|---|---|
| Página | Coordenar interação, estado local, loading e mensagens | `src/Pages/<Dominio>/` |
| Componente | Exibir dados e emitir eventos, com props e slots claros | `src/components/<Dominio>/` |
| Service HTTP | Chamar a API pelo cliente do projeto e entregar dados ao consumidor | `src/Services/` |
| Rota e guard | Definir navegação e acesso à tela | `src/router/` |
| Vuex | Compartilhar estado entre telas quando necessário | `src/store/` |

- Use Options API e JavaScript conforme o projeto. Reutilize componentes e plugins existentes antes de criar uma alternativa.
- Chamadas HTTP passam pelos services, registrados no mecanismo existente de `this.$services`. Componentes e páginas não montam um cliente HTTP próprio.
- Página coordena o fluxo; componente recebe dados e comunica ações. Extraia componentes quando houver responsabilidade própria ou reaproveitamento, sem fragmentar por tamanho apenas.
- Prefira estado local para formulário e lista. Use Vuex para estado compartilhado, considerando a persistência configurada no município.
- Guards e `$can` controlam a experiência de navegação. A API continua responsável por autorizar e isolar os dados.

## Contrato entre API e Web

Antes de implementar o consumo, defina método, rota, permissão, entrada, resposta, paginação e erros. Confirme o comportamento no controller, nos Resources e no interceptor do município.

Preserve contratos existentes. Uso de Resources, envelopes e códigos de erro varia entre municípios; um exemplo de Vera Mendes não define o contrato dos demais. Mantenha o mesmo nome de permissão nos dois lados e mensagens ao usuário em pt-BR.

Registre as particularidades dos contratos no perfil municipal e use referências ao código para os detalhes. Quando mudar um contrato, atualize o perfil e os consumidores envolvidos na mesma tarefa.

## Simplicidade e evolução do legado

- Cada classe ou componente tem uma responsabilidade clara. Prefira nomes que descrevem o caso de uso, dados explícitos e dependências injetadas.
- Reutilize código quando houver comportamento comum real. Não introduza interfaces, repositories, DTOs ou novas camadas sem necessidade concreta.
- Em ajuste pontual, mantenha o estilo do arquivo. Lógica nova relevante pode ir para uma Action ou componente próprio, sem reorganizar todo o módulo.
- Refatoração ampla exige escopo explícito. Preserve variantes municipais e registre problemas fora do pedido como pendências.
- Teste comportamento, autorização e isolamento conforme o runner e o ambiente do município. Não imponha Pest, SQLite ou infraestrutura de testes ausente no projeto.
- Particularidades e decisões municipais ficam no perfil `municipios/<municipio>.md`. Documentação extra e ADRs só são criadas quando solicitadas. Padrões compartilhados ficam nesta doc; comandos e armadilhas continuam em `docs/api.md` e `docs/web.md`.
