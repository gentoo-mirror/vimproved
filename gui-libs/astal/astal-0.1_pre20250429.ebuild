# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_USE_DEPEND="valadoc"

inherit meson multibuild vala

DESCRIPTION="Building blocks for creating custom desktop shells"
HOMEPAGE="https://aylur.github.io/astal/"
ASTAL_COMMIT="07583deff8a486fad472718572c3248f0fbea1f3"
SRC_URI="https://github.com/Aylur/astal/archive/${ASTAL_COMMIT}.tar.gz
	-> astal-${ASTAL_COMMIT}.tar.gz"
S="${WORKDIR}/astal-${ASTAL_COMMIT}/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gtk3 +gtk4 networkmanager +notifd pam +river +tray wayland +wireplumber"
REQUIRED_USE="|| ( gtk3 gtk4 )"
RESTRICT="test"

DEPEND="
	dev-libs/glib:2
	dev-libs/json-glib
	~gui-libs/astal-io-${PV}
	gtk3? (
		dev-libs/wayland
		gui-libs/gtk-layer-shell[vala]
		x11-libs/gdk-pixbuf:2
		x11-libs/gtk+:3
	)
	gtk4? (
		gui-libs/gtk:4
		gui-libs/gtk4-layer-shell[vala]
	)
	notifd? ( x11-libs/gdk-pixbuf )
	river? ( dev-libs/wayland )
	tray? (
		gui-libs/appmenu-glib-translator
		x11-libs/gdk-pixbuf
	)
	wayland? ( dev-libs/wayland )
	wireplumber? ( media-video/wireplumber )
"
RDEPEND="${DEPEND}"

astal_env() {
	EMESON_SOURCE="${S}/lib/${MULTIBUILD_VARIANT}" "${@}"
}

pkg_setup() {
	# TODO:
	# - cava (needs libcava)
	MULTIBUILD_VARIANTS=(
		$(usev gtk3 astal/gtk3)
		$(usev gtk4 astal/gtk4)
		apps
		$(usev pam auth)
		battery
		bluetooth
		greet
		hyprland
		mpris
		$(usev networkmanager network)
		$(usev notifd)
		powerprofiles
		$(usev river)
		$(usev tray)
		$(usev wayland wayland-glib)
		$(usev wireplumber)
	)
}

src_configure() {
	vala_setup
	multibuild_foreach_variant astal_env meson_src_configure
}

src_compile() {
	multibuild_foreach_variant astal_env meson_src_compile
}

src_install() {
	multibuild_foreach_variant astal_env meson_src_install
}
