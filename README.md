# dotfiles

Mac 使用的 dotfiles，用于重装系统时快速恢复开发环境。

Step By Step:

1. 抹盘重装系统
2. Terminal - `curl "https://raw.githubusercontent.com/stuarthua/dotfiles/master/bootstrap" | bash`
3. iTerm2 - `curl "https://raw.githubusercontent.com/stuarthua/dotfiles/master/revert-all" | bash`
4. 同步个人数据

## 准备

备份数据，如照片、视频、资料等。

## 使用

### 执行 bootstrap

打开系统 Terminal，执行：

```bash
$ curl "https://raw.githubusercontent.com/stuarthua/dotfiles/master/bootstrap" | bash
```

关闭 Terminal。

#### bootstrap 做的事

* 安装 CommandLineTools
* 安装 Homebrew
* 设置 Mac HostName
* 使用 Homebrew 安装 iTerm2, shadowsocksx-ng, zsh, antigen, mas, mackup
* 配置 zsh 为默认 shell，配置 `~/.zshrc`
* 克隆 stuarthua/dotfiles 至 `~/.dotfiles`
* 使用 mackup 恢复 dotfiles
* 重载 zsh 配置

dotfiles 列表：

* bash
* vim
* mackup
* sublime-text-3
* iterm2
* alfred
* android-studio
* antigen
* git
* proxifier
* shadowsocksx-ng
* snipaste
* ssh
* zsh

> 说明：vscode 的同步，使用 Setting Sync 插件

### 执行 revert-all

打开 iTerm2，执行：

```bash
$ curl "https://raw.githubusercontent.com/stuarthua/dotfiles/master/revert-all" | bash
```

#### revert-all 做的事

* 使用 Homebrew 恢复备份的软件
* 配置 macos 常用设置
* 设置 work 目录

macos 常用设置：

* 触摸板 - 轻点来点按
* 触摸板 - 三指拖拽
* Finder - 默认标签页打开桌面
* Finder - 显示所有文件拓展名
* Finder - 显示状态栏、路径栏
* Finder - 排序时，文件夹显示在前
* Finder - 默认搜索当前文件夹
* 锁屏 - 睡眠或显示屏保时需要输入密码的时间：立即
* 触发角 - 左下角关闭屏幕
* 键盘 - 允许全键盘控制
* 键盘 - F1、F12 作为标准按键
* 显示电池百分比
* 状态栏显示输入法
* U 盘上禁止生成 `.DS_Store` 文件
* 禁用文字自动纠正

### 恢复个人数据

如照片、视频、资料等。

## 参考

* [zsh-users/antigen](https://github.com/zsh-users/antigen)
* [lra/mackup](https://github.com/lra/mackup)
* [unixorn/awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins)
* [herrbischoff/awesome-macos-command-line](https://github.com/herrbischoff/awesome-macos-command-line)
* [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [crispgm/dotfiles](https://github.com/crispgm/dotfiles)
* [blakeembrey/dotfiles](https://github.com/blakeembrey/dotfiles)
* [bestswifter/macbootstrap](https://github.com/bestswifter/macbootstrap)