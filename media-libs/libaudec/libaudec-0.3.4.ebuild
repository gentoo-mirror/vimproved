# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="library for reading and resampling audio files"
HOMEPAGE="https://git.zrythm.org/zrythm/libaudec"
SRC_URI="https://git.zrythm.org/zrythm/libaudec/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="mirror !test? ( test )"

DEPEND="
	>=media-libs/libsamplerate-0.1.8
	>=media-libs/libsndfile-1.0.25
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_use test tests)
	)

	meson_src_configure
}
