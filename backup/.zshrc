# zsh, oh-my-zsh, antigen setup for mac
# on mac you need to install:
# brew install zsh antigen

# antigen (manager plugins)
source /usr/local/share/antigen/antigen.zsh

# add /usr/local/sbin to path
export PATH="/usr/local/sbin:$PATH"

# language environment
export LC_ALL=zh_CN.UTF-8
export LANG=zh_CN.UTF-8

# Load the oh-my-zsh's library
antigen use oh-my-zsh

# bundle antigen zsh plugins @ https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins
antigen bundles <<EOBUNDLES
	common-aliases
	history 
	git 
    osx 
    extract 
	zsh_reload 
	z 
    ssh-agent
    sublime 
    zsh_reload 
	zsh-users/zsh-completions
	zsh-users/zsh-autosuggestions
    unixorn/autoupdate-antigen.zshplugin
EOBUNDLES

# Load the theme @ https://github.com/robbyrussell/oh-my-zsh/tree/master/themes/
# default theme robbyrussell
antigen theme robbyrussell
# simple and fast theme steeef
# antigen theme steeef
# cool but slow theme
# antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship

# syntax highlighting must come below the bundle to set the correct paths/variables with history search
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

# Tell antigen that you're done
antigen apply

# bind keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Extra zsh variables - history, auto-completion etc...
HISTFILE=~/.zsh_history         # where to store zsh config
HISTSIZE=10240000               # big history
SAVEHIST=10240000               # big history
LISTMAX=999999

# auto-completion with selection / menu / error correction / cache / etc...
zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*' verbose true
zstyle ':completion:*' menu yes select=1
zstyle ':completion:*' substitute 0
zstyle ':completion:*' max-errors 2 not-numeric
zstyle ':completion:*' original true
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path ~/.zsh/cache              
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' file-sort links reverse
zstyle ':completion:*:commands' rehash true
zstyle ':completion:*:functions' ignored-patterns '_*'

zstyle ':completion:*' completer _expand _complete _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' matcher-list '' '+m:{a-z}={A-Z} r:|[._-]=* r:|=*' '' 'l:|=* r:|=*'
zstyle ':completion:*:messages' format $'\e[00;31m%d'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==36=36}:${(s.:.)LS_COLORS}")';

zstyle ':filter-select:highlight' matched fg=red
zstyle ':filter-select' max-lines 1000
zstyle ':filter-select' rotate-list yes
zstyle ':filter-select' case-insensitive yes # enable case-insensitive search

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ssh-agent config
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa2 id_github

# some exports for colors, editor, pager and less
export LSCOLORS='exfxcxdxbxegedabagacad'
export CLICOLOR=true
export SUBLIME=subl
export EDITOR="$SUBLIME -w"
export VISUAL=$EDITOR
export TERM="xterm-256color"
export PAGER='less'
export LESS='-giAMR'

# 消除历史记录中的重复条目
setopt HIST_IGNORE_DUPS
# 假如目前的历史记录中已经有重复条目，可以运行下面的命令清除：
#$ sort -t ";" -k 2 -u ~/.zsh_history | sort -o ~/.zsh_history

# User configuration

# shell-integration (scp upload and download)
[[ -s "$HOME/.dotfiles/backup/zsh-custom/iterm2_shell_integration.zsh" ]] && source "$HOME/.dotfiles/backup/zsh-custom/iterm2_shell_integration.zsh"

# Load local sh, export, custom aliases and functions, for example export GOPATH, export JAVA_HOME, export ANDROID_SDK, aliase, function, etc...
[[ -s "$HOME/.dotfiles/backup/zsh-custom/stuart.zsh" ]] && source "$HOME/.dotfiles/backup/zsh-custom/stuart.zsh"

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
