#!/bin/sh
# stupid, but it works
#
# Usage:
#
#    $ ./install.sh

link_dir_to_home() {
    for file in $1/* ; do
        [ -e "$file" ] || [ -L "$file" ] || continue
        ln --backup=existing --symbolic --verbose "$(pwd)/${file}" "${HOME}/${1}/"
    done

}

link_file_to_home() {
    ln --backup=existing --symbolic --verbose "$(pwd)/${1}" "${HOME}/${2}"

}

link_dir_to_home .config
link_dir_to_home .local/bin
link_dir_to_home .local/share
link_file_to_home .profile
link_file_to_home .profile .zprofile
link_file_to_home .zshrc
