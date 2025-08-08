# If ZSH is not defined, use the current script's directory.
[[ -n "$ZSH" ]] || export ZSH="${${(%):-%x}:a:h}"

#source plugins
source $ZSH/plugins.zsh

#source aliases
source $ZSH/aliases.zsh

#source exports
source $ZSH/exports.zsh
