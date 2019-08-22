# dotfiles

Mac 使用的 dotfiles，用于重装系统时快速恢复开发环境。

Step By Step:

1. 重装系统后，安装 ShadowsocksX-NG
2. Terminal - `curl -s https://raw.githubusercontent.com/stuarthus/dotfiles/master/bootstrap | bash`
3. iTerm2 - `curl -s https://raw.githubusercontent.com/stuarthus/dotfiles/master/revert-all | bash`
4. 同步个人数据

## 准备

### 备份 ShadowsocksX-NG

在 iCloud 中备份 `ShadowsocksX-NG`：

* 存储一个可用版本的 `ShadowsocksX-NG`，下载地址：[ShadowsocksX-NG/release](https://github.com/shadowsocks/ShadowsocksX-NG/releases)
* 备份 `ShadowsocksX-NG` 配置文件，路径为：`~/Library/Preferences/com.qiuyuzhou.ShadowsocksX-NG.plist`
* 备份 `user-rule.txt` 规则文件，路径为 `~/.ShadowsocksX-NG/user-rule.txt`
* 还原脚本 `revert-shadowsocks.sh`

备份目录：

```
├── ShadowsocksX-NG
    ├── com.qiuyuzhou.ShadowsocksX-NG.plist
    ├── user-rule.txt
    └── revertShadowsocks.sh
```

`revert-shadowsocks.sh`：

```bash
#!/usr/bin/env bash

cp -f com.qiuyuzhou.ShadowsocksX-NG.plist ~/Library/Preferences/com.qiuyuzhou.ShadowsocksX-NG.plist
cp -f user-rule.txt ~/.ShadowsocksX-NG/user-rule.txt
ehco "Successful revert ShadowsocksX-NG."
```

### 备份 SSH 配置

在 iCloud 中备份 SSH 配置（默认配置目录 `~/.ssh`）。

备份目录：

```
├── ssh
    ├── config
    ├── id_rsa
    ├── id_rsa.pub
    └── revert-sshconfig.sh
```

`revert-sshconfig.sh`：

```bash
#!/usr/bin/env bash

mkdir ~/.ssh
cp -f config ~/.ssh/config
cp -f id_rsa ~/.ssh/id_rsa
cp -f id_rsa.pub ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/config
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
ehco "Successful revert ssh-configs."
```

### 备份其他数据

如照片、视频、资料等。

## 使用

### 恢复 ShadowsocksX-NG

抹盘重装系统后，首先安装 iCloud 中备份的 `ShadowsocksX-NG`，并运行恢复脚本 `revert-shadowsocks.sh`：

```bash
$ sh revert-shadowsocks.sh
```

确认 Mac 可以正常 `联网/翻墙`。

### 执行 bootstrap

打开系统 Terminal，执行：

```bash
$ curl -s https://raw.githubusercontent.com/stuarthus/dotfiles/master/bootstrap | bash
```

关闭 Terminal。

#### bootstrap 做的事

* 安装 CommandLineTools
* 设置 Mac HostName
* 安装 Homebrew
* 使用 Homebrew 安装 iTerm2, zsh, antigen
* 克隆 stuarthua/dotfiles 至 `~/.dotfiles`
* 配置 zsh 为默认 shell，配置 `~/.zshrc`
* 配置 `~/.bashrc`, `~/.bash_profile`

### 执行 revert-all

打开 iTerm2，执行：

```bash
$ curl -s https://raw.githubusercontent.com/stuarthus/dotfiles/master/revert-all | bash
```

#### revert-all 做的事

* 使用 Homebrew 恢复备份的软件
* 使用 mackup 恢复备份的 dotfiles
* 配置 macos 常用设置
* 设置 work 目录

dotfiles 列表：

* iterm2

macos 常用设置：

* 触摸板
* 三只切换

### 恢复个人数据

#### 恢复 SSH 配置

iCloud，运行恢复脚本 `revert-sshconfig.sh`：

```bash
$ sh revert-sshconfig.sh
```

#### 恢复其他数据

从备份源中取回备份的数据（照片、视频、资料等）

## 参考

* [mackup]()
* []()
* []()