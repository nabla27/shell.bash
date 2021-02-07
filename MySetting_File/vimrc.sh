"===================================================2020-12-28
set number

"===================================================2020-12-28
set clipboard=unnamedplus


"===================================================2020-12-28
"=========
"vim-clang
"=========
" 'Shougo/neocomplete.vim' {{{
let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"""}}}

" 'justmao945/vim-clang' {{{

" disable auto completion for vim-clanG
let g:clang_auto = 0
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

" default 'longest' can not work with neocomplete
let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

let g:clang_exec = 'clang'
let g:clang_format_exec = 'clang-format'

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '
  \ -std=c++1z
  \ -stdlib=libc++
  \ -pedantic-errors
  \ '

" }}}

"==========
"dein.vim
"==========
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/dein.vim')

call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('justmao945/vim-clang')
call dein#add('Shougo/neoinclude.vim')

call dein#end()

"=================================================2020-12-28
syntax on
"=================================================2020-12-29
"add auto indent function for c language.
set cindent
"=================================================2020-12-30
"setting width of tab to 4.
set tabstop=4
set shiftwidth=4

