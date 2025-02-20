# color definitions
BOLD="$(tput bold 2>/dev/null || printf '')"
GREY="$(tput setaf 0 2>/dev/null || printf '')"
UNDERLINE="$(tput smul 2>/dev/null || printf '')"
RED="$(tput setaf 1 2>/dev/null || printf '')"
GREEN="$(tput setaf 2 2>/dev/null || printf '')"
YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
BLUE="$(tput setaf 4 2>/dev/null || printf '')"
MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
NO_COLOR="$(tput sgr0 2>/dev/null || printf '')"

# config minimal theme
# PROMPT_COLOR="${YELLOW}"
# PROMPT_GIT_COLOR="${BLUE}"

# prompt customization
PROMPT_EXPANDED_COLOR="${(P)${PROMPT_COLOR:-GREEN}}"
PROMPT_COLOR="${EXPANDED_COLOR:-GREEN}"

# git prompt customization
PROMPT_GIT_EXPANDED_COLOR="${(P)${PROMPT_GIT_COLOR:-MAGENTA}}"
PROMPT_GIT_COLOR="${PROMPT_GIT_EXPANDED_COLOR:-MAGENTA}"

#vcs info customization
zstyle ':vcs_info:git*' formats "on ${PROMPT_GIT_COLOR} %b${NO_COLOR} %m%u%c %a "
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ' ${GREEN}✚${NO_COLOR}'
zstyle ':vcs_info:*' unstagedstr ' ${RED}●${NO_COLOR}'

# vcs_info
autoload -Uz vcs_info
setopt prompt_subst

# prompt before PROMPT variable
precmd() {
  vcs_info
  print -P "${PROMPT_COLOR}${BOLD}%~${NO_COLOR} ${vcs_info_msg_0_}"
}

# default prompt, actual line
PROMPT='${PROMPT_COLOR}${BOLD}%(!.#.$)${NO_COLOR} '