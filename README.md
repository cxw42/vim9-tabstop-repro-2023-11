# Repro

**Note:** To repro, revert the "Add the fix" commit.

Testing with FZF and EditorConfig: `make fzf-ec`

## Test conditions

Ubuntu 20.04.6 LTS, `x86_64`

### Vim

Built from source at:
```
e670d1734 (v9.0.2116, origin/master)
```

```
VIM - Vi IMproved 9.0 (2022 Jun 28, compiled Nov 19 2023 15:12:25)
Included patches: 1-2116
Compiled by cxw@cxw-pc
Huge version with GTK2 GUI.  Features included (+) or not (-):
+acl               +file_in_path      +mouse_urxvt       -tag_any_white
+arabic            +find_in_path      +mouse_xterm       -tcl
+autocmd           +float             +multi_byte        +termguicolors
+autochdir         +folding           +multi_lang        +terminal
-autoservername    -footer            -mzscheme          +terminfo
+balloon_eval      +fork()            +netbeans_intg     +termresponse
+balloon_eval_term +gettext           +num64             +textobjects
+browse            -hangul_input      +packages          +textprop
++builtin_terms    +iconv             +path_extra        +timers
+byte_offset       +insert_expand     -perl              +title
+channel           +ipv6              +persistent_undo   +toolbar
+cindent           +job               +popupwin          +user_commands
+clientserver      +jumplist          +postscript        +vartabs
+clipboard         +keymap            +printer           +vertsplit
+cmdline_compl     +lambda            +profile           +vim9script
+cmdline_hist      +langmap           -python            +viminfo
+cmdline_info      +libcall           -python3           +virtualedit
+comments          +linebreak         +quickfix          +visual
+conceal           +lispindent        +reltime           +visualextra
+cryptv            +listcmds          +rightleft         +vreplace
+cscope            +localmap          -ruby              +wildignore
+cursorbind        -lua               +scrollbind        +wildmenu
+cursorshape       +menu              +signs             +windows
+dialog_con_gui    +mksession         +smartindent       +writebackup
+diff              +modify_fname      -sodium            +X11
+digraphs          +mouse             +sound             +xattr
+dnd               +mouseshape        +spell             -xfontset
-ebcdic            +mouse_dec         +startuptime       +xim
+emacs_tags        +mouse_gpm         +statusline        +xpm
+eval              -mouse_jsbterm     -sun_workshop      +xsmp_interact
+ex_extra          +mouse_netterm     +syntax            +xterm_clipboard
+extra_search      +mouse_sgr         +tag_binary        -xterm_save
-farsi             -mouse_sysmouse    -tag_old_static
   system vimrc file: "$VIM/vimrc"
     user vimrc file: "$HOME/.vimrc"
 2nd user vimrc file: "~/.vim/vimrc"
      user exrc file: "$HOME/.exrc"
  system gvimrc file: "$VIM/gvimrc"
    user gvimrc file: "$HOME/.gvimrc"
2nd user gvimrc file: "~/.vim/gvimrc"
       defaults file: "$VIMRUNTIME/defaults.vim"
    system menu file: "$VIMRUNTIME/menu.vim"
  fall-back for $VIM: "/usr/local/share/vim"
Compilation: gcc -c -I. -Iproto -DHAVE_CONFIG_H -DFEAT_GUI_GTK -pthread -I/usr/include/gtk-2.0 -I/usr/lib/x86_64-linux-gnu/gtk-2.0/include -I/usr/include/pango-1.0 -I/usr/include/atk-1.0 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/pango-1.0 -I/usr/include/fribidi -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/harfbuzz -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/uuid -I/usr/include/freetype2 -I/usr/include/libpng16 -O2 -fno-strength-reduce -Wall -Wno-deprecated-declarations -D_REENTRANT -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
Linking: gcc -L/usr/local/lib -Wl,--as-needed -o vim -lgtk-x11-2.0 -lgdk-x11-2.0 -lpangocairo-1.0 -latk-1.0 -lcairo -lgdk_pixbuf-2.0 -lgio-2.0 -lpangoft2-1.0 -lpango-1.0 -lgobject-2.0 -lglib-2.0 -lharfbuzz -lfontconfig -lfreetype -lSM -lICE -lXpm -lXt -lX11 -lXdmcp -lSM -lICE -lm -ltinfo -lelf -lselinux -lcanberra -lrt -lacl -lattr -lgpm -ldl
```

### fzf

- Binary: 0.24.0-1 (3304f28), built from source
- Vim Plugin: 0.44.1 (d7d2ac3)

## Demonstration of the failure

### Steps

1. `make VIM=$path_to_vim9`.  This starts Vim.
2. `:let g:REPRO=1`
3. `lllll` to move the cursor to the `u` in line 1
4. `:FZF`
5. Hit Esc in the FZF popup.

### Expected

The cursor stays on the `u` in line 1.

### Observed

When the FZF popup closes, the cursor is back at column 1 of line 1 (`#`).

## Demonstration of a workaround

Exactly as above, but `:let g:REPRO=2` instead of `1`.  This uses
`let &l:tabstop` instead of `setbufvar(,'&tabstop')`.

### Observed

The cursor stays on the `u` in line 1.

## More information

Say `:messages` to see a bit of debug info from the run.

## Thoughts

This seems to happen on BufFilePost --- maybe there's another issue
similar to <https://github.com/vim/vim/issues/5820>?
