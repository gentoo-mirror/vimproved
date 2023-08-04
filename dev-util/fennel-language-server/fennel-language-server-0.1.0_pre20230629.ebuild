# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.10

EAPI=8

CRATES="
	async-trait@0.1.64
	auto_impl@1.0.1
	autocfg@1.1.0
	bitflags@1.3.2
	bytes@1.4.0
	cc@1.0.79
	cfg-if@1.0.0
	clap@4.1.4
	clap_derive@4.1.0
	clap_lex@0.3.1
	countme@3.0.1
	dashmap@5.4.0
	errno-dragonfly@0.1.2
	errno@0.2.8
	form_urlencoded@1.1.0
	futures-channel@0.3.26
	futures-core@0.3.26
	futures-io@0.3.26
	futures-macro@0.3.26
	futures-sink@0.3.26
	futures-task@0.3.26
	futures-util@0.3.26
	futures@0.3.26
	hashbrown@0.12.3
	heck@0.4.1
	hermit-abi@0.2.6
	hermit-abi@0.3.1
	httparse@1.8.0
	idna@0.3.0
	io-lifetimes@1.0.5
	is-terminal@0.4.3
	itoa@1.0.5
	libc@0.2.139
	linux-raw-sys@0.1.4
	lock_api@0.4.9
	log@0.4.17
	lsp-types@0.93.2
	memchr@2.5.0
	memoffset@0.6.5
	mio@0.8.6
	num_cpus@1.15.0
	once_cell@1.17.0
	os_str_bytes@6.4.1
	parking_lot_core@0.9.7
	percent-encoding@2.2.0
	pin-project-internal@1.0.12
	pin-project-lite@0.2.9
	pin-project@1.0.12
	pin-utils@0.1.0
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.51
	quote@1.0.23
	redox_syscall@0.2.16
	regex-syntax@0.6.28
	regex@1.7.1
	ropey@1.6.0
	rowan@0.15.10
	rustc-hash@1.1.0
	rustix@0.36.8
	ryu@1.0.12
	scopeguard@1.1.0
	serde@1.0.152
	serde_derive@1.0.152
	serde_json@1.0.93
	serde_repr@0.1.10
	slab@0.4.7
	smallvec@1.10.0
	socket2@0.4.7
	str_indices@0.4.1
	strsim@0.10.0
	syn@1.0.107
	termcolor@1.2.0
	text-size@1.1.0
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-util@0.7.7
	tokio@1.25.0
	tower-layer@0.3.2
	tower-lsp-macros@0.7.0
	tower-lsp@0.18.0
	tower-service@0.3.2
	tower@0.4.13
	tracing-attributes@0.1.23
	tracing-core@0.1.30
	tracing@0.1.37
	unicode-bidi@0.3.10
	unicode-ident@1.0.6
	unicode-normalization@0.1.22
	url@2.3.1
	version_check@0.9.4
	wasi@0.11.0+wasi-snapshot-preview1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.42.0
	windows-sys@0.45.0
	windows-targets@0.42.1
	windows_aarch64_gnullvm@0.42.1
	windows_aarch64_msvc@0.42.1
	windows_i686_gnu@0.42.1
	windows_i686_msvc@0.42.1
	windows_x86_64_gnu@0.42.1
	windows_x86_64_gnullvm@0.42.1
	windows_x86_64_msvc@0.42.1
"

inherit cargo

FENNEL_LANGUAGE_SERVER_COMMIT="59005549ca1191bf2aa364391e6bf2371889b4f8"

DESCRIPTION="Fennel language server protocol (LSP) support."
HOMEPAGE="https://github.com/rydesun/fennel-language-server"
SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/rydesun/fennel-language-server/archive/${FENNEL_LANGUAGE_SERVER_COMMIT}.tar.gz -> ${P}.tar.gz
"

LICENSE=""
# Dependent crate licenses
LICENSE+="
	MIT Unicode-DFS-2016
	|| ( Apache-2.0 Boost-1.0 )
"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/${PN}-${FENNEL_LANGUAGE_SERVER_COMMIT}"

src_install() {
	cargo_src_install --path "${S}/crates/fennel-language-server"
}
