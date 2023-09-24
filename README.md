# vimproved's Portage Overlay
Hi! This is my portage overlay, containing various ebuilds I use and maintain.

Policies:
- All commits must have a signoff.
- All commits must be GPG signed.
- Any ebuild that overrides a package in ::gentoo must be unkeyworded.
- Any ebuild that I deem experimental will be unkeyworded.
- Commit messages must follow the same format as ::gentoo commits.

## Best practices for overlays
For all overlays, I recommend you mask all packages in them and then selectively unmask only the ones you want. To do this, add `"*/*::vimproved"` to `/etc/portage/package.mask`, and then add `category/pkg::vimproved` to `/etc/portage/package.unmask` for all packages you want to install.
