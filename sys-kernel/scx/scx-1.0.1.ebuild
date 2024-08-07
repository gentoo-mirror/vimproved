# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.22.0
	adler@1.0.2
	ahash@0.8.11
	aho-corasick@1.1.3
	anstream@0.6.14
	anstyle-parse@0.2.4
	anstyle-query@1.1.0
	anstyle-wincon@3.0.3
	anstyle@1.0.7
	anyhow@1.0.86
	atomic-waker@1.1.2
	autocfg@1.3.0
	aws-lc-rs@1.8.0
	aws-lc-sys@0.19.0
	backtrace@0.3.73
	base64@0.22.1
	bindgen@0.69.4
	bitflags@1.3.2
	bitflags@2.6.0
	bitvec@1.0.1
	bumpalo@3.16.0
	bytes@1.6.1
	camino@1.1.7
	cargo-platform@0.1.8
	cargo_metadata@0.15.4
	cargo_metadata@0.18.1
	cc@1.1.5
	cexpr@0.6.0
	cfg-if@1.0.0
	cfg_aliases@0.1.1
	clang-sys@1.8.1
	clap@4.5.9
	clap_builder@4.5.9
	clap_derive@4.5.8
	clap_lex@0.7.1
	cmake@0.1.50
	colorchoice@1.0.1
	const_format@0.2.32
	const_format_proc_macros@0.2.32
	convert_case@0.6.0
	core-foundation-sys@0.8.6
	core-foundation@0.9.4
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.20
	ctrlc@3.4.4
	deranged@0.3.11
	dtoa@1.0.9
	dunce@1.0.4
	either@1.13.0
	endian-type@0.1.2
	equivalent@1.0.1
	errno@0.3.9
	fastrand@2.1.0
	fb_procfs@0.7.1
	filetime@0.2.23
	fnv@1.0.7
	fs_extra@1.3.0
	funty@2.0.0
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	getrandom@0.2.15
	gimli@0.29.0
	glob@0.3.1
	h2@0.4.5
	hashbrown@0.14.5
	heck@0.4.1
	heck@0.5.0
	hermit-abi@0.3.9
	hex@0.4.3
	home@0.5.9
	http-body-util@0.1.2
	http-body@1.0.1
	http@1.1.0
	httparse@1.9.4
	httpdate@1.0.3
	hyper-rustls@0.27.2
	hyper-util@0.1.6
	hyper@1.4.1
	indexmap@2.2.6
	ipnet@2.9.0
	is_terminal_polyfill@1.70.0
	itertools@0.12.1
	itoa@1.0.11
	jobserver@0.1.31
	js-sys@0.3.69
	lazy_static@1.5.0
	lazycell@1.3.0
	libbpf-cargo@0.23.3
	libbpf-rs@0.23.3
	libbpf-sys@1.4.2+v1.4.2
	libc@0.2.155
	libloading@0.8.4
	linux-raw-sys@0.4.14
	lock_api@0.4.12
	log@0.4.22
	memchr@2.7.4
	memmap2@0.5.10
	memoffset@0.6.5
	metrics-exporter-prometheus@0.15.3
	metrics-util@0.17.0
	metrics@0.23.0
	minimal-lexical@0.2.1
	miniz_oxide@0.7.4
	mio@0.8.11
	mirai-annotations@1.12.0
	nibble_vec@0.1.0
	nix@0.25.1
	nix@0.28.0
	nom@7.1.3
	num-conv@0.1.0
	num-traits@0.2.19
	num_cpus@1.16.0
	num_threads@0.1.7
	object@0.36.1
	once_cell@1.19.0
	openat@0.1.21
	openssl-probe@0.1.5
	ordered-float@3.9.2
	ordered-float@4.2.1
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	paste@1.0.15
	pin-project-internal@1.1.5
	pin-project-lite@0.2.14
	pin-project@1.1.5
	pin-utils@0.1.0
	pkg-config@0.3.30
	plain@0.2.3
	portable-atomic@1.6.0
	powerfmt@0.2.0
	prettyplease@0.2.20
	proc-macro2@1.0.86
	prometheus-client-derive-encode@0.4.2
	prometheus-client@0.19.0
	quanta@0.12.3
	quote@1.0.36
	radium@0.7.0
	radix_trie@0.2.1
	raw-cpuid@11.0.2
	redox_syscall@0.4.1
	redox_syscall@0.5.3
	regex-automata@0.4.7
	regex-syntax@0.6.29
	regex-syntax@0.8.4
	regex@1.10.5
	ring@0.17.8
	rlimit@0.10.1
	rustc-demangle@0.1.24
	rustc-hash@1.1.0
	rustix@0.38.34
	rustls-native-certs@0.7.1
	rustls-pemfile@2.1.2
	rustls-pki-types@1.7.0
	rustls-webpki@0.102.5
	rustls@0.23.11
	rustversion@1.0.17
	ryu@1.0.18
	same-file@1.0.6
	schannel@0.1.23
	scopeguard@1.2.0
	security-framework-sys@2.11.1
	security-framework@2.11.1
	semver@1.0.23
	serde@1.0.204
	serde_derive@1.0.204
	serde_json@1.0.120
	shlex@1.3.0
	simplelog@0.12.2
	sketches-ddsketch@0.2.2
	slab@0.4.9
	smallvec@1.13.2
	socket2@0.5.7
	sorted-vec@0.8.3
	spin@0.9.8
	sscanf@0.4.1
	sscanf_macro@0.4.1
	static_assertions@1.1.0
	strsim@0.10.0
	strsim@0.11.1
	strum_macros@0.24.3
	subtle@2.6.1
	syn@1.0.109
	syn@2.0.71
	tap@1.0.1
	tar@0.4.41
	tempfile@3.10.1
	termcolor@1.4.1
	terminal_size@0.3.0
	thiserror-impl@1.0.62
	thiserror@1.0.62
	threadpool@1.8.1
	time-core@0.1.2
	time-macros@0.2.18
	time@0.3.36
	tokio-rustls@0.26.0
	tokio-util@0.7.11
	tokio@1.38.0
	tower-layer@0.3.2
	tower-service@0.3.2
	tower@0.4.13
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing@0.1.40
	try-lock@0.2.5
	unicase@2.7.0
	unicode-ident@1.0.12
	unicode-segmentation@1.11.0
	unicode-width@0.1.13
	unicode-xid@0.2.4
	untrusted@0.9.0
	utf8parse@0.2.2
	vergen@8.3.2
	version-compare@0.1.1
	version_check@0.9.4
	vsprintf@2.0.0
	walkdir@2.5.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-shared@0.2.92
	wasm-bindgen@0.2.92
	web-sys@0.3.69
	which@4.4.2
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.8
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	wyz@0.5.1
	xattr@1.3.1
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
	zeroize@1.8.1
	zeroize_derive@1.4.2
"
LLVM_COMPAT=( {16..18} )

inherit cargo llvm-r1 meson

DESCRIPTION="sched_ext schedulers and tools"
HOMEPAGE="https://github.com/sched-ext/scx"
SRC_URI="
	https://github.com/sched-ext/scx/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="GPL-2"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD-2 BSD ISC MIT openssl Unicode-DFS-2016 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

DEPEND=">=dev-libs/libbpf-1.3"
RDEPEND="${DEPEND}"
BDEPEND="
	app-misc/jq
	dev-util/bpftool
	$(llvm_gen_dep '
		sys-devel/clang:${LLVM_SLOT}[llvm_targets_BPF(-)]
	')
"

PATCHES=(
	"${FILESDIR}/${PN}-0.1.10-add-missing-timespec-use.patch"
	"${FILESDIR}/${PN}-0.1.10-no-bpftool-version-check.patch"
)

src_configure() {
	local emesonargs=(
		-Dbpftool="disabled"
		-Dbpf_clang="clang-${LLVM_SLOT}"
		-Dlibbpf_a="disabled"
		-Doffline=true
		-Dopenrc=enabled
		$(meson_feature systemd)
	)

	meson_src_configure
}
