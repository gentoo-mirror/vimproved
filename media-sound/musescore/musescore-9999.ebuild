# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHECKREQS_DISK_BUILD=3500M
VIRTUALX_REQUIRED="test"
inherit cmake flag-o-matic qmake-utils xdg check-reqs virtualx

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/musescore/MuseScore.git"
else
	SRC_URI="
		https://github.com/musescore/MuseScore/archive/v${PV}.tar.gz -> ${P}.tar.gz
	"
	KEYWORDS="~amd64 ~arm64 ~x86"
	S="${WORKDIR}/MuseScore-${PV}"
fi

DESCRIPTION="WYSIWYG Music Score Typesetter"
HOMEPAGE="https://musescore.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE="jack test video"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/tinyxml2:=
	dev-qt/qt5compat:6[qml]
	dev-qt/qtbase:6[concurrent,dbus,gui,network,opengl,widgets,xml]
	dev-qt/qtdeclarative:6[widgets]
	dev-qt/qtnetworkauth:6
	dev-qt/qtscxml:6
	dev-qt/qtsvg:6
	dev-qt/qttools:6[linguist]
	>=media-libs/alsa-lib-1.0.0
	media-libs/flac:=
	>=media-libs/freetype-2.5.2
	media-libs/libopusenc
	media-libs/libsndfile
	media-libs/opus
	media-sound/lame
	sys-libs/zlib:=
	jack? ( virtual/jack )
	video? ( media-video/ffmpeg )
"
# dev-cpp/gtest is required even when tests are disabled!
DEPEND="
	${RDEPEND}
	dev-cpp/gtest
"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-4.2.0-dynamic_cast-crash.patch"
	"${FILESDIR}/${PN}-9999-appshell-qkeycombination.patch"
)

src_prepare() {
	cmake_src_prepare

	# Make sure we don't accidentally use bundled third party deps
	# for which we want to use system packages instead.
	rm -r src/framework/audio/thirdparty/{flac,opus,opusenc} \
		|| die "Failed to remove unused thirdparty directories"
}

src_configure() {
	# confuses rcc, bug #908808
	filter-lto

	# bug #766111
	export PATH="$(qt6_get_bindir):${PATH}"

	local mycmakeargs=(
		-DCMAKE_CXX_FLAGS_RELEASE="${CXXFLAGS}"
		-DCMAKE_C_FLAGS_RELEASE="${CFLAGS}"
		-DCMAKE_INSTALL_PREFIX=/usr
		-DCMAKE_SKIP_RPATH=TRUE
		-DGZIP_EXECUTABLE=OFF
		-DMUE_BUILD_UNIT_TESTS="$(usex test)"
		-DMUE_BUILD_UPDATE_MODULE=OFF
		-DMUE_BUILD_VIDEOEXPORT_MODULE="$(usex video)"
		-DMUE_COMPILE_USE_CCACHE=OFF
		-DMUE_COMPILE_USE_SYSTEM_FLAC=ON
		-DMUE_COMPILE_USE_SYSTEM_FREETYPE=ON
		-DMUE_COMPILE_USE_SYSTEM_OPUS=ON
		-DMUE_COMPILE_USE_SYSTEM_OPUSENC=ON
		-DMUE_COMPILE_USE_SYSTEM_TINYXML=ON
		-DMUE_DOWNLOAD_SOUNDFONT=OFF
		-DMUE_ENABLE_AUDIO_JACK=$(usex jack)
	)

	cmake_src_configure
}

src_test() {
	virtx cmake_src_test
}

src_install() {
	cmake_src_install

	# Hack to not install bundled libraries
	rm -rf "${ED}/usr/include" "${ED}/usr/$(get_libdir)" || die
}
