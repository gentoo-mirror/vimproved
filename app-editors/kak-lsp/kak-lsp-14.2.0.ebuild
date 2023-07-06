# Copyright 2001-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler32@1.2.0
	aho-corasick@0.7.19
	arc-swap@1.5.1
	atty@0.2.14
	autocfg@1.1.0
	bitflags@1.3.2
	boxfnonce@0.1.1
	bumpalo@3.4.0
	cc@1.0.77
	cfg-if@0.1.10
	cfg-if@1.0.0
	chrono@0.4.20
	clap@3.2.20
	clap_lex@0.2.4
	crc32fast@1.3.2
	crossbeam-channel@0.5.6
	crossbeam-utils@0.8.11
	daemonize@0.4.1
	diffs@0.4.1
	dirs-next@2.0.0
	dirs-sys-next@0.1.2
	dirs-sys@0.3.7
	dirs@2.0.2
	either@1.8.0
	enum_primitive@0.1.1
	errno-dragonfly@0.1.2
	errno@0.2.8
	field-offset@0.3.4
	filetime@0.2.18
	form_urlencoded@1.0.1
	fs4@0.6.2
	fsevent-sys@4.1.0
	futures-channel@0.3.24
	futures-core@0.3.24
	futures-executor@0.3.24
	futures-io@0.3.24
	futures-macro@0.3.24
	futures-sink@0.3.24
	futures-task@0.3.24
	futures-util@0.3.24
	futures@0.3.24
	getopts@0.2.21
	getrandom@0.2.7
	glob@0.3.0
	hashbrown@0.12.3
	hermit-abi@0.1.19
	idna@0.2.3
	indexmap@1.9.1
	indoc@1.0.7
	inotify-sys@0.1.5
	inotify@0.9.6
	io-lifetimes@0.7.5
	itertools@0.10.3
	itoa@1.0.3
	js-sys@0.3.55
	jsonrpc-core@18.0.0
	kqueue-sys@1.0.3
	kqueue@1.0.7
	lazy_static@1.4.0
	libc@0.2.138
	libflate@1.2.0
	libflate_lz77@1.1.0
	linux-raw-sys@0.0.46
	log@0.4.17
	lsp-types@0.94.0
	matches@0.1.9
	memchr@2.5.0
	memoffset@0.6.5
	mio@0.8.5
	notify@5.0.0
	num-integer@0.1.45
	num-traits@0.1.43
	num-traits@0.2.15
	num_threads@0.1.6
	once_cell@1.14.0
	os_str_bytes@6.3.0
	percent-encoding@2.1.0
	pest@2.3.0
	pin-project-lite@0.2.9
	pin-utils@0.1.0
	ppv-lite86@0.2.16
	proc-macro2@1.0.43
	pulldown-cmark@0.9.2
	quote@1.0.21
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.3
	redox_syscall@0.2.16
	redox_users@0.4.3
	regex-syntax@0.6.27
	regex@1.6.0
	rle-decode-fast@1.0.3
	ropey@1.5.0
	rustc_version@0.3.3
	rustix@0.35.13
	rustversion@1.0.9
	ryu@1.0.11
	same-file@1.0.6
	semver-parser@0.10.2
	semver@0.11.0
	serde@1.0.144
	serde_derive@1.0.144
	serde_json@1.0.85
	serde_repr@0.1.9
	slab@0.4.7
	slog-async@2.7.0
	slog-kvfilter@0.7.0
	slog-scope@4.4.0
	slog-stdlog@4.1.1
	slog-term@2.9.0
	slog@2.7.0
	sloggers@2.1.1
	smallvec@1.9.0
	str_indices@0.4.0
	strsim@0.10.0
	syn@1.0.99
	take_mut@0.2.2
	term@0.7.0
	termcolor@1.1.3
	textwrap@0.15.0
	thiserror-impl@1.0.34
	thiserror@1.0.34
	thread_local@1.1.4
	time-macros@0.2.4
	time@0.1.44
	time@0.3.14
	tinyvec@1.6.0
	tinyvec_macros@0.1.0
	toml@0.5.9
	trackable@1.2.0
	trackable_derive@1.0.0
	ucd-trie@0.1.5
	unicase@2.6.0
	unicode-bidi@0.3.8
	unicode-ident@1.0.3
	unicode-normalization@0.1.21
	unicode-width@0.1.10
	unindent@0.1.10
	url@2.2.2
	version_check@0.9.4
	walkdir@2.3.2
	wasi@0.10.0+wasi-snapshot-preview1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.78
	wasm-bindgen-macro-support@0.2.78
	wasm-bindgen-macro@0.2.78
	wasm-bindgen-shared@0.2.78
	wasm-bindgen@0.2.78
	web-sys@0.3.55
	whoami@1.2.2
	widestring@0.4.3
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-acl@0.3.0
	windows-sys@0.42.0
	windows_aarch64_gnullvm@0.42.0
	windows_aarch64_msvc@0.42.0
	windows_i686_gnu@0.42.0
	windows_i686_msvc@0.42.0
	windows_x86_64_gnu@0.42.0
	windows_x86_64_gnullvm@0.42.0
	windows_x86_64_msvc@0.42.0
"

inherit cargo

DESCRIPTION="Kakoune Language Server Protocol Client"
HOMEPAGE="https://github.com/kak-lsp/kak-lsp"
SRC_URI="https://github.com/kak-lsp/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"
LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 MIT MPL-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

QA_FLAGS_IGNORED="usr/bin/kak-lsp"

src_install() {
	cargo_src_install
}