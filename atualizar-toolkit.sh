#!/usr/bin/env bash
# Atualiza apenas este checkout, sem descartar trabalho local.
set -euo pipefail
aviso() { printf 'Toolkit: %s\n' "$*"; }
repo=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
cd "$repo"
raiz=$(git rev-parse --show-toplevel 2>/dev/null) || { aviso 'pasta sem Git; atualização ignorada.'; exit 0; }
[[ "$raiz" == "$repo" ]] || { aviso 'raiz Git inesperada; atualização ignorada.'; exit 0; }
[[ "$(git branch --show-current)" == main ]] || { aviso 'branch diferente de main; atualização ignorada.'; exit 0; }
[[ -z "$(git status --porcelain)" ]] || { aviso 'há alterações locais; atualização ignorada para preservá-las.'; exit 0; }

lock=$(git rev-parse --git-path toolkit-update.lock)
mkdir "$lock" 2>/dev/null || { aviso 'outra atualização está em andamento; atualização ignorada.'; exit 0; }
trap 'rmdir "$lock" 2>/dev/null || true' EXIT
export GIT_TERMINAL_PROMPT=0
export GIT_SSH_COMMAND="${GIT_SSH_COMMAND:-ssh -o BatchMode=yes -o ConnectTimeout=10}"
if ! git fetch --quiet origin main; then
  aviso 'não foi possível consultar origin/main; seguindo com a versão local.'
  exit 0
fi
alvo=$(git rev-parse FETCH_HEAD)
atual=$(git rev-parse HEAD)
[[ "$atual" != "$alvo" ]] || { aviso 'main já atualizada.'; exit 0; }
if ! git merge-base --is-ancestor "$atual" "$alvo"; then
  aviso 'main tem commits locais ou divergiu do remoto; atualização automática ignorada.'
  exit 0
fi
# Reconfere depois da rede, pois outra sessão pode ter alterado o checkout.
if [[ "$(git branch --show-current)" != main || "$(git rev-parse HEAD)" != "$atual" || -n "$(git status --porcelain)" ]]; then
  aviso 'checkout mudou durante a consulta; atualização ignorada.'
  exit 0
fi
if git merge --ff-only --quiet "$alvo"; then
  printf '%s\n' '{"hookSpecificOutput":{"hookEventName":"SessionStart","reloadSkills":true,"additionalContext":"Toolkit atualizado pela main. Releia AGENTS.md e as referências da tarefa antes de trabalhar. Se configurações de hooks ou agentes mudaram, reinicie a sessão para carregá-las."}}'
else
  aviso 'não foi possível aplicar fast-forward; confira o Git antes de tentar novamente.'
fi
