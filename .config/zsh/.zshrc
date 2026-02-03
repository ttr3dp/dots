bindkey -e

HISTFILE="$XDG_CACHE_HOME/zsh/history" # History in cache directory
HISTSIZE=10000000
SAVEHIST=10000000
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt completeinword
setopt prompt_subst
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH
autoload -U add-zsh-hook
# COLORS
autoload -U colors && colors
export CLICOLOR=1

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^[[Z' reverse-menu-complete # this should be the default damn it!

# edit command line
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^O" edit-command-line

# Set prompt
autoload -Uz promptinit && promptinit

parse_git_branch() {
    printf "%s" "$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's~* \(.*\)~\1~')"
}
parse_git_changes() {
  [ -n "$(git status --porcelain)" ] && printf "*"
}
vcs_info() {
  printf "%s%s" "$(parse_git_branch)" "$(parse_git_changes)"
}
extra_ps1_info() {
    git rev-parse > /dev/null 2>&1 && vcs_info
}

theme_precmd () {
    extra_ps1_info
}

export PS1='%{%F{6}%}%0~ %F{5}$(extra_ps1_info)%F{2}❯%{$reset_color%} '

fpath=(${ASDF_DATA_DIR}/completions $fpath)

# completion
autoload -U compinit; compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"
_comp_options+=(globdots)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1

# fzf
export FZF_COMPLETION_TRIGGER=',,'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS="--reverse"

if [ -d /usr/share/fzf ]; then
    . /usr/share/fzf/completion.zsh
    . /usr/share/fzf/key-bindings.zsh
else
    printf 'FZF completions and key bindings cannot be found in /usr/share/fzf\n'
fi

# z.lua
eval "$(lua $USER_OPT_DIR/z.lua/z.lua --init zsh)"

# GPG
export GPG_TTY=$(tty)

# Rootless docker
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
# ASDF
export PATH="$ASDF_DATA_DIR/shims:$PATH"

#Aliases
# general
alias \
  ls="ls --color=auto --group-directories-first" \
  cp="cp -iv" \
  rm="rm -iv" \
  mv="mv -iv" \
  mkd="mkdir -pv"

alias vim="nvim"
alias vimconf="${EDITOR} ${XDG_CONFIG_HOME}/nvim/init.vim"

# reload sh config file
alias reload="echo \"reloading config...\" && exec ${SHELL}"

# shorten xbps
alias xi="sudo xbps-install"
alias xq="sudo xbps-query"
alias xr="sudo xbps-remove"

# bluetooth
alias bt="bluetoothctl"

alias o="xdg-open"

# CONFIG FILES
# Xresources
alias xconf="${EDITOR} ${XDG_CONFIG_HOME}/Xresources"
# Zsh
alias shconf="${EDITOR} ${ZDOTDIR}/.zshrc"

mkcd(){
  mkdir -pv "$1" && cd "$1"
}

source "$HOME"/code/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
