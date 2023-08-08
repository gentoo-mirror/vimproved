# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@0.7.18
	aho-corasick@1.0.1
	anes@0.1.6
	anyhow@1.0.71
	assert_cmd@2.0.4
	atty@0.2.14
	autocfg@1.0.1
	beef@0.5.2
	bitflags@1.3.2
	bstr@0.2.16
	bstr@1.4.0
	bumpalo@3.12.0
	bytecount@0.6.3
	cast@0.3.0
	cfg-if@1.0.0
	ciborium-io@0.2.0
	ciborium-ll@0.2.0
	ciborium@0.2.0
	clap@3.1.6
	clap_derive@3.1.4
	console@0.15.7
	convert_case@0.4.0
	criterion-plot@0.5.0
	criterion@0.4.0
	crossbeam-channel@0.5.8
	crossbeam-deque@0.8.1
	crossbeam-epoch@0.9.5
	crossbeam-utils@0.8.7
	derive_more@0.99.16
	difflib@0.4.0
	doc-comment@0.3.3
	dtoa@0.4.8
	ec4rs@1.0.2
	either@1.6.1
	encode_unicode@0.3.6
	env_logger@0.10.0
	fnv@1.0.7
	full_moon@0.18.1
	full_moon_derive@0.11.0
	globset@0.4.10
	half@1.7.1
	hashbrown@0.11.2
	heck@0.4.0
	hermit-abi@0.1.19
	hermit-abi@0.2.6
	ignore@0.4.20
	indexmap@1.7.0
	insta@1.12.0
	itertools@0.10.1
	itoa@1.0.1
	js-sys@0.3.55
	lazy_static@1.4.0
	libc@0.2.119
	linked-hash-map@0.5.4
	log@0.4.19
	logos-derive@0.12.1
	logos@0.12.1
	memchr@2.5.0
	memoffset@0.6.4
	num-traits@0.2.14
	num_cpus@1.15.0
	once_cell@1.9.0
	oorandom@11.1.3
	os_str_bytes@6.0.0
	paste@1.0.12
	pest@2.1.3
	plotters-backend@0.3.2
	plotters-svg@0.3.1
	plotters@0.3.1
	predicates-core@1.0.3
	predicates-tree@1.0.5
	predicates@2.1.1
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.56
	quote@1.0.26
	rayon-core@1.9.1
	rayon@1.5.1
	regex-automata@0.1.10
	regex-syntax@0.6.29
	regex-syntax@0.7.1
	regex@1.8.1
	rustc_version@0.3.3
	rustversion@1.0.9
	ryu@1.0.5
	same-file@1.0.6
	scopeguard@1.1.0
	semver-parser@0.10.2
	semver@0.11.0
	serde@1.0.164
	serde_derive@1.0.164
	serde_json@1.0.96
	serde_yaml@0.8.21
	similar@2.1.0
	smol_str@0.1.24
	strsim@0.10.0
	strum@0.24.1
	strum_macros@0.24.3
	syn@1.0.76
	syn@2.0.15
	termcolor@1.1.3
	termtree@0.2.4
	textwrap@0.15.0
	thiserror-impl@1.0.40
	thiserror@1.0.40
	thread_local@1.1.7
	threadpool@1.8.1
	tinytemplate@1.2.1
	toml@0.5.11
	ucd-trie@0.1.3
	unicode-ident@1.0.8
	unicode-width@0.1.8
	unicode-xid@0.2.2
	version_check@0.9.3
	wait-timeout@0.2.0
	walkdir@2.3.2
	wasm-bindgen-backend@0.2.81
	wasm-bindgen-macro-support@0.2.81
	wasm-bindgen-macro@0.2.81
	wasm-bindgen-shared@0.2.81
	wasm-bindgen@0.2.81
	web-sys@0.3.55
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.45.0
	windows-targets@0.42.2
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_msvc@0.42.2
	windows_i686_gnu@0.42.2
	windows_i686_msvc@0.42.2
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_msvc@0.42.2
	yaml-rust@0.4.5
"

inherit cargo

DESCRIPTION="A code formatter for Lua"
HOMEPAGE="https://github.com/JohnnyMorganz/StyLua"
SRC_URI="
	https://github.com/JohnnyMorganz/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MPL-2.0"
LICENSE+=" Apache-2.0 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
