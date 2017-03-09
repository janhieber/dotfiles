## history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
#setopt BANG_HIST               # Treat the '!' character specially during expansion.
#setopt EXTENDED_HISTORY        # Write the history file in the ":start:elapsed;command" format.
#setopt INC_APPEND_HISTORY      # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY           # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST  # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS        # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS    # Delete old recorded entry if new entry is a duplicate.
#setopt HIST_FIND_NO_DUPS       # Do not display a line previously found.
setopt HIST_IGNORE_SPACE       # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS       # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks before recording entry.
#setopt HIST_VERIFY             # Don't execute immediately upon history expansion.
#setopt HIST_BEEP               # Beep when accessing nonexistent history.

## alias declaration
[[ -f /usr/bin/nvim ]] && alias v='nvim' || alias v='vim'
if [[ -f /usr/bin/pacman ]]; then
    if [[ -f /usr/bin/pacaur ]]; then
        alias p='pacaur'
        alias sp='pacaur'
    else
        alias p='pacman'
        [[ "$(id -u)" -ne 0 ]] && alias sp='sudo pacman' || alias sp='pacman'
    fi
fi

alias c='clear'
alias q='exit'

alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gp='git push'
alias gpu='git pull'

alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias -g L='| less'
alias -g G='| grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} --exclude=\*.{o,lst,d}'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} --exclude=\*.{o,lst,d}'
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh --color=auto --group-directories-first'

# this is how I manage the dotfiles
# see: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# calculator
function =
{
    echo "$@" | bc -l
}
alias calc="="

## plugins
for plugin in /usr/share/zsh/plugins/*/*.*sh $HOME/.zsh/*.*sh; do
    [[ -f $plugin ]] && source $plugin
done


#colored man pages
function man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        PAGER="${commands[less]:-$PAGER}" \
        _NROFF_U=1 man "$@"
}

## fix home/end buttons
bindkey "^[[4~" end-of-line
bindkey "^[[8~" end-of-line
bindkey "^[[F" end-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[7~" beginning-of-line
bindkey "^[[H" beginning-of-line
bindkey "^[[3~" delete-char
bindkey "^[[P" delete-char

bindkey "^R" history-incremental-search-backward
bindkey "^[[A" history-incremental-pattern-search-backward
bindkey "^[[B" history-incremental-pattern-search-forward

bindkey '^[[1;5A' history-substring-search-up
bindkey '^[[1;5B' history-substring-search-down

## damn kb speed is always resetting
[[ $DISPLAY ]] && [[ -f /usr/bin/xset ]] && [[ "$(id -u)" -ne 0 ]] && \
    /usr/bin/xset r rate 250 45

## completions
# general auto complete
autoload -Uz compinit
compinit
# Turn on menu selection only when selections do not fit on screen.
zstyle ':completion:*' menu select
# Force rehash to have completion picking up new commands in path.
_force_rehash() { (( CURRENT == 1 )) && rehash; return 1 }
zstyle ':completion:::::' completer _force_rehash \
    _complete \
    _ignored \
    _approximate
#                                    _gnu_generic
zstyle ':completion:*'    completer _complete \
    _ignored \
    _gnu_generic \
    _approximate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 3 numeric
setopt AUTO_CD
# Default colors for listings.
#zstyle -e ':completion:*:default' list-colors 'reply=("${(s.:.)LS_COLORS}")'
# Separate directories from files.
zstyle ':completion:*' list-dirs-first true
# complete kill with ps
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $HOME/.cache/zsh_comp

# history search
autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search


# pressing ESC two times toggles 'sudo' in front of cmd
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line


## other stuff
# exports
[[ -f /usr/bin/nvim ]] && EDITOR='nvim' || EDITOR='vim'
export EDITOR

# fix for alacritty
nvim(){
    tput smkx
    command nvim $@
}

# ls colors
autoload -U colors && colors
(( $+commands[dircolors] )) && eval "$(dircolors -b)"

## functions for prompt
function prompt_git_branch () {
    git branch --no-color 2>/dev/null | \
        sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' \
        -e 's/(HEAD detached at //' -e 's/)//' \
        -e 's/(detached from //';
    [[ $? -ne 0 ]] && print ''
}

function prompt_git_dirty() {
    local TMP=''
    tmp=$(command git status --porcelain 2> /dev/null | tail -n1)
    [[ -n $tmp ]] && print " *"
}

function prompt_git() {
    local TMP=''
    TMP=$(prompt_git_branch)
    if [[ -n $TMP ]]; then
        print " %F{cyan}GIT[%f${TMP}%f%F{red}$(prompt_git_dirty)%f%F{cyan}]%f"
    fi
}

function prompt_char {
    [[ $UID -eq 0 ]] && print ' %F{red}#%f' || print ' >'
}

function prompt_shlvl {
    # print fork symbol when in subshell
    # we need to tell zsh that fork symbol is width=1
    [[ $SHLVL -gt 2 ]] && echo -e "%1{\xE2\x8B\x94%} "
}

function prompt_ecode {
    print "%(?..%F{red}%? %f)"
}

function prompt_ssh {
    [[ -n $SSH_CONNECTION ]] && print "%n@%m"
}

function prompt_chroot {
    if [[ $(stat -c %i /) -gt 3 ]]; then
        if [[ -n $SCHROOT_SESSION_ID ]];then
            print "%n@%F{cyan}CHROOT[%f$SCHROOT_CHROOT_NAME%F{cyan}]%f"
        else
            print "%n@%F{cyan}CHROOT[%f???%F{cyan}]%f"
        fi
    fi
}

## prompt

setopt promptsubst

PROMPT='$(prompt_ssh)$(prompt_chroot)$(prompt_git)$(prompt_char) '
RPROMPT='$(prompt_shlvl)$(prompt_ecode)%~'

# fix some chroot stuff
if [[ $SCHROOT_SESSION_ID ]]; then
    [[ $TERM = "rxvt-unicode-256color" ]] && export TERM='rxvt-unicode'
    if [[ "$(id -u)" -eq 0 ]]; then
        PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
    else
        PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
    fi
    export PATH
fi

