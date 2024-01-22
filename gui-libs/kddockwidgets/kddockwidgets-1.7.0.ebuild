# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="KDAB's Dock Widget Framework for Qt"
HOMEPAGE="https://www.kdab.com/development-resources/qt-tools/kddockwidgets"
SRC_URI="https://github.com/KDAB/KDDockWidgets/releases/download/v${PV}/${P}.tar.gz"

LICENSE="BSD GPL-2 GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

RDEPEND="
	dev-qt/qtgui:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtwidgets:5
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DKDDockWidgets_QTQUICK=ON
		-DKDDockWidgets_STATIC=$(usex static-libs)
	)

	cmake_src_configure
}
