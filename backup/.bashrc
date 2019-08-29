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