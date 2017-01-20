
## alias declaration
alias v='vim'
alias p='sudo pacman'
alias c='clear'
alias q='exit'
alias gp='git push origin master'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias -g L='| less'
alias -g N='&> /dev/null'
alias -g G='| grep -i'

## plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

## fix home/end buttons
bindkey "^[[4~" end-of-line
bindkey "^[[8~" end-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[7~" beginning-of-line
bindkey "^[[3~" delete-char

## damn kb speed is always resetting
if [ $DISPLAY ]; then xset r rate 250 45; fi

## zsh setting
# general auto complete
autoload -Uz compinit
compinit
# auto complete with arrow keys, press tab twice
zstyle ':completion:*' menu select


# this is from intro
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 3 numeric



# complete aliases
setopt COMPLETE_ALIASES
# history search
autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "${key[Up]}" ]] && bindkey "${key[Up]}" up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search

 
## functions for prompt
git_branch () {
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/';
    return 0;
}
git_dirty() {
  local STATUS=''
  STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
  if [[ -n $STATUS ]]; then
    echo " *"
  fi
}
git_prompt() {
    if git status >/dev/null 2>&1; then
        echo " %F{cyan}GIT[$(git_branch)%f%F{red}$(git_dirty)%f%F{cyan}]%f"
    fi
}

function get_pwd1() {
    echo "${PWD/$HOME/~}"
}

function prompt_char {
    if [ $UID -eq 0 ]; then echo " #"; else echo ' '$; fi
}

function sh_level {
    if [ $SHLVL -gt 2 ]; then echo "⑂ "; fi
}

function exit_code {
    local return_code="%(?..%F{red}%? %f)"
    echo $return_code
}


## prompt

setopt prompt_subst

if [ $SSH_CONNECTION ]; then SSH="%n@%m"; else SSH=""; fi

PROMPT='${SSH}$(git_prompt)$(prompt_char) '
RPROMPT='$(sh_level)$(exit_code)%~'
