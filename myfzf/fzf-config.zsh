# #! /usr/bin/zsh 

export RUNEWIDTH_EASTASIAN=0
export FZF_DEFAULT_OPTS="--preview 'zsh /opt/fzf-tab/myfzf/file_preview.zsh {}' --height 30 --layout=reverse --history=/home/lingguang/.fzfhistory"
export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.vscode,.node_modules,bulid,dist,vender,mnt} --type f --type l" # 


# my
zstyle ':completion:complete:*:options' sort false
zstyle ':fzf-tab:complete:cd:*' query-string input
zstyle ':completion:*:descriptions' format "[%d]"
zstyle ':fzf-tab:*' group-colors $'\033[15m' $'\033[14m' $'\033[33m'$'\033[35m' $'\033[15m' $'\033[14m' $'\033[33m'$'\033[35m'
zstyle ':fzf-tab:*' prefix ''
zstyle ':fzf-tab:complete:*:*' fzf-preview 'zsh /opt/fzf-tab/myfzf/file_preview.zsh ${(Q)realpath}'
zstyle ':fzf-tab:complete:*:*' fzf-flags --height=30
zstyle ':fzf-tab:complete:yay:*' fzf-preview 'yay -Qi $word || yay -Si $word'
zstyle ':fzf-tab:complete:pacman:*' fzf-preview 'pacman -Qi $word || pacman -Si $word'
# man
zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'

# 显示系统设备状态
zstyle ':fzf-tab:complete:systemctl:*' fzf-flags --preview-window=down:0:wrap
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'


# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath' # remember to use single quote here!!!

# [kill/ps] 完整命令行参数预览
# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap


# git
# it is an example. you can change it
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff --color=always $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview 'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview 'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'


# TLDR
# zstyle ':fzf-tab:complete:tldr:*' fzf-preview 'tldr --color always $word'
# zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'

# 要禁用或覆盖命令选项和子命令的预览，请使用
# zstyle ':fzf-tab:complete:*:options' fzf-preview 
# zstyle ':fzf-tab:complete:*:argument-1' fzf-preview

# 环境变量
# zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
# 	fzf-preview 'echo ${(P)word}'


# Homebrew
# zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'



# Commands
# zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
# ¦ '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "${(P)word}"'

# 使用拼音补全
# zstyle ':fzf-tab:user-expand:*' fzf-preview 'less ${(Q)word}'