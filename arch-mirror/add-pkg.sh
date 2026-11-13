#!/bin/bash
# Copyright © 2026 alittleshark-dev
# 自动添加包到 arch-mirror
# 用法: ./add-pkg.sh <包路径>
set -euo pipefail

PKG="$1"
[ -z "${PKG:-}" ] && { echo "用法: $0 <包文件.pkg.tar.zst>"; exit 1; }
[ -f "$PKG" ] || { echo "错误: 文件不存在: $PKG"; exit 1; }

SELF_DIR="$(cd "$(dirname "$0")" && pwd)"     # arch-mirror/
MIRROR="$SELF_DIR/x86_64"
GIT_ROOT="$(git -C "$SELF_DIR" rev-parse --show-toplevel)"

cp "$PKG" "$MIRROR/"

cd "$MIRROR"
repo-add -n -R bluearchive.db.tar.gz *.pkg.tar.zst

# GitHub Pages 不支持 symlink，实体化 .db/.files
rm -f bluearchive.db bluearchive.files
cp bluearchive.db.tar.gz bluearchive.db
cp bluearchive.files.tar.gz bluearchive.files

# 生成索引 HTML
cd "$SELF_DIR"
./gen-index.sh

