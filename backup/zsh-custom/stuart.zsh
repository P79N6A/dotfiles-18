# export custom aliases and functions by stuart

#### export ####


# Android
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools"

# sdkman (install and manage java)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# ruby (for jekyll)
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion


#### functions ####


# shadowsocks 终端走代理，同时支持分享代理给手机
function startss() {
  export no_proxy="localhost,127.0.0.1,192.168.*.*,10.*.*.*,127.*.*.*,172.*.*.*"
  export http_proxy="http://127.0.0.1:1087"
  export https_proxy=$http_proxy
  echo -e "已开启 shadowsocks 终端代理 (端口：1087)"
  curl ip.gs
}
function stopss() {
  unset http_proxy
  unset https_proxy
  echo -e "已关闭 shadowsocks 终端代理"
  curl ip.gs
}
function showss() {
  curl ip.gs
}

# switch homebrew origin
function switch2aliyunbrew() {
  curPath=`pwd`
  # 替换 brew.git:
  cd "$(brew --repo)"
  git remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git
  # 替换 homebrew-core.git:
  cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
  git remote set-url origin https://mirrors.aliyun.com/homebrew/homebrew-core.git
  # 替换 homebrew-bottles:
  export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles
  # 应用生效
  brew update
  # show origin
  git remote -v
  echo "HOMEBREW_BOTTLE_DOMAIN: $HOMEBREW_BOTTLE_DOMAIN"
  cd $curPath
}
function switch2homebrew() {
  curPath=`pwd`
  # 重置 brew.git:
	cd "$(brew --repo)"
	git remote set-url origin https://github.com/Homebrew/brew.git
	# 重置 homebrew-core.git:
	cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
	git remote set-url origin https://github.com/Homebrew/homebrew-core.git
  # 重置 homebrew-bottles:
  unset HOMEBREW_BOTTLE_DOMAIN
  # 应用生效
  brew update
  # show origin
  git remote -v
  echo "HOMEBREW_BOTTLE_DOMAIN: $HOMEBREW_BOTTLE_DOMAIN"
  cd $curPath
}
function showbrew() {
  curPath=`pwd`
  cd "$(brew --repo)"
  # show origin
  git remote -v
  echo "HOMEBREW_BOTTLE_DOMAIN: $HOMEBREW_BOTTLE_DOMAIN"
  cd $curPath
}

# switch python version
function switch2python2() {
  rm -rf /usr/local/bin/python
  ln -s /usr/local/Cellar/python@2/2.7.16/Frameworks/Python.framework/Versions/2.7/bin/python2.7 /usr/local/bin/python
  easy_install-2.7 pip
  echo -e "\n当前 Python 版本："
  /usr/local/bin/python -V
  echo -e "当前 Python pip 版本："
  /usr/local/bin/pip -V
}
function switch2python3() {
  rm -rf /usr/local/bin/python
  ln -s /usr/local/Cellar/python/3.7.4/Frameworks/Python.framework/Versions/3.7/bin/python3.7 /usr/local/bin/python
  easy_install-3.7 pip
  echo -e "\n当前 Python 版本："
  /usr/local/bin/python -V
  echo -e "当前 Python pip 版本："
  /usr/local/bin/pip -V
}


#### alias ####


# flush dns cache (OS X v10.10.4 or high version)
alias cleardnscache="sudo killall -HUP mDNSResponder"

# dns test (dig and ping)
alias dnscheck="bash $HOME/.dotfiles/backup/zsh-custom/dnscheck.sh"

# brew daily
alias dailybrew="brew update && brew upgrade && brew cleanup && brew doctor"

# git simple
alias gitsimple="git add . && git commit -m \"repost\" && git push"

# genact (假装我很忙)
alias iambusy="genact -m mkinitcpio memdump simcity cryptomining"