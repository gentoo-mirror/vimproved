# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Linux audio plugins and LV2 ports"
HOMEPAGE="http://distrho.sourceforge.net/ports"
COMMIT="5c55f9445ee6ff75d53c7f8601fc341d200aa4a0"
JUCE5_COMMIT="176f819c681405a12e7f6ecc1e2e1af472c3ed7b"
JUCE60_COMMIT="6648f3fee63fce603a21d467715e4314f3766a27"
JUCE61_COMMIT="7c23c02e47739ee77f29a9bec4d5440b59dc54d3"
JUCE7_COMMIT="c3099e733e90b8a2e7071698980abd70efb9a4e7"
SRC_URI="
	https://github.com/DISTRHO/DISTRHO-Ports/archive/${COMMIT}.tar.gz -> ${PN}-${COMMIT}.tar.gz
	https://github.com/DISTRHO/JUCE/archive/${JUCE5_COMMIT}.tar.gz -> distrho-juce5-${JUCE5_COMMIT}.tar.gz
	https://github.com/DISTRHO/JUCE/archive/${JUCE60_COMMIT}.tar.gz -> distrho-juce6.0-${JUCE60_COMMIT}.tar.gz
	https://github.com/DISTRHO/JUCE/archive/${JUCE61_COMMIT}.tar.gz -> distrho-juce6.1-${JUCE61_COMMIT}.tar.gz
	https://github.com/DISTRHO/JUCE/archive/${JUCE7_COMMIT}.tar.gz -> distrho-juce7-${JUCE7_COMMIT}.tar.gz
"
S="${WORKDIR}/DISTRHO-Ports-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+lv2 vst2 vst3"
RESTRICT="test"

DEPEND="
	media-libs/alsa-lib
	media-libs/freetype
	sci-libs/fftw
	x11-libs/libX11
	x11-libs/libXext
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-20231230-juce5-musl.patch"
	"${FILESDIR}/${PN}-20231230-juce6.0-musl.patch"
	"${FILESDIR}/${PN}-20231230-juce6.1-musl.patch"
	"${FILESDIR}/${PN}-20231230-juce7-musl.patch"
	"${FILESDIR}/${PN}-20231230-nullptr-cast.patch"
)

src_prepare() {
	rm -r libs/{juce5,juce6.0,juce6.1,juce7}/source || die
	mv "${WORKDIR}/JUCE-${JUCE5_COMMIT}" libs/juce5/source || die
	mv "${WORKDIR}/JUCE-${JUCE60_COMMIT}" libs/juce6.0/source || die
	mv "${WORKDIR}/JUCE-${JUCE61_COMMIT}" libs/juce6.1/source || die
	mv "${WORKDIR}/JUCE-${JUCE7_COMMIT}" libs/juce7/source || die

	default
}

src_configure() {
	local emesonargs=(
		$(meson_use lv2 build-lv2)
		$(meson_use vst2 build-vst2)
		$(meson_use vst3 build-vst3)
		-Dlto-optimizations=false
		-Dneon-optimizations=false
		-Doptimizations=false
		-Dsse-optimizations=false
	)

	meson_src_configure
}
