# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit meson

MY_PV="5d8b3d3b46b1c288e87079dc531694f4377eedc4"

DESCRIPTION="A minimal portable API for embeddable GUIs"
HOMEPAGE="https://gitlab.com/lv2/pugl/"
SRC_URI="https://gitlab.com/lv2/pugl/-/archive/${MY_PV}/pugl-${MY_PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cairo doc +opengl test vulkan"
RESTRICT="!test? ( test )"
S="${WORKDIR}/pugl-${MY_PV}"

DEPEND="
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXrandr
	cairo? ( x11-libs/cairo )
	opengl? ( virtual/opengl )
	vulkan? ( media-libs/vulkan-loader )
"
RDEPEND="${DEPEND}"
BDEPEND="
	doc? (
		app-doc/doxygen
		dev-python/sphinxygen
	)
"

src_configure() {
	local emesonargs=(
		$(meson_feature cairo)
		$(meson_feature doc docs)
		$(meson_use doc docs_cpp)
		$(meson_feature opengl)
		$(meson_feature test tests)
		$(meson_feature vulkan)
		-Dxcursor=enabled
		-Dxrandr=enabled
		-Dxsync=enabled
	)

	meson_src_configure
}
