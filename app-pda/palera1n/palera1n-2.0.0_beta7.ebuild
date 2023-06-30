# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="iOS 15.0-16.5 semi-tethered checkm8 jailbreak"
HOMEPAGE="https://github.com/palera1n/palera1n/"
CHECKRA1N_VERSION="0.1337.1"
SRC_URI="
	https://github.com/palera1n/palera1n/archive/refs/tags/v$(ver_cut 1-3)-beta.7.tar.gz
	https://assets.checkra.in/downloads/preview/${CHECKRA1N_VERSION}/checkra1n-linux-x86_64
		-> checkra1n-linux-x86_64-${CHECKRA1N_VERSION}
	https://assets.checkra.in/downloads/preview/${CHECKRA1N_VERSION}/checkra1n-macos
		-> checkra1n-macos-${CHECKRA1N_VERSION}
	https://cdn.nickchan.lol/palera1n/c-rewrite/deps/ramdisk.dmg
	https://cdn.nickchan.lol/palera1n/c-rewrite/deps/binpack.dmg
	https://cdn.nickchan.lol/palera1n/artifacts/kpf/checkra1n-kpf-pongo
	https://cdn.nickchan.lol/palera1n/artifacts/kpf/Pongo.bin
"
S="${WORKDIR}/palera1n-$(ver_cut 1-3)-beta.7"

LICENSE="MIT all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-pda/libimobiledevice
	app-pda/libimobiledevice-glue
	app-pda/libirecovery
	app-pda/libusbmuxd
	net-libs/mbedtls
	virtual/libusb
"
RDEPEND="
	${DEPEND}
	app-pda/usbmuxd
"
BDEPEND="
	dev-util/xxd
"

PATCHES=(
	"${FILESDIR}/${P}-unbundle.patch"
)

src_prepare() {
	mv "${DISTDIR}/checkra1n-linux-x86_64-${CHECKRA1N_VERSION}" "${S}/src/checkra1n-linux-x86_64"
	mv "${DISTDIR}/checkra1n-macos-${CHECKRA1N_VERSION}" "${S}/src/checkra1n-macos"
	mv "${DISTDIR}/ramdisk.dmg" "${S}/src/ramdisk.dmg"
	mv "${DISTDIR}/binpack.dmg" "${S}/src/binpack.dmg"
	mv "${DISTDIR}/checkra1n-kpf-pongo" "${S}/src/checkra1n-kpf-pongo"
	mv "${DISTDIR}/Pongo.bin" "${S}/src/Pongo.bin"
	default
}

src_compile() {
	emake CHECKRA1N_NAME="linux-x86_64"
}

src_install() {
	dobin "${S}/src/palera1n"
}
