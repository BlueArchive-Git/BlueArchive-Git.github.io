# BlueArchive-Git Mirrors | 软件仓库

> This repository provides self-hosted Debian/Ubuntu (APT) and Arch Linux (pacman) package mirrors, jointly maintained by BlueArchive-Git and alittleshark-dev.
本仓库提供自建的 Debian/Ubuntu (APT) 和 Arch Linux (pacman) 软件源，由 BlueArchive-Git 和 alittleshark-dev 共同维护。

## Maintainers | 维护者

* **BlueArchive-Git** - APT repository maintenance (负责 APT 仓库维护)
* **alittleshark-dev** - Arch Linux repository maintenance (负责 Arch Linux 仓库维护)

## Disclaimer | 免责声明

All software packages in this repository originate from their respective upstream projects or original authors. All copyrights belong to their respective owners. We only provide build scripts, package databases, and mirror distribution services. Please evaluate the risks of using third-party repositories at your own discretion.

本仓库中的软件包均来源于各自的官方上游或原作者，版权归原作者所有。我们仅提供构建脚本、包管理数据库及镜像分发服务。请自行评估使用第三方源的风险。

---

# Adding the Repository | 添加软件源

## 1. Add GPG Key | 添加 GPG 密钥

### Debian GNU/Linux (Optional | 可选)
*Skip if using `trusted=yes` (若使用 `trusted=yes` 则跳过)*


```bash
curl -fsSL https://bluearchive-git.github.io/apt-mirror/bluearchive-git.gpg.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/bluearchive-git.gpg
```

### Termux (Optional | 可选)
*Skip if using `trusted=yes` (若使用 `trusted=yes` 则跳过)*


```bash
curl -fsSL https://bluearchive-git.github.io/apt-mirror/bluearchive-git.gpg.key | gpg --dearmor -o $PREFIX/etc/apt/trusted.gpg.d/bluearchive-git.gpg
```


### Arch Linux (Optional | 可选)
*Skip if `SigLevel = Optional TrustAll` is used.*
*(如果你目前的配置是 `Optional TrustAll`，可以跳过这部分。)*

## 2. Configure the Source | 配置源

### Debian GNU/Linux & Termux

Append the following line to your APT sources file (在 APT 源文件末尾添加以下内容):

```bash
deb https://bluearchive-git.github.io/apt-mirror/ suite main
```


> **Note | 注：**
> * For Debian GNU/Linux users, maybe you should use `sudo`.
> * Replace the `suite` field with your appropriate release codename (e.g., `debian` or `termux`).
> * Debian 用户在修改配置文件时可能需要 `sudo` ，请自行将 `suite` 字段修改为对应的代号（如 `debian` 或 `termux`）。

### Arch Linux

Append the following lines to the end of `/etc/pacman.conf` (在 `/etc/pacman.conf` 文件末尾添加以下内容):

```conf
[bluearchive]
SigLevel = Optional TrustAll
Server = https://bluearchive-git.github.io/arch-mirror/x86_64
```


## 3. Update Package Lists | 更新软件包

### Debian GNU/Linux

```bash
sudo apt update
sudo apt install <package-name>
```

### Termux

```bash
pkg update
pkg install <package-name>
```

### Arch Linux

```bash
sudo pacman -Sy
sudo pacman -S <package-name>
```


---
*Copyright © 2026 BlueArchive-Git, alittleshark-dev. All software packages are copyright of their respective owners.*
