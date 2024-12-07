# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Easy to integrate Vulkan memory allocation library"
HOMEPAGE="https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator"
SRC_URI="https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/VulkanMemoryAllocator-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
