# If ZSH is not defined, use the current script's directory.
[[ -n "$ZSH" ]] || export ZSH="${${(%):-%x}:a:h}"

#source history
source $ZSH/history.zsh

#source plugins
source $ZSH/plugins.zsh
