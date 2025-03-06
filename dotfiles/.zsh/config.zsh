# Command completion with arrow-key
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# If ZSH is not defined, use the current script's directory.
[[ -n "$ZSH" ]] || export ZSH="${${(%):-%x}:a:h}"

#source plugins
source $ZSH/plugins.zsh
