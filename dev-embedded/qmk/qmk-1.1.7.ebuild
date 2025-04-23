# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi udev

DESCRIPTION="A program to help users work with QMK Firmware."
HOMEPAGE="https://qmk.fm/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-mobilephone/dfu-util
	dev-embedded/avrdude
	dev-embedded/dfu-programmer
	dev-python/dotty-dict[${PYTHON_USEDEP}]
	dev-python/hid[${PYTHON_USEDEP}]
	dev-python/hjson[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/milc[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
	!dev-embedded/qmk-udev-rules
"

distutils_enable_tests import-check

src_test() {
	export QMK_HOME="${T}"
	distutils-r1_src_test
}

src_install() {
	distutils-r1_src_install
	udev_dorules "${FILESDIR}/50-${PN}.rules"
}

pkg_postinst() {
	udev_reload
	einfo "To use ${PN}, use sys-devel/crossdev to setup the avr and arm-none-eabi toolchains."
}

pkg_postrm() {
	udev_reload
}
