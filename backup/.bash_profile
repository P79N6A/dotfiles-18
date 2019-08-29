# make bash colorful
export TERM="xterm-256color"
export CLICOLOR=1
export LSCOLORS=gxfxaxdxcxegedabagacad
# pager and less
export PAGER='less'
export LESS='-giAMR'

# load bashrc
[[ -s ~/.bashrc ]] && source ~/.bashrc