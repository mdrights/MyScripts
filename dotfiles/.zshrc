# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory share_history autocd extendedglob nomatch notify
unsetopt beep

#bindkey -e
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^i' expand-or-complete-prefix
#bindkey  "\e[2~" quoted-insert
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/vagrant/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# Added by user here.
REPORTTIME=10
alias ls="ls $LS_OPTIONS"
alias gits='git status'
#export TERM=screen
source /usr/share/git-core/contrib/completion/git-prompt.sh
#setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
setopt PROMPT_SUBST ; PS1='[%m %c$(__git_ps1 " (%s)")]\$ '


# Powerline
#. /usr/local/repo/powerline/powerline/bindings/zsh/powerline.zsh
