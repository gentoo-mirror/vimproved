# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: dub.eclass
# @MAINTAINER:
# Violet Purcell <vimproved@inventati.org>
# @AUTHOR:
# Violet Purcell <vimproved@inventati.org>
# @SUPPORTED_EAPIS: 8
# @BLURB: Eclass for dub packages
# @DESCRIPTION:
# Eclass for dlang packages written for the dub package manager.

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_DUB_ECLASS} ]]; then
_DUB_ECLASS=1

inherit dlang

BDEPEND="
	${BDEPEND}
	dev-util/dub
"

# @FUNCTION: dub_pkg_setup
# @DESCRIPTION:
# Sets LIBDIR to the value of $(get_libdir) before it gets redefined.
dub_pkg_setup() {
	LIBDIR=$(get_libdir)
}

# @FUNCTION: dub_src_compile
# @DESCRIPTION:
# Set DFLAGS and run dub build.
dub_src_compile() {
	DFLAGS="${DCFLAGS}" dub build -v --build=release --parallel || die
}

# @FUNCTION: dub_src_install
# @DESCRIPTION:
# Copy package into dub system cache.
dub_src_install() {
	insinto /usr/${LIBDIR}/dub/${PN}/${PV}
	doins -r "${S}"
	mv "${ED}/usr/${LIBDIR}/dub/${PN}/${PV}/${S##*/}" "${ED}/usr/${LIBDIR}/dub/${PN}/${PV}/${PN}" || die
}

EXPORT_FUNCTIONS pkg_setup src_compile src_install

fi
