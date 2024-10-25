#! /bin/bash
# Short script to quickly unpack dotfiles without homeshick

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
shopt -s dotglob
mv -fbv $SCRIPT_DIR/home/* ~/
echo "Dotfiles unpacked"
