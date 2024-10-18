#! /bin/sh
# Short script to quickly unpack dotfiles without homeshick

shopt -s dotglob
mv -fbv ./home/* ~/
echo "Dotfiles unpacked"
