# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="The GNU C Library Compatibility Layer for Adélie Linux"
HOMEPAGE="https://git.adelielinux.org/adelie/gcompat"
SRC_URI="https://git.adelielinux.org/adelie/gcompat/-/archive/${PV}/${P}.tar.bz2"

LICENSE="UoI-NCSA"
SLOT="0"

RDEPEND="
	sys-libs/libucontext
	sys-libs/obstack-standalone
"
DEPEND="${RDEPEND}"

get_glibc_loader_name() {
	local i ldso_abi ldso_name
	local ldso_abi_list=(
		# x86
		amd64   /lib64/ld-linux-x86-64.so.2
		x32     /libx32/ld-linux-x32.so.2
		x86     /lib/ld-linux.so.2
		# mips
		o32     /lib/ld.so.1
		n32     /lib32/ld.so.1
		n64     /lib64/ld.so.1
		# powerpc
		ppc     /lib/ld.so.1
		# riscv
		ilp32d  /lib/ld-linux-riscv32-ilp32d.so.1
		ilp32   /lib/ld-linux-riscv32-ilp32.so.1
		lp64d   /lib/ld-linux-riscv64-lp64d.so.1
		lp64    /lib/ld-linux-riscv64-lp64.so.1
		# s390
		s390    /lib/ld.so.1
		s390x   /lib/ld64.so.1
		# sparc
		sparc32 /lib/ld-linux.so.2
		sparc64 /lib64/ld-linux.so.2
	)

	case $(tc-endian) in
		little)
			ldso_abi_list+=(
				# arm
				arm64   /lib/ld-linux-aarch64.so.1
				# ELFv2 (glibc does not support ELFv1 on LE)
				ppc64   /lib64/ld64.so.2
			)
			;;
		big)
			ldso_abi_list+=(
				# arm
				arm64   /lib/ld-linux-aarch64_be.so.1
				# ELFv1 (glibc does not support ELFv2 on BE)
				ppc64   /lib64/ld64.so.1
			)
			;;
	esac

	for (( i = 0; i < ${#ldso_abi_list[@]}; i += 2 )) ; do
		ldso_abi=${ldso_abi_list[i]}
		has ${ldso_abi} ${ABI} || continue

		ldso_name="${ldso_abi_list[i+1]}"
	done

	echo ${ldso_name}
}

pkg_setup() {
	GLIBC_LDSO="$(get_glibc_loader_name)"
	emakeargs=(
		LINKER_PATH="/usr/lib/libc.so"
		LOADER_NAME="${GLIBC_LDSO##*/}"
		LOADER_PATH="${GLIBC_LDSO}"
		WITH_LIBUCONTEXT=1
	)
}

src_compile() {
	emake "${emakeargs[@]}"
}

src_install() {
	emake "${emakeargs[@]}" DESTDIR="${ED}" install
}
