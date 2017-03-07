# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s autocd

export HISTCONTROL=ignoredups

## alias declaration
[[ -f /usr/bin/nvim ]] && alias v='nvim' || alias v='vim'
if [[ -f /usr/bin/pacman ]]; then
  alias p='pacman'
  [[ "$(id -u)" -ne 0 ]] && alias sp='sudo pacman' || alias sp='pacman'
fi

alias c='clear'
alias q='exit'

alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push origin master'

alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh --color=auto --group-directories-first'

# this is how I manage the dotfiles
# see: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


## other stuff
# exports
[[ -f /usr/bin/nvim ]] && EDITOR='nvim' || EDITOR='vim'
export EDITOR

if [[ $(id -u) -eq 0 ]]; then
  PS1='[\u@\h \W] #'
else
  PS1='[\u@\h \W] >'
fi


