#!/bin/bash

pkgname="fzf-tab-source"
zshrc_file="$HOME/.zshrc"
append_content="source /opt/fzf-tab-source/fzf-tab.plugin.zsh"

if grep -q "$append_content" "$zshrc_file"; then
	echo "Content already exists in $zshrc_file. Skipping..."
else
	echo "$append_content" >>"$zshrc_file"
	echo "Content appended to $zshrc_file"
fi

# 运行source ~/.zshrc
source "$zshrc_file"
