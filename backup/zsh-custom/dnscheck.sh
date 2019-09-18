#!/usr/bin/env bash

declare -a local_dns_server_ip
declare -a target_dns_server_ip

# 国外公共 dns 服务器
opendns_dns_server_ip=(
    "208.67.222.222"
    "208.67.220.220"
)
cloudflare_dns_server_ip=(
    "1.0.0.1"
    "1.1.1.1"
)
google_dns_server_ip=(
    "8.8.8.8"
    "8.8.4.4"
)

# 国内公共 dns 服务器
ali_dns_server_ip=(
    "223.5.5.5"
    "223.6.6.6"
)
dnspod_dns_server_ip=(
    "119.29.29.29"
)
ustc_dns_server_ip=(
    "202.141.160.110"
    "202.141.176.110"
)

# 默认 dns 查询次数，如需自定义，可在第二个参数中指定
count=5

# 默认 ping 次数，如需自定义，可在第三个参数中指定
pingCount=5

function verify() {
    if [ "${#domain}" -eq 0 ]; then
        printf "\n"
        echo "域名为空，请正确输入域名"
        printf "\n"
        exit
    fi
    local result=$(echo $domain | grep "\.")
    if [ "$result" = "" ]; then
        printf "\n"
        echo "请正确输入域名 (形如: baidu.com)"
        printf "\n"
        exit
    fi
    expr $count "+" 10 &>/dev/null
    if [ $? -ne 0 ]; then
        printf "\n"
        echo "请正确输入 DNS 查询次数 (仅接受数字)"
        printf "\n"
        exit
    fi
    expr $pingCount "+" 10 &>/dev/null
    if [ $? -ne 0 ]; then
        printf "\n"
        echo "请正确输入 Ping 次数 (仅接受数字)"
        printf "\n"
        exit
    fi
}

function is_ipv6() {
    local ip=$1
    local result=$(echo "$ip" | grep "[a-zA-Z]")
    if [ "$result" = "" ]; then
        return 1
    else
        return 0
    fi
}

function isValidIP() {
    # From @https://blog.csdn.net/butterfly5211314/article/details/83095330
    local ip=$1
    local ret=1
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        ip=(${ip//\./ }) # 按.分割，转成数组，方便下面的判断
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        ret=$?
    fi
    return $ret
}

function local_dns() {
    local result=$(cat /etc/resolv.conf | grep "nameserver" | sed 's/nameserver //g')
    local_dns_server_ip=($result)
}

function spinner() {
    local pid=$!
    local delay=0.2
    local spinstr='.'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf "\033[0;34m%s \033[0;39m" "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b"
    done
}

function execute_ping() {
    printf "\033[0;34m    Ping $ip \033[0;39m"
    speed=$(ping $ip -c $pingCount | grep "min/avg/max")
    wait
    if [ "$speed" = "" ]; then
        printf "\nPing 结果: 失败\n"
    else
        printf "\nPing 结果: "
        printf "$speed\n"
    fi
}

function ping_check() {
    local args=($1)
    local speed
    for ip in ${args[*]}; do
        isValidIP $ip
        if [ $? -eq 0 ]; then
            execute_ping &
            spinner
            wait
        fi
    done
}

function public_check() {
    local index
    local dig_result
    local dig_result_short
    for ip in ${target_dns_server_ip[@]}; do
        printf "\n  \033[0;32mDNS 服务器: $ip\033[0m\n"
        for ((i = 0; i < $count; i++)); do
            index=$(expr $i + 1)
            if is_ipv6 $ip; then
                printf "\n    第 $index 次查询 - dig AAAA @$ip $domain\n\n"
                dig_result=$(dig AAAA @$ip $domain)
                dig_result_short=$(dig AAAA @$ip $domain +short)
            else
                printf "\n    第 $index 次查询 - dig @$ip $domain\n\n"
                dig_result=$(dig @$ip $domain)
                dig_result_short=$(dig @$ip $domain +short)
            fi
            pretty_dig "$dig_result"
            ping_check "$dig_result_short"
        done
    done
}

function pretty_dig() {
    local result=$1
    printf "$result" | grep "SERVER" | sed 's/;; SERVER/服务器/g'
    printf "$result" | grep "Query time" | sed 's/;; Query time/耗时/g' | sed 's/msec/毫秒/g'
    printf "解析结果: \n"
    printf "$result" | grep "IN" | grep -v '^;'
}

# 开始查询
if [ "$#" -eq 0 ]; then
    printf "\n"
    read -p "请输入域名 (如 baidu.com): " domain
    verify
    read -p "请输入 DNS 查询次数: " count
    verify
    read -p "请输入 Ping 次数: " pingCount
    verify
elif [ "$#" -eq 1 ]; then
    domain=$1
    verify
elif [ "$#" -eq 2 ]; then
    domain=$1
    count=$2
    verify
elif [ "$#" -eq 3 ]; then
    domain=$1
    count=$2
    pingCount=$3
    verify
else
    printf "\n"
    echo "参数错误 (正确格式形如: bash dnscheck.sh baidu.com 10)"
    printf "\n"
    exit
fi

printf "\n要测试的域名为: $domain\n\n"

# 本地查询
local_dns
target_dns_server_ip=(${local_dns_server_ip[@]})
printf "\n\033[0;31m本地 DNS 查询结果 (${local_dns_server_ip[*]}):\n"
public_check

# 阿里 DNS 查询
target_dns_server_ip=(${ali_dns_server_ip[@]})
printf "\n\033[0;31m阿里 DNS 查询结果 (${target_dns_server_ip[*]}):\n"
public_check

# 腾讯 DNS 查询
target_dns_server_ip=(${dnspod_dns_server_ip[@]})
printf "\n\033[0;31m腾讯 DNS 查询结果 (${dnspod_dns_server_ip[*]}):\n"
public_check

# 中科大 DNS 查询
target_dns_server_ip=(${ustc_dns_server_ip[@]})
printf "\n\033[0;31m中科大 DNS 查询结果 (${ustc_dns_server_ip[*]}):\n"
public_check

# OpenDNS DNS 查询
target_dns_server_ip=(${opendns_dns_server_ip[@]})
printf "\n\033[0;31mOpenDNS DNS 查询结果 (${opendns_dns_server_ip[*]}):\n"
public_check

# Cloudflare DNS 查询
target_dns_server_ip=(${cloudflare_dns_server_ip[@]})
printf "\n\033[0;31mCloudflare DNS 查询结果 (${cloudflare_dns_server_ip[*]}):\n"
public_check

# Google DNS 查询
target_dns_server_ip=(${google_dns_server_ip[@]})
printf "\n\033[0;31mGoogle DNS 查询结果 (${google_dns_server_ip[*]}):\n"
public_check

printf "\n\n测试结束\n\n"
