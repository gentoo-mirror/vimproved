# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ALTERNATIVES=(
	gnu:sys-apps/coreutils
	chimera:sys-apps/chimerautils
)

COREUTILS_LIST=(
	"["
	"base64"
	"basename"
	"cat"
	"chgrp"
	"chmod"
	"chown"
	"chroot"
	"cksum"
	"comm"
	"cp"
	"csplit"
	"cut"
	"date"
	"dd"
	"df"
	"dir"
	"dirname"
	"du"
	"echo"
	"env"
	"expand"
	"expr"
	"factor"
	"false"
	"fold"
	"head"
	"hostid"
	"id"
	"install"
	"join"
	"link"
	"ln"
	"logname"
	"ls"
	"md5sum"
	"mkdir"
	"mkfifo"
	"mknod"
	"mktemp"
	"mv"
	"nice"
	"nl"
	"nohup"
	"nproc"
	"od"
	"paste"
	"pathchk"
	"pr"
	"printenv"
	"printf"
	"pwd"
	"readlink"
	"realpath"
	"rm"
	"rmdir"
	"seq"
	"sha1sum"
	"sha224sum"
	"sha256sum"
	"sha384sum"
	"sha512sum"
	"sleep"
	"sort"
	"split"
	"stat"
	"stdbuf"
	"stty"
	"sum"
	"sync"
	"tail"
	"tee"
	"test"
	"timeout"
	"touch"
	"tr"
	"true"
	"truncate"
	"tsort"
	"tty"
	"uname"
	"unexpand"
	"uniq"
	"unlink"
	"users"
	"vdir"
	"wc"
	"who"
	"whoami"
	"yes"
)

inherit app-alternatives

DESCRIPTION="symlinks for core system utilities"
#KEYWORDS="~amd64"

src_install() {
	local suffix=$(get_alternative)

	for x in ${COREUTILS_LIST[@]} ; do
		dosym "${x}-${suffix}" "/usr/bin/${x}"
		newman - "${x}.1" <<<".so ${x}-${suffix}.1"
	done

	if use chimera ; then
		USERLAND="BSD"
	else
		USERLAND="GNU"
	fi

	newenvd - 90userland <<-EOF
			USERLAND=${USERLAND}
	EOF
}

pkg_postinst() {
	ewarn "Please log out and back in after updating this alternative to set the USERLAND variable to the correct"
	ewarn "value. Otherwise, portage may break."
}
