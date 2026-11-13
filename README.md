# BlueArchive-Git 软件仓库 (Mirrors)

本仓库提供自建的 Debian/Ubuntu (APT) 和 Arch Linux (pacman) 软件源，由 BlueArchive-Git 和 alittleshark-dev 共同维护。

## 维护者 (Maintainers)

* **BlueArchive-Git** - 负责 APT 仓库维护
* **alittleshark-dev** - 负责 Arch Linux 仓库维护

## 免责声明 (Disclaimer)

本仓库中的软件包均来源于各自的官方上游或原作者，版权归原作者所有。我们仅提供构建脚本、包管理数据库及镜像分发服务。请自行评估使用第三方源的风险。

---

## Arch Linux 用户指南

### 1. 添加 GPG 密钥（可选，若使用 TrustAll 则跳过）

*注：如果你目前的配置是 `Optional TrustAll`，可以删掉这部分。*

### 2. 配置源

在 `/etc/pacman.conf` 文件末尾添加以下内容：

```ini
[bluearchive]
SigLevel = Optional TrustAll
Server = https://bluearchive-git.github.io/arch-mirror/x86_64
```

更新软件包

```
pacman -Sy
sudo pacman -S <Package Name>
```
Copyright © 2026 alittleshark-dev
