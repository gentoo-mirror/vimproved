# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1 pypi

DESCRIPTION="A program to help users work with QMK Firmware."
HOMEPAGE="https://qmk.fm/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	app-mobilephone/dfu-util
	dev-embedded/avrdude
	dev-embedded/dfu-programmer
	dev-embedded/qmk-udev-rules
	dev-python/dotty-dict[${PYTHON_USEDEP}]
	dev-python/hid[${PYTHON_USEDEP}]
	dev-python/hjson[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/milc[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
"

pkg_postinst() {
	einfo "To use qmk, use sys-devel/crossdev to setup the avr and arm-none-eabi toolchains."
}
