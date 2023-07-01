# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite has too new tasty
CABAL_HACKAGE_REVISION="2"
inherit haskell-cabal

DESCRIPTION="For creating, comparing, parsing and printing Universally Unique Identifiers"
HOMEPAGE="https://github.com/haskell-hvr/uuid"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RESTRICT=test

RDEPEND=">=dev-haskell/cryptohash-md5-0.11.100:=[profile?] <dev-haskell/cryptohash-md5-0.12:=[profile?]
	>=dev-haskell/cryptohash-sha1-0.11.100:=[profile?] <dev-haskell/cryptohash-sha1-0.12:=[profile?]
	>=dev-haskell/entropy-0.3.7:=[profile?] <dev-haskell/entropy-0.5:=[profile?]
	>=dev-haskell/network-info-0.2:=[profile?] <dev-haskell/network-info-0.3:=[profile?]
	>=dev-haskell/random-1.1:=[profile?] <dev-haskell/random-1.3:=[profile?]
	>=dev-haskell/uuid-types-1.0.5:=[profile?] <dev-haskell/uuid-types-1.0.6:=[profile?]
	>=dev-lang/ghc-8.4.3:=
	>=dev-haskell/text-1.2.3.0:=[profile?] <dev-haskell/text-2.1:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1"
# 	test? ( >=dev-haskell/quickcheck-2.14.2 <dev-haskell/quickcheck-2.15
# 		>=dev-haskell/tasty-1.4.0.1 <dev-haskell/tasty-1.5
# 		>=dev-haskell/tasty-hunit-0.10 <dev-haskell/tasty-hunit-0.11
# 		>=dev-haskell/tasty-quickcheck-0.10 <dev-haskell/tasty-quickcheck-0.11 )
# "
