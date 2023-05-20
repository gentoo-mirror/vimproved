# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-vm-2

abi_uri() {
	local baseuri="https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$(ver_cut 2-4)/"
	echo "${2-$1}? (
			${baseuri}/graalvm-ce-java${SLOT}-linux-${1}-$(ver_cut 2-4).tar.gz
		)"
}

SLOT=$(ver_cut 1)

DESCRIPTION="Prebuilt GraalVM JDK binaries"
HOMEPAGE="https://www.graalvm.org/"
SRC_URI="
	$(abi_uri amd64 amd64)
"

LICENSE="GPL-2-with-classpath-exception"
KEYWORDS="~amd64"

IUSE="alsa cups examples headless-awt selinux source"

RDEPEND="
	>=sys-apps/baselayout-java-0.1.0-r1
	kernel_linux? (
		media-libs/fontconfig:1.0
		media-libs/freetype:2
		elibc_glibc? ( >=sys-libs/glibc-2.2.5:* )
		sys-libs/zlib
		alsa? ( media-libs/alsa-lib )
		arm? ( dev-libs/libffi-compat:6 )
		cups? ( net-print/cups )
		selinux? ( sec-policy/selinux-java )
		!headless-awt? (
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXi
			x11-libs/libXrender
			x11-libs/libXtst
		)
	)
"

RESTRICT="preserve-libs strip"
QA_PREBUILT="*"

S="${WORKDIR}/graalvm-ce-java${SLOT}-$(ver_cut 2-4)"

src_install() {
	local dest="/opt/${P}"
	local ddest="${ED}/${dest#/}"

	rm ASSEMBLY_EXCEPTION LICENSE.txt THIRD_PARTY_README_JDK || die

	if ! use source ; then
		rm -v src.zip || die
	fi

	rm -v jre/lib/security/cacerts || die
	dosym ../../../../../etc/ssl/certs/java/cacerts \
		"${dest}"/jre/lib/security/cacerts

	dodir "${dest}"
	cp -pPR * "${ddest}" || die

	# provide stable symlink
	dosym "${P}" "/opt/${PN}-${SLOT}"

	java-vm_install-env "${FILESDIR}"/${PN}-${SLOT}.env.sh
	java-vm_set-pax-markings "${ddest}"
	java-vm_revdep-mask
	java-vm_sandbox-predict /dev/random /proc/self/coredump_filter
}
