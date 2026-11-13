BlueArchive-Git Arch Linux 软件仓库

维护者：@alittleshark-dev

【维护者操作指南】
1. 构建软件包：
   makepkg -s

2. 将生成的 .pkg.tar.zst 文件放入 arch-mirror/x86_64/ 目录，然后更新数据库：
   cd arch-mirror/x86_64
   repo-add -n -R bluearchive.db.tar.gz *.pkg.tar.zst

3. 运行 gen-index.sh 生成 HTML 页面 ：
   ./gen-index.sh

4. 提交并推送：
   git add arch-mirror/x86_64
   git commit -m "feat(arch): update packages"
   git push

【用户使用指南】
在 /etc/pacman.conf 文件末尾添加以下内容：
[bluearchive]
SigLevel = Optional TrustAll
Server = https://bluearchive-git.github.io/arch-mirror/x86_64

然后更新本地包数据库：
sudo pacman -Sy
