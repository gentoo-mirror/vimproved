project('libvterm', 'c', version : '0.3.2')

incdir = include_directories('include')

pkg = import('pkgconfig')

libvterm = library('vterm',
                   'src/encoding.c',
                   'src/keyboard.c',
                   'src/mouse.c',
                   'src/parser.c',
                   'src/pen.c',
                   'src/screen.c',
                   'src/state.c',
                   'src/unicode.c',
                   'src/vterm.c',
                   install : true,
                   version : '0.0.0',
                   include_directories : incdir)
executable('unterm', 'bin/unterm.c', link_with : libvterm, install : true, include_directories : incdir)
executable('vterm-ctrl', 'bin/vterm-ctrl.c', link_with : libvterm, install : true, include_directories : incdir)
executable('vterm-dump', 'bin/vterm-dump.c', link_with : libvterm, install : true, include_directories : incdir)

install_headers('include/vterm.h',
                'include/vterm_keycodes.h')
pkg.generate(libvterm,
             description : 'Abstract VT220/Xterm/ECMA-48 emulation library')
