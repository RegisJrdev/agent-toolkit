# Web: padrões compartilhados

Leia junto com `municipios/<municipio>.md`. Base: Vue 2, Vuetify 2, Vuex 3, Vue Router 3, vee-validate 3 e Vue CLI 4. Os manifests analisados declaram Vue `^2.6.11`; confirme a instalação antes de usar recursos de 2.7. Não use APIs de Vue/Vuetify 3.

Antes de planejar, implementar ou revisar um módulo novo, criar camadas ou mudar suas responsabilidades, leia [a arquitetura compartilhada](arquitetura.md).

## Código novo

- Options API e JavaScript, seguindo o projeto. Páginas em `src/Pages/<Dominio>/`; componentes em `src/components/<Dominio>/`. Preserve telas legadas fora do escopo.
- HTTP via service em `src/Services/`, usando `Axios()` de `src/plugins/Axios.js`; registre em `src/Services/index.js` e consuma por `this.$services`. Use `{ params }` para query string.
- Leia controller/Resource da API e interceptor local antes de consumir a resposta. Envelopes, erros e decodificação de downloads variam entre municípios.
- Trate falhas com `this.$handleError` e feche o loading em `finally`. Confira os plugins do projeto; use os métodos de toast existentes, sem presumir `$toast.error`.
- Formulários com `ValidationObserver`/`ValidationProvider` e as regras registradas do projeto. Confirmações usam os componentes/plugins existentes.
- Componentes compartilhados `E*` são registrados em `src/plugins/components.js`; procure um existente antes de criar. Estilos locais com `scoped`.
- Rotas em `src/router/`, registradas no índice; use guard de permissão e `$can` no menu/botões com os mesmos nomes da API. Preserve contratos específicos dos guards existentes; não replique ids fixos nem checagens de papel em código novo.
- Vuex com módulos namespaced: prefira estado local para listas grandes e formulários. Confira se a persistência está ativa e quais módulos o reducer exclui em `src/store/index.js`; São Bernardo mantém o plugin desativado. As particularidades ficam nos perfis municipais.

## Comandos e validação

- `yarn serve`; `yarn build --mode develop|homologacao|production`, conforme os modos existentes. Confira `VUE_APP_API_HOST` e a composição dos paths no Axios/service.
- `yarn lint --no-fix` evita reescrita automática. Confira a configuração efetiva antes de interpretar falhas.
- `yarn test:unit` somente onde declarado: Araioses, Parnaíba e Vera Mendes na análise inicial. Nos demais, valide a mudança com os recursos disponíveis; não adicione infraestrutura de testes sem necessidade da tarefa.
- Testes de componente devem exercitar comportamento relevante e respeitar os plugins do setup local. Informe comandos executados e limitações.
- CI Web usa Node 16.x nos checkouts analisados. Confira o workflow do município; não atualize a ferramenta implicitamente.
- Não há `yarn.lock` Web rastreado no conjunto analisado; há `yalc.lock`. Verifique dependências locais antes de instalar. A versão efetiva está em `node_modules/<pacote>/package.json`.
- Configurações de frontend são públicas: não adicione segredos a `.env*` ou ao bundle.
