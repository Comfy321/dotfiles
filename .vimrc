"Yay~ Pyxel's vimrc
"refresh vimrc automatically
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

"Inportant base vim settings
:syntax on
:set number
:set mouse=a
:set laststatus=2
:set noshowmode
:set cursorline "note: make this toggleable
:set ruler
"plugin vars
let g:neocomplete#enable_at_startup = 1
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
let g:table_mode_corner_corner="+"
let g:table_mode_header_fillchar="="
"NERDcommenter Settings:
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
"let g:NERDCustomDelimiters = { 'rs': { 'left': '/**', 'right': '*/' } }

"func to hide statusbar
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <S-h> :call ToggleHiddenAll()<CR>
 " Required:
 set runtimepath^=~/.vim/bundle/neobundle.vim/

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'rust-lang/rust.vim' "support for rust highlighting
NeoBundle 'Shougo/neocomplete.vim' "autocompletion
NeoBundle 'ervandew/supertab' 
NeoBundle 'scrooloose/nerdtree' "file manager
NeoBundle 'scrooloose/nerdcommenter' "neat!
NeoBundle 'shougo/vimfiler.vim' 
NeoBundle 'itchyny/lightline.vim' "very nice minimal line 
NeoBundle 'dhruvasagar/vim-table-mode' "very useful
 call neobundle#end()

 " Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck

