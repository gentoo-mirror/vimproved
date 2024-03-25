# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.2

EAPI=8

CRATES="
	adler32@1.2.0
	adler@1.0.2
	anyhow@1.0.44
	approx@0.3.2
	arrayvec@0.7.2
	atty@0.2.14
	autocfg@1.0.1
	base16_color_scheme@0.3.0
	beef@0.5.2
	bitflags@1.3.2
	bytemuck@1.7.2
	byteorder@1.4.3
	calm_io@0.1.1
	calmio_filters@0.1.0
	cfg-if@1.0.0
	clap@3.0.0-beta.4
	clap_derive@3.0.0-beta.4
	clap_generate@3.0.0-beta.4
	color-thief@0.2.1
	color_quant@1.1.0
	crc32fast@1.2.1
	crossbeam-channel@0.5.1
	crossbeam-deque@0.8.1
	crossbeam-epoch@0.9.5
	crossbeam-utils@0.8.8
	deflate@0.8.6
	dirs-next@2.0.0
	dirs-sys-next@0.1.2
	dirs-sys@0.3.6
	dirs@3.0.2
	dtoa@0.4.8
	either@1.6.1
	fnv@1.0.7
	getrandom@0.1.16
	getrandom@0.2.3
	gif@0.11.3
	glob@0.3.0
	hashbrown@0.11.2
	heck@0.3.3
	hermit-abi@0.1.19
	hex@0.4.3
	image@0.23.14
	indexmap@1.7.0
	jpeg-decoder@0.1.22
	lazy_static@1.4.0
	libc@0.2.105
	linked-hash-map@0.5.4
	logos-derive@0.12.1
	logos@0.12.1
	memchr@2.5.0
	memoffset@0.6.4
	minimal-lexical@0.2.1
	miniz_oxide@0.3.7
	miniz_oxide@0.4.4
	nom@7.1.3
	num-integer@0.1.44
	num-iter@0.1.42
	num-rational@0.3.2
	num-traits@0.2.14
	num_cpus@1.13.0
	os_str_bytes@3.1.0
	palette@0.5.0
	palette_derive@0.5.0
	phf@0.8.0
	phf_codegen@0.8.0
	phf_generator@0.8.0
	phf_shared@0.8.0
	png@0.16.8
	ppv-lite86@0.2.15
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.56
	quote@1.0.26
	ramhorns@0.14.0
	rand@0.7.3
	rand_chacha@0.2.2
	rand_core@0.5.1
	rand_hc@0.2.0
	rand_pcg@0.2.1
	rayon-core@1.9.1
	rayon@1.5.1
	redox_syscall@0.2.10
	redox_users@0.4.0
	regex-syntax@0.6.29
	rgb@0.8.29
	scoped_threadpool@0.1.9
	scopeguard@1.1.0
	serde@1.0.159
	serde_derive@1.0.159
	serde_yaml@0.8.21
	shell-words@1.0.0
	shellexpand@2.1.0
	siphasher@0.3.7
	strsim@0.10.0
	syn@1.0.81
	syn@2.0.13
	termcolor@1.1.2
	terminal_size@0.1.17
	textwrap@0.14.2
	tiff@0.6.1
	toml@0.5.8
	unicode-ident@1.0.8
	unicode-segmentation@1.8.0
	unicode-width@0.1.9
	unicode-xid@0.2.2
	vec_map@0.8.2
	version_check@0.9.3
	wasi@0.10.2+wasi-snapshot-preview1
	wasi@0.9.0+wasi-snapshot-preview1
	weezl@0.1.5
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	yaml-rust@0.4.5
"

inherit cargo

DESCRIPTION="An easy to use base16 scheme manager/builder that integrates with any workflow."
HOMEPAGE="https://github.com/misterio77/flavours"
SRC_URI="
	https://github.com/Misterio77/flavours/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 GPL-3 MIT Unicode-DFS-2016 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
