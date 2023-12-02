# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Easy to integrate Vulkan memory allocation library"
HOMEPAGE="https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator"
EGIT_COMMIT="5e43c795daf43dd09398d8307212e85025215052"
SRC_URI="https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/VulkanMemoryAllocator-${EGIT_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

src_configure() {
	local mycmakeargs=(
		-DVMA_BUILD_DOCUMENTATION=OFF
		-DVMA_BUILD_SAMPLES=OFF
	)

	cmake_src_configure
}
