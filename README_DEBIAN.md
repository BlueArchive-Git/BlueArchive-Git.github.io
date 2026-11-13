# BlueArchive-Git 软件仓库 (Mirrors)

本仓库提供自建的 Debian/Ubuntu (APT) 和 Arch Linux (pacman) 软件源，由 BlueArchive-Git 和 alittleshark-dev 共同维护。

## 维护者 (Maintainers)

* **BlueArchive-Git** - 负责 APT 仓库维护
* **alittleshark-dev** - 负责 Arch Linux 仓库维护

## 免责声明 (Disclaimer)

本仓库中的软件包均来源于各自的官方上游或原作者，版权归原作者所有。我们仅提供构建脚本、包管理数据库及镜像分发服务。请自行评估使用第三方源的风险。

---

## Debian GNU/Linux & Termux APT Bootstrap 用户指南

### 1. 添加 GPG 密钥（可选，若使用 trusted=yes 则跳过）
```bash
curl -fsSL https://bluearchive-git.github.io/apt-mirror/bluearchive-git.gpg.key | gpg --dearmor -o $PREFIX/etc/apt/trusted.gpg.d/bluearchive-git.gpg
```

### 2. 配置源

在 APT 源文件末尾添加以下内容：

```text
deb https://bluearchive-git.github.io/apt-mirror/ suite main
```

*注：Debian GNU/Linux 系发行版用户需要使用 sudo，而且要去掉路径的 $PREFIX，suite 字段自行修改（debian/termux）

更新软件包

```
sudo apt update
sudo apt install <Package Name>
```
Copyright © 2026 BlueArchive-Git
