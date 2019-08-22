# custom aliases and functions by stuart

#### export ####


# Android
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH"


#### functions ####


# shadowsocks 终端走代理，同时支持分享代理给手机
function startss() {
  export no_proxy="localhost,127.0.0.1,192.168.*.*,10.*.*.*,127.*.*.*,172.*.*.*"
  export http_proxy="http://127.0.0.1:1087"
  export https_proxy=$http_proxy
  echo -e "已开启 shadowsocks 终端代理"
  curl ip.gs
}
function stopss(){
    unset http_proxy
    unset https_proxy
    echo -e "已关闭 shadowsocks 终端代理"
    curl ip.gs
}

# switch python version
function switch2python2() {
  sudo rm -rf /usr/local/bin/python
  sudo ln -s /usr/local/Cellar/python@2/2.7.16/Frameworks/Python.framework/Versions/2.7/bin/python2.7 /usr/local/bin/python
  sudo easy_install-2.7 pip
  echo -e "\n当前 Python 版本："
  /usr/local/bin/python -V
  echo -e "当前 Python pip 版本："
  /usr/local/bin/pip -V
}
function switch2python3() {
  sudo rm -rf /usr/local/bin/python
  sudo ln -s /usr/local/Cellar/python/3.7.4/Frameworks/Python.framework/Versions/3.7/bin/python3.7 /usr/local/bin/python
  sudo easy_install-3.7 pip
  echo -e "\n当前 Python 版本："
  /usr/local/bin/python -V
  echo -e "当前 Python pip 版本："
  /usr/local/bin/pip -V
}


#### alias ####


# brew daily
alias dailybrew="brew update && brew upgrade && brew cleanup && brew doctor"

# git simple
alias gitsimple="git add . && git commit -m \"repost\" && git push"

# genact(假装我很忙)
alias iambusy="genact -m mkinitcpio memdump simcity cryptomining"