---
name: publicar-tarefa
description: Publica uma tarefa municipal na branch de trabalho e abre ou reutiliza um PR para homologacao. Use quando o usuário pedir para publicar a tarefa, fazer push com PR ou abrir o PR da alteração; não durante a implementação comum.
--- 

# Publicar tarefa

Conclua a publicação solicitada no repositório municipal correto. Esta skill não publica o toolkit e não autoriza merge ou deploy manual. Sua leitura ou criação, por si só, não autoriza publicação.

## Contexto e preparação

- Leia o `AGENTS.md` da raiz deste toolkit (três níveis acima da pasta desta skill) e siga seu workflow. Use o município escolhido na sessão; se faltar, apresente os perfis e aguarde a escolha. Leia o perfil e `docs/api.md` ou `docs/web.md`, conforme o repo afetado.
- Confirme ticket, raiz Git, branch atual e remoto de destino. Confira o status, os diffs staged/unstaged e arquivos novos. Use o padrão municipal `<prefixo>-<ticket>-<descricao-curta>`; não renomeie nem crie outra branch automaticamente durante a publicação se a atual estiver incorreta.
- API e Web têm publicações separadas. Publique apenas os repos incluídos no pedido e, quando ambos participarem, relacione os dois PRs e descreva o contrato/dependências.
- Consulte `.github/workflows/` e os hooks locais configurados para identificar efeitos do push e do commit. Um deploy automático previsto no workflow faz parte dos efeitos a informar antes de executar a publicação solicitada. Não desabilite hooks nem altere workflows para conseguir publicar.
- Atualize as referências remotas com fetch e confirme que `homologacao` existe no destino. Se faltar, peça orientação; não substitua a base por `main`. Não faça pull, merge ou rebase automático para resolver divergências.

## Preparar a alteração para publicação

1. Confira se os commits da branch em relação a `main` correspondem à tarefa. Inspecione também o diff e os commits que aparecerão no PR contra `homologacao`: essa base pode conter mudanças que não estão em `main`. Se houver mudanças alheias ou uma diferença inesperada entre as bases, informe o problema antes do push; não reverta código nem reescreva histórico para esconder a diferença.
2. Aplique as validações proporcionais definidas no AGENTS e no perfil. Aproveite resultados já executados se o código não mudou desde então. Registre comandos, resultados e limitações; não afirme sucesso de verificações não executadas. Falhas introduzidas impedem a publicação até serem resolvidas; limitações de ambiente devem ser informadas e não tratadas como testes aprovados.
3. Revise `git diff --check` e os arquivos a incluir. Não use `git add .` ou `git add -A` indiscriminadamente. Preserve arquivos e trechos de outras tarefas, inclusive os já staged. Se não for possível separar o escopo com segurança, peça orientação.
4. O pedido de publicar a tarefa inclui registrar em commit as alterações necessárias dessa tarefa, salvo restrição expressa do usuário. Use `tipo(escopo) #ticket descrição em pt-BR`. Não crie commit vazio se tudo já estiver registrado. Se o pedido for somente abrir PR de commits existentes, não inclua alterações locais.
5. Depois do commit, confira o status e o conteúdo efetivamente registrado: hooks podem modificar arquivos ou o checkout. Se o commit incluir alterações inesperadas, interrompa antes do push e informe o ocorrido; não desfaça commits automaticamente. Revalide se o conteúdo da tarefa mudou.

## Push e PR

- Confira se a branch remota de mesmo nome contém commits ausentes localmente; nessa situação, informe a divergência. Nunca use force push, reset ou exclusão de branch como solução automática.
- Faça push somente da branch da tarefa para o remoto confirmado, configurando seu upstream. Não envie `main`, `homologacao`, tags ou outras branches junto.
- Use o conector de hospedagem disponível ou a CLI autenticada do projeto para gerenciar o PR. Confira o repositório de destino explicitamente, sem depender do repo padrão de uma ferramenta. Falta de autenticação ou ferramenta deve ser informada; não instale nem autentique contas por conta própria.
- Procure PR existente para a mesma origem e base antes de criar um. Reutilize o PR aberto; atualize sua descrição apenas quando necessário para refletir a tarefa. Se houver PR para outra base, peça orientação antes de mudar o destino ou criar outro.
- Crie o PR com a branch publicada como origem e **`homologacao` como base**. Use o template do repo, se existir. Inclua ticket, problema resolvido, mudança de comportamento, validações e limitações reais. Mantenha título e descrição em pt-BR, objetivos e proporcionais à mudança. Em CLI, prefira arquivo de corpo com quebras de linha reais em vez de concatenar conteúdo em shell.
- Não faça merge, aprovação em nome de terceiros ou deploy manual. O agente revisor via Codex permanece opcional e não deve ser acionado sem pedido.

## Resultado

Informe repo, ticket, branch, commit publicado, link e base do PR, validações e pendências. Confira o estado real antes de declarar sucesso. Se o push funcionar e o PR falhar, diga exatamente isso e, na retomada, procure o PR antes de repetir a criação. Não repita publicação automaticamente em caso de resultado incerto.
