#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

KEYID=868204B94E008548
SUITES=(termux debian)

declare -A ARCH=(
	[termux]="all aarch64 arm i686 x86_64"
	[debian]="all amd64 arm64"
)
declare -A POOL=(
	[termux]="pool/termux/main"
	[debian]="pool/debian/main"
)
declare -A LABEL=(
	[termux]="BlueArchive-Git Termux"
	[debian]="BlueArchive-Git Debian"
)

targets=("$@")
[ ${#targets[@]} -eq 0 ] && targets=("${SUITES[@]}")

for suite in "${targets[@]}"; do
	dist="$ROOT/dists/$suite"
	[ -d "$dist" ] || { echo "suite not found: $dist" >&2; continue; }

	archs="${ARCH[$suite]}"
	pool="${POOL[$suite]}"
	label="${LABEL[$suite]}"

	echo "[$suite] scanning $pool"
	for arch in $archs; do
		out="$dist/main/binary-$arch"
		mkdir -p "$out"
		if [ -d "$ROOT/$pool" ]; then
				dpkg-scanpackages --arch "$arch" "$pool" /dev/null \
				> "$out/Packages" 2>/dev/null || : > "$out/Packages"
		else
			: > "$out/Packages"
		fi
		gzip -kf "$out/Packages"
		xz   -kf "$out/Packages"
	done

	echo "[$suite] generating Release"
	apt-ftparchive \
		-o "APT::FTPArchive::Release::Suite=$suite" \
		-o "APT::FTPArchive::Release::Codename=$suite" \
		-o "APT::FTPArchive::Release::Origin=BlueArchive-Git" \
		-o "APT::FTPArchive::Release::Label=$label" \
		-o "APT::FTPArchive::Release::Architectures=$archs" \
		release "$dist" > "$dist/Release"

	echo "[$suite] signing"
	gpg --batch --yes --default-key "$KEYID" -abs \
		-o "$dist/Release.gpg" "$dist/Release"
	gpg --batch --yes --default-key "$KEYID" --clearsign \
		-o "$dist/InRelease" "$dist/Release"

	gpg --verify "$dist/InRelease" 2>&1 | grep -q "Good signature" \
		&& echo "[$suite] done" \
		|| { echo "[$suite] signature verification failed" >&2; exit 1; }
done

echo "index rebuild complete."
