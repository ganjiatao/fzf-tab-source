#!/bin/bash

# zshrc_file="$HOME/.zshrc"
fzf_config="source /opt/fzf-tab-source/fzf-tab.plugin.zsh"
# export fzf_config="source $PWD/fzf-tab.plugin.zsh"
helpinfo="  fzf-tab-source用法:
    -a, --add           添加配置/Add Configuration
    -c, --content       配置内容/Configuration Content
    -d, --delete        删除配置/Delete Configuration
    -v, --version       版本信息/Print program version
    -h, --help          帮助信息/Display this help list"
if [[ $1 == "-a" || $1 == "--add" ]]; then
    if grep -q "$fzf_config" "$HOME/.zshrc"; then
        echo "Configuration already exists in $HOME/.zshrc. Skipping..."
    else
        echo "$fzf_config" >>"$HOME/.zshrc"
        echo "Configuration appended to $HOME/.zshrc"
        exec zsh -l
    fi
elif [[ $1 == "-c" || $1 == "--content" ]]; then
    echo "\"$fzf_config\""
elif [[ $1 == "-d" || $1 == "--delete" ]]; then
    if grep -q "$fzf_config" "$HOME/.zshrc"; then
        sed -i "/$(echo "$fzf_config" | sed 's/\//\\\//g')/d"  "$HOME/.zshrc"
        echo "Configuration removed from $HOME/.zshrc"
        exec zsh -l
    else
        echo "Content not exists in $HOME/.zshrc. Skipping..."
    fi
elif [[ $1 == "-h" || $1 == "--help" ]]; then
    echo "$helpinfo"
elif [[ $1 == "-v" || $1 == "--version" ]]; then
    echo "v1.0.0"
else
    echo "Option error"
    echo "$helpinfo"
fi