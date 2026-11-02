# ePublic — desenvolvimento dos sistemas municipais

## Visão geral do projeto

Sistemas municipais de gestão escolar, com uma API Laravel e uma aplicação Web Vue por município, em repositórios Git separados. A API concentra regras de negócio, persistência e autorização; a Web oferece as telas e consome seus endpoints. Os projetos compartilham padrões, mas têm diferenças de versões, ferramentas e funcionalidades.

- **API:** PHP/Laravel; código em `app/`, endpoints em `routes/`, migrations e seeders em `database/`, testes em `tests/`.
- **Web:** JavaScript, Vue 2, Vuetify 2 e Vue CLI; código em `src/`, páginas em `src/Pages/`, componentes em `src/components/` e acesso HTTP em `src/Services/`.
- Versões, comandos específicos e particularidades são descritos em `municipios/<municipio>.md`. Confirme o checkout, os manifests e a instalação efetiva antes de usar essas referências.

## Município e repositórios

- Use o município informado pelo usuário e leia `municipios/<municipio>.md`.
- Sem município escolhido, liste os perfis e siga a seção Dúvidas antes de planejar, revisar ou alterar a aplicação. Aguarde a escolha, mesmo havendo apenas um perfil.
- Não escolha o município por semelhança, pelo diretório ou por configuração antiga. Se o perfil não existir, apresente os disponíveis.
- Caminhos informados explicitamente na conversa têm prioridade. Confira sua existência e as raízes Git.
- Após a escolha do município, procure em `~/repositorios/<municipio>/<municipio>-api` e `~/repositorios/<municipio>/<municipio>-web`. Use o slug do perfil; os nomes das pastas seguem esse padrão.
- Valide a raiz Git e o manifest de cada lado necessário (`composer.json` na API, `package.json` na Web). Informe os caminhos encontrados e prossiga sem pedir confirmação.
- Se o caminho esperado não existir ou não estiver acessível, informe o impedimento e siga Dúvidas. Não procure fora de `~/repositorios` nem tente nomes alternativos por conta própria.
- Mantenha município e caminhos durante a sessão. Ao trocar de município, leia o novo perfil. Cada nova sessão exige escolha própria; não grave seleção global.
- Alterações apenas nas regras comuns não exigem município.

Execute comandos na raiz do repo resolvido. Antes de editar, confira:

```bash
git -C <repo> rev-parse --show-toplevel
git -C <repo> status --short
```

Confirme que a raiz é a esperada e preserve as alterações existentes. Caminhos `app/`, `routes/` e `database/` nas docs são da API; `src/` é da Web.

## Dúvidas

- Diante de dúvida ou ambiguidade, não assuma: pergunte com `AskUserQuestion`.
- Ofereça de 2 a 4 opções curtas e indique a recomendada.
- Sem essa ferramenta, use o seletor equivalente ou o chat, respeitando os limites disponíveis.
- Para caminhos, siga primeiro a descoberta descrita acima; pergunte apenas se ela não resolver. Para tickets ausentes, peça o valor sem inventar alternativas. Na escolha do município, apresente os perfis disponíveis.
- Aguarde a resposta antes de executar a parte dependente da decisão.

## Limites de atuação

- Confira regras de negócio no código e na documentação. Para lacunas, siga a seção Dúvidas.
- Não amplie a tarefa para refatorar ou modernizar o legado. Preserve o estilo e os contratos existentes fora do escopo solicitado.
- Em pedidos apenas de análise ou revisão, apresente achados, evidências e limitações sem editar arquivos. Aplique correções somente quando solicitadas ou autorizadas.
- Não faça commit, push, merge ou deploy sem pedido. O pedido de publicar segue o workflow e a skill de publicação; merge e deploy manual exigem pedido específico. A promoção de homologação para produção exige pedido separado.

## Instruções de desenvolvimento

### Leituras obrigatórias

- **Vai mexer na API?** Antes de planejar, implementar, corrigir ou revisar código da API, leia [docs/api.md](docs/api.md) e o perfil `municipios/<municipio>.md`.
- **Vai mexer na Web?** Antes de planejar, implementar, corrigir ou revisar código da Web, leia [docs/web.md](docs/web.md) e o perfil `municipios/<municipio>.md`.
- **A tarefa envolve API e Web?** Leia ambas as docs e o perfil municipal; defina o contrato na API antes de implementar o consumo na Web.
- **Vai criar um módulo ou mudar as camadas?** Antes de planejar, implementar ou revisar módulo novo, criar camadas ou mudar responsabilidades entre elas, leia também [docs/arquitetura.md](docs/arquitetura.md).

### Execução da tarefa

- O desenvolvimento pode ser feito diretamente. Se usar subagentes, eles também devem ler o perfil municipal e as regras do lado em que atuam.
- Os padrões de código novo orientam a evolução dos projetos; não descrevem todo o código existente.
- Valide acesso à escola/franquia e ao ano letivo no servidor. O perfil municipal não dispensa autorização nem isolamento dos dados.
- Use versões instaladas; na ausência delas, informe a limitação e confira manifest/lock. Consulte a documentação da versão efetiva ao introduzir uso novo de uma API de biblioteca, esclarecer dúvidas ou verificar compatibilidade em mudanças de versão (Context7, se disponível). Reutilize a documentação já consultada enquanto continuar aplicável.

## Comandos de desenvolvimento

### Antes de executar

- Execute na raiz da API ou da Web confirmada.
- Confira o perfil, os scripts dos manifests e `.github/workflows/`.
- Confirme a instalação das ferramentas. Dependência declarada não comprova instalação.

### Comandos disponíveis

| Projeto | Comando | Quando usar |
|---|---|---|
| API | `composer show <pacote>` | Conferir a versão instalada de uma dependência |
| API | `vendor/bin/phpunit` ou `vendor/bin/pest` | Executar testes com o runner configurado e instalado; começar pelos testes afetados |
| API | `vendor/bin/pint --dirty` | Formatar mudanças somente onde Pint estiver disponível |
| Web | `yarn serve` | Iniciar o ambiente local com a configuração existente |
| Web | `yarn lint --no-fix` | Verificar código e imports sem reescrita automática |
| Web | `yarn test:unit` | Executar testes de comportamento onde esse script estiver declarado |
| Web | `yarn build --mode <modo>` | Validar compilação ou integração quando necessário, usando um modo existente |

## Testes e validação

**Nunca execute testes, migrations ou seeders que escrevam em banco compartilhado para validar uma alteração.** Confira o destino efetivo antes de qualquer validação, inclusive pela Web.

- **API:** antes da suíte, confira `composer.json`, os testes existentes, `phpunit.xml` e o banco efetivo.
- **Web:** execute lint ao alterar código, inclusive imports ou caminhos. Use testes existentes para o comportamento afetado e build quando necessário. Confira os modos e o destino da API antes de executar.
- Ao alterar comportamento, adicione ou ajuste testes usando a infraestrutura existente. Se ela estiver ausente, registre a limitação e valide com os recursos disponíveis, sem criar infraestrutura nova fora do escopo.
- Dimensione as verificações pelo comportamento e pelo risco da mudança. Corrija falhas introduzidas; informe falhas preexistentes e impedimentos de ambiente ou dependências, sem ampliar o escopo para corrigir problemas alheios.
- Para alterações apenas documentais, confira links, caminhos e consistência com as instruções relacionadas. Não é necessário executar a suíte da aplicação.

## Workflow de desenvolvimento

Este fluxo se aplica aos repositórios municipais de API e Web. Em tarefa que envolva ambos, prepare uma branch em cada repo afetado.

### Preparar a branch

1. Confirme raiz, estado do Git e remoto. Preserve mudanças existentes; não use reset, descarte ou stash automático.
2. Se já estiver na branch desta tarefa, continue nela. Não a recrie nem faça rebase ou merge automático.
3. Para uma nova branch, identifique o ticket e o padrão municipal no perfil e no repo. Para informações ausentes, siga Dúvidas.
4. Monte um nome curto com prefixo municipal, ticket e descrição. Respeite separadores locais, inclusive `/` onde adotado. Exemplo: `quiterianopolis-7304-melhorias-graficos-home`.
5. Atualize as referências com `git fetch <remoto>`.
6. Crie a branch com `git switch -c <branch> <remoto>/main`. Não desenvolva diretamente em `main` ou `homologacao`.

Se houver trabalho de outra tarefa, impedimento na troca, falha no fetch ou base ausente, interrompa a preparação e siga Dúvidas. Análises e revisões sem edição dispensam criar branch.

### Implementar e publicar

1. Implemente e execute as validações pertinentes.
2. Quando houver pedido de publicação, confira os gatilhos conhecidos no perfil e o workflow efetivo em `.github/workflows/`. Informe se o push acionará deploy, mesmo antes do merge do PR.
3. Confirme a existência de `homologacao` no remoto. Se faltar, siga Dúvidas; não substitua por `main` nem crie uma base automaticamente.
4. Siga a skill [publicar-tarefa](.claude/skills/publicar-tarefa/SKILL.md): commit das alterações necessárias, push da branch e criação ou reutilização do PR para `homologacao`.
5. Respeite restrições expressas, como abrir PR apenas de commits existentes. Entregue o link do PR e as validações realizadas.

## Git e entrega

- A revisão independente pelo [agente revisor](.claude/agents/revisor.md) é opcional e só deve ser acionada por pedido explícito. Não é condição para entregar ou publicar.
- Preserve alterações preexistentes. Não reverta nem sobrescreva trabalho do usuário para facilitar a tarefa.
- Commit, quando solicitado: `tipo(escopo) #ticket descrição em pt-BR`.
- Antes de entregar, revise o diff e execute `git diff --check`. Se houver commit autorizado, conclua primeiro as verificações pertinentes acima.
- Ao concluir uma implementação, resuma o que mudou, os comandos de validação executados, seus resultados e as pendências. Não afirme que uma verificação passou sem executá-la.

## Documentação das mudanças

- Consulte as referências técnicas conforme a tarefa, sem duplicá-las nos perfis municipais. Particularidades técnicas prevalecem sobre descrições genéricas, mantendo autorização e isolamento dos dados.
- Ao implementar, atualize a documentação afetada pela mudança. Em pedidos apenas de análise, relate divergências sem editar arquivos. Não crie documentação extra ou ADRs sem solicitação.
