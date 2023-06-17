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

# edit command line
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^O" edit-command-line

if [ -f "$ASDF_DIR/asdf.sh" ]; then
    . "$ASDF_DIR/asdf.sh"
else
    printf 'asdf not installed!\n'
fi

# Set prompt
autoload -Uz promptinit && promptinit
local nl=$'\n%{\r%}';

autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{red}*'   # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr '%F{yellow}+'  # display this when there are staged changes
zstyle ':vcs_info:*' actionformats \
  ' %F{8}on %F{9}ᝄ %F{5}%b%F{99}|%F{1}%a%c%u%f'
zstyle ':vcs_info:*' formats       \
    ' %F{8}on %F{9} %F{5}%b%c%u%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat ' %b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn
theme_precmd () {
    vcs_info
}

setopt prompt_subst
export PS1='%{%F{4}%}%0~${vcs_info_msg_0_}$nl%F{10}\$ %{$reset_color%}'
autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd

# completion
autoload -U compinit; compinit
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

if [ -d /usr/share/z ]; then
    . /usr/share/z/z.sh
else
    printf 'rupa/z cannot be found in /usr/share/z\n'
fi


# GPG
export GPG_TTY=$(tty)

# Rootless docker
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

#Aliases
# general
alias \
  ls="ls --color=auto --group-directories-first" \
  cp="cp -iv" \
  rm="rm -vI" \
  mv="mv -iv" \
  mkd="mkdir -pv"

# reload sh config file
alias reload="echo \"reloading config...\" && exec ${SHELL}"

# always use neovim
alias vim="nvim"

# shorten pacman
alias p="sudo pacman"

# bluetooth
alias bt="bluetoothctl"

# shorten systemctl
alias SS="sudo systemctl"

# use single mpv ipc server
alias mpv="mpv --input-ipc-server=/tmp/mpvsoc$(date +%s)"

alias o="xdg-open"

# CONFIG FILES
# Xresources
alias xconf="${EDITOR} ${XDG_CONFIG_HOME}/Xresources"
# Zsh
alias shconf="${EDITOR} ${HOME}/.zshrc"
# Neovim
alias nvimconf="${EDITOR} ~/.config/nvim/init.vim"
alias vimconf="${EDITOR} ~/.config/nvim/lua/ttr3dp/init.lua"
# tmux
alias tconf="${EDITOR} ~/.config/tmux/tmux.conf"
# Fonts
alias fconf="${EDITOR} ~/.config/fontconfig/fonts.conf"
# Dotfiles
alias dots="/usr/bin/git --git-dir=${HOME}/code/dots/ --work-tree=${HOME}"
# tremc (ignore transmission version mismatch)
alias tremc="tremc -X"

# docker compose
alias dc="docker-compose"
alias dcb="dc build"
alias dcr="dc run"
alias dce="dc exec"
alias dcd="dc down"
alias dcu="dc up"
alias dcbup="dc down && dc build && dc up app"
alias dcps="dc ps"
alias dclg="dc logs"

alias rs="bundle exec rails s"
alias rr="bundle exec rails routes"
alias rc="bundle exec rails c"
alias rdm="bundle exec rails db:migrate"
alias rdr="bundle exec rails db:rollback"
alias rdc="bundle exec rails db:create"
alias rdd="bundle exec rails db:drop"
alias rds="bundle exec rails db:seed"

mkcd(){
  mkdir -pv "$1" && cd "$1"
}
