#!/usr/bin/bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

declare -A POOL=(
	[termux]="pool/termux/main"
	[debian]="pool/debian/main"
)
declare -A ARCHS=(
	[termux]="all aarch64 arm i686 x86_64"
	[debian]="all amd64 arm64"
)

deb="${1:?usage: $0 <deb-file> <suite>}"
suite="${2:?usage: $0 <deb-file> <suite>}"

[ -f "$deb" ] || { echo "file not found: $deb" >&2; exit 1; }
[ -n "${POOL[$suite]:-}" ] || { echo "unknown suite: $suite" >&2; exit 1; }

pkg=$(dpkg-deb -f "$deb" Package)
ver=$(dpkg-deb -f "$deb" Version)
arch=$(dpkg-deb -f "$deb" Architecture)
[ -n "$pkg" ] && [ -n "$ver" ] && [ -n "$arch" ] \
	|| { echo "failed to read deb metadata" >&2; exit 1; }

if [ "$arch" != "all" ]; then
	echo " $arch " | grep -q " ${ARCHS[$suite]} " \
		|| { echo "arch $arch not in suite $suite (${ARCHS[$suite]})" >&2; exit 1; }
fi

letter="${pkg:0:1}"
dest="$ROOT/${POOL[$suite]}/$letter/$pkg"
mkdir -p "$dest"

target="$dest/${pkg}_${ver}_${arch}.deb"
if [ -f "$target" ]; then
	echo "already exists, skipped: $target"
else
	cp "$deb" "$target"
	echo "added: ${target#$ROOT/}"
fi
