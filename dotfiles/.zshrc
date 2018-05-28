# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep

#bindkey -e
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^i' expand-or-complete-prefix
#bindkey  "\e[2~" quoted-insert
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/user/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Added by user here.
alias ls="ls $LS_OPTIONS"
REPORTTIME=10

# Powerline
#. /usr/local/repo/powerline/powerline/bindings/zsh/powerline.zsh
