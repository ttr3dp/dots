bindkey -e
# History in cache directory:
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

# COLORS
autoload -U colors && colors
export CLICOLOR=1

# ASDF
# Must be set before completion (╯°□°)╯︵ ┻━┻
. /opt/asdf-vm/asdf.sh
fpath=(/opt/asdf-vm/completions $fpath)

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Bindings
bindkey '^ ' end-of-line
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word
bindkey '^k' up-line-or-history
bindkey '^j' down-line-or-history

# Set prompt
autoload -Uz promptinit && promptinit
local nl=$'\n%{\r%}';

autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{red}*'   # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr '%F{yellow}+'  # display this when there are staged changes
zstyle ':vcs_info:*' actionformats \
  ' %F{8}on %F{9} %F{5}%b%F{99}|%F{1}%a%c%u%f'
zstyle ':vcs_info:*' formats       \
    ' %F{8}on %F{9} %F{5}%b%c%u%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat ' %b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn
theme_precmd () {
    vcs_info
}

setopt prompt_subst
export PS1='%{%F{6}%}%0~${vcs_info_msg_0_}$nl%F{10}\$ %{$reset_color%}'
autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd

# FUZZY FINDER
# Use FZF
export FZF_COMPLETION_TRIGGER=',,'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='
--extended
--reverse
--color=fg:#A6B5C5,bg:-1,hl:#9ACD68
--color=fg+:#5DA713,bg+:-1,hl+:#CB96FF
--color=info:-1,prompt:-1,pointer:#EC5252
--color=marker:-1,spinner:-1,header:-1
'
. /usr/share/fzf/key-bindings.zsh
. /usr/share/fzf/completion.zsh
. $HOME/.local/bin/fzf_helpers

# Z (jump to dirs with speed of light)
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

#Aliases
# reload bash config file (~/.bashrc)
alias reload="source $ZDOTDIR/.zshrc && echo config reloaded!"

# shorten clear
alias clr="clear"

# colorize grep
alias grep="grep --color=auto"

# colorize ls
alias ls="exa --group-directories-first"

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

alias ppn="protonvpn"

# CONFIG FILES
# Xresources
alias xconf="nvim $XDG_CONFIG_HOME/X11/xresources"
# Zsh
alias zshconf="nvim $ZDOTDIR/.zshrc"
# Neovim
alias nvimconf="nvim ~/.config/nvim/init.vim"
alias vimconf="nvim ~/.config/nvim/init.vim"
# Fonts
alias fconf="nvim ~/.config/fontconfig/fonts.conf"
# Dotfiles
alias dots="/usr/bin/git --git-dir=$HOME/code/dots/ --work-tree=$HOME"

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

# fda - including hidden directories
fd() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

source /home/ttr3dp/code/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
