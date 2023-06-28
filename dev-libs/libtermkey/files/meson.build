project('libtermkey', 'c', version : '0.22')

pkg = import('pkgconfig')

ncurses_dep = dependency('ncurses', required : true)

libtermkey = library('termkey',
                   'driver-csi.c',
                   'driver-ti.c',
                   'termkey.c',
                   install : true,
                   version : '1.14.2',
                   dependencies : ncurses_dep)
install_headers('termkey.h')
pkg.generate(libtermkey,
             description : 'Abstract terminal key input library')
