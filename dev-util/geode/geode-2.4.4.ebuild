# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.10

EAPI=8

CRATES="
	ab_glyph_rasterizer@0.1.7
	adler32@1.2.0
	adler@1.0.2
	ahash@0.7.6
	aho-corasick@0.7.19
	ansi_term@0.12.1
	approx@0.5.1
	atty@0.2.14
	autocfg@1.1.0
	base64@0.13.0
	bit_field@0.10.1
	bitflags@1.3.2
	block-buffer@0.10.3
	block-buffer@0.9.0
	bumpalo@3.11.0
	bytemuck@1.12.1
	byteorder@1.4.3
	bytes@1.2.1
	bzip2-sys@0.1.11+1.0.8
	bzip2@0.4.3
	cc@1.0.73
	cfg-if@1.0.0
	clap@4.1.4
	clap_derive@4.1.0
	clap_lex@0.3.1
	clipboard-win@4.4.2
	color_quant@1.1.0
	colored@2.0.0
	conv@0.3.3
	core-foundation-sys@0.8.3
	core-foundation@0.9.3
	cpufeatures@0.2.4
	crc32fast@1.3.2
	crossbeam-channel@0.5.6
	crossbeam-deque@0.8.2
	crossbeam-epoch@0.9.10
	crossbeam-utils@0.8.11
	crypto-common@0.1.6
	custom_derive@0.1.7
	deflate@1.0.0
	digest@0.10.6
	digest@0.9.0
	dirs-next@2.0.0
	dirs-sys-next@0.1.2
	dirs-sys@0.3.7
	dirs@4.0.0
	edit-distance@2.1.0
	either@1.8.0
	encoding_rs@0.8.31
	endian-type@0.1.2
	errno-dragonfly@0.1.2
	errno@0.2.8
	error-code@2.3.1
	exr@1.5.0
	fastrand@1.8.0
	fd-lock@3.0.6
	flate2@1.0.24
	flume@0.10.14
	fnv@1.0.7
	fontdue@0.7.2
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.0.1
	futures-channel@0.3.24
	futures-core@0.3.24
	futures-io@0.3.24
	futures-sink@0.3.24
	futures-task@0.3.24
	futures-util@0.3.24
	generic-array@0.14.6
	getrandom@0.1.16
	getrandom@0.2.7
	gif@0.11.4
	git2@0.17.2
	glob@0.3.0
	h2@0.3.14
	half@1.8.2
	hashbrown@0.11.2
	hashbrown@0.12.3
	heck@0.4.0
	hermit-abi@0.1.19
	hermit-abi@0.2.6
	hex@0.4.3
	http-body@0.4.5
	http@0.2.8
	httparse@1.8.0
	httpdate@1.0.2
	hyper-tls@0.5.0
	hyper@0.14.20
	idna@0.2.3
	image@0.24.3
	imageproc@0.23.0
	indexmap@1.9.1
	instant@0.1.12
	io-lifetimes@0.7.2
	io-lifetimes@1.0.4
	ipnet@2.5.0
	is-terminal@0.4.2
	itertools@0.10.5
	itoa@1.0.3
	jobserver@0.1.24
	jpeg-decoder@0.2.6
	js-sys@0.3.59
	keccak@0.1.3
	lazy_static@1.4.0
	lebe@0.5.2
	libc@0.2.139
	libgit2-sys@0.15.2+1.6.4
	libssh2-sys@0.3.0
	libz-sys@1.1.8
	line-wrap@0.1.1
	linux-raw-sys@0.0.46
	linux-raw-sys@0.1.4
	lock_api@0.4.8
	log@0.4.17
	matches@0.1.9
	matrixmultiply@0.3.2
	memchr@2.5.0
	memoffset@0.6.5
	mime@0.3.16
	miniz_oxide@0.5.3
	mio@0.8.4
	nalgebra@0.30.1
	nanorand@0.7.0
	native-tls@0.2.10
	nibble_vec@0.1.0
	nix@0.23.1
	num-bigint@0.4.3
	num-complex@0.4.2
	num-integer@0.1.45
	num-iter@0.1.43
	num-rational@0.4.1
	num-traits@0.2.15
	num@0.4.0
	num_cpus@1.13.1
	num_threads@0.1.6
	once_cell@1.13.0
	opaque-debug@0.3.0
	openssl-macros@0.1.0
	openssl-probe@0.1.5
	openssl-sys@0.9.83
	openssl@0.10.48
	os_str_bytes@6.2.0
	owned_ttf_parser@0.6.0
	paste@1.0.9
	path-absolutize@3.0.13
	path-dedot@3.0.17
	percent-encoding@2.1.0
	pin-project-internal@1.0.12
	pin-project-lite@0.2.9
	pin-project@1.0.12
	pin-utils@0.1.0
	pkg-config@0.3.25
	plist@1.3.1
	png@0.17.5
	ppv-lite86@0.2.16
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.42
	quote@1.0.20
	radix_trie@0.2.1
	rand@0.7.3
	rand_chacha@0.2.2
	rand_core@0.5.1
	rand_distr@0.2.2
	rand_hc@0.2.0
	rawpointer@0.2.1
	rayon-core@1.9.3
	rayon@1.5.3
	redox_syscall@0.2.16
	redox_users@0.4.3
	regex-syntax@0.6.27
	regex@1.6.0
	remove_dir_all@0.5.3
	reqwest@0.11.12
	rustix@0.35.7
	rustix@0.36.7
	rusttype@0.9.2
	rustyline@9.1.2
	ryu@1.0.11
	safe_arch@0.6.0
	safemem@0.3.3
	same-file@1.0.6
	schannel@0.1.20
	scoped_threadpool@0.1.9
	scopeguard@1.1.0
	security-framework-sys@2.6.1
	security-framework@2.7.0
	semver@1.0.14
	serde@1.0.143
	serde_derive@1.0.143
	serde_json@1.0.83
	serde_urlencoded@0.7.1
	sha256@1.0.3
	sha2@0.9.9
	sha3@0.10.6
	signed-distance-field@0.6.3
	simba@0.7.2
	slab@0.4.7
	smallvec@1.9.0
	socket2@0.4.7
	spin@0.9.4
	str-buf@1.0.6
	strsim@0.10.0
	syn@1.0.98
	tempfile@3.3.0
	termcolor@1.1.3
	texture_packer@0.24.0
	thiserror-impl@1.0.32
	thiserror@1.0.32
	threadpool@1.8.1
	tiff@0.7.3
	time@0.1.44
	time@0.3.14
	tinyvec@1.6.0
	tinyvec_macros@0.1.0
	tokio-native-tls@0.3.0
	tokio-util@0.7.4
	tokio@1.21.2
	toml@0.5.9
	tower-service@0.3.2
	tracing-core@0.1.30
	tracing@0.1.37
	try-lock@0.2.3
	ttf-parser@0.15.2
	ttf-parser@0.6.2
	typenum@1.15.0
	unicode-bidi@0.3.8
	unicode-ident@1.0.2
	unicode-normalization@0.1.21
	unicode-segmentation@1.9.0
	unicode-width@0.1.9
	url@2.2.2
	utf8parse@0.2.0
	vcpkg@0.2.15
	version_check@0.9.4
	walkdir@2.3.2
	want@0.3.0
	wasi@0.10.0+wasi-snapshot-preview1
	wasi@0.11.0+wasi-snapshot-preview1
	wasi@0.9.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.82
	wasm-bindgen-futures@0.4.32
	wasm-bindgen-macro-support@0.2.82
	wasm-bindgen-macro@0.2.82
	wasm-bindgen-shared@0.2.82
	wasm-bindgen@0.2.82
	web-sys@0.3.59
	weezl@0.1.7
	which@4.4.0
	wide@0.7.4
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.36.1
	windows-sys@0.42.0
	windows_aarch64_gnullvm@0.42.1
	windows_aarch64_msvc@0.36.1
	windows_aarch64_msvc@0.42.1
	windows_i686_gnu@0.36.1
	windows_i686_gnu@0.42.1
	windows_i686_msvc@0.36.1
	windows_i686_msvc@0.42.1
	windows_x86_64_gnu@0.36.1
	windows_x86_64_gnu@0.42.1
	windows_x86_64_gnullvm@0.42.1
	windows_x86_64_msvc@0.36.1
	windows_x86_64_msvc@0.42.1
	winreg@0.10.1
	winreg@0.7.0
	winres@0.1.12
	xml-rs@0.8.4
	zip@0.5.13
"

inherit cargo

DESCRIPTION="Command-line utilities for working w/ geode"
HOMEPAGE="https://geode-sdk.org/"
SRC_URI="
	https://github.com/geode-sdk/cli/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="Boost-1.0"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD Boost-1.0 MIT MPL-2.0 Unicode-DFS-2016 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/cli-${PV}"

src_prepare() {
	pushd "${WORKDIR}/cargo_home/gentoo/getrandom-0.1.16" > /dev/null 2>&1
	eapply "${FILESDIR}/${P}-musl-1.2.4.patch"
	popd > /dev/null 2>&1
	pushd "${WORKDIR}/cargo_home/gentoo/getrandom-0.2.7" > /dev/null 2>&1
	eapply "${FILESDIR}/${P}-musl-1.2.4.patch"
	popd > /dev/null 2>&1
	default
}
