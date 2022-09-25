#!/bin/sh
# Profile file. Runs on login.

export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

# XDG
export EDITOR="nvim"
export TERMINAL="st"
export READER="zathura"
export FILE="lf"
export BROWSER="librewolf"
export BROWSERCLI="w3m"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DESKTOP_DIR="$HOME/desk"
export XDG_DOCUMENTS_DIR="$HOME/dox"
export XDG_DOWNLOAD_DIR="$HOME/down"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_PICTURES_DIR="$HOME/pix"
export XDG_VIDEOS_DIR="$HOME/vids"

export XAUTHORITY="$XDG_DATA_HOME/Xauthority"

export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/asdfrc"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME=".config/asdf/tool-versions"
export ASDF_GEM_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/asdf/default-gems"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="$XDG_CACHE_HOME/lesshst"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export _Z_DATA="$XDG_DATA_HOME/z"

export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_PACKAGES="$XDG_DATA_HOME/npm/.npm-packages"

export CARGO_HOME="$XDG_DATA_HOME/cargo"

export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_CONFIG_HOME/bundle"
export GEMRC="$XDG_CONFIG_HOME/.gemrc"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"

export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"

export GOPATH="$XDG_DATA_HOME/go"

export PATH="$GOPATH/bin:$NPM_PACKAGES/bin:$PATH"

__GL_SHADER_DISK_CACHE="0"

export ADB_KEYS_PATH="$ANDROID_PREFS_ROOT"
export ADB_VENDOR_KEY="$XDG_CONFIG_HOME/android"
export ANDROID_PREFS_ROOT="$XDG_CONFIG_HOME"/android
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"

export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/.notmuch-config"

# Start graphical server if one is not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg > /dev/null && exec startx

# Switch escape and caps if tty:
sudo -n loadkeys ~/.config/ttymaps.kmap 2> /dev/null
