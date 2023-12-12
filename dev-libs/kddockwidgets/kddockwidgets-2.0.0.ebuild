# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VIRTUALX_REQUIRED="test"
inherit cmake virtualx

DESCRIPTION="KDAB's Dock Widget Framework for Qt"
HOMEPAGE="https://www.kdab.com/development-resources/qt-tools/kddockwidgets/"
SRC_URI="https://github.com/KDAB/KDDockWidgets/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X doc +quick test +widgets"
REQUIRED_USE="|| ( quick widgets )"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/nlohmann_json
	dev-libs/libfmt
	dev-libs/spdlog
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	X? (
		dev-qt/qtx11extras:5
	)
	quick? (
		dev-qt/qtquickcontrols2:5
	)
	test? (
		dev-qt/qttest:5
	)
	widgets? ( dev-qt/qtwidgets:5 )
"
DEPEND="${RDEPEND}"
BDEPEND="
	doc? (
		app-doc/doxygen
		media-gfx/graphviz
	)
"

PATCHES=(
	"${FILESDIR}/kddockwidgets-2.0.0-no-werror.patch"
)

src_configure() {
	local mycmakeargs=(
		-DKDDockWidgets_DEVELOPER_MODE=$(usex test)
		-DKDDockWidgets_DOCS=$(usex doc)
		-DKDDockWidgets_FRONTENDS="$(usev quick "qtquick;")$(usev widgets "qtwidgets;")"
		-DKDDockWidgets_X11EXTRAS=$(usex X)
	)

	cmake_src_configure
}

src_test() {
	virtx cmake_src_test
}
