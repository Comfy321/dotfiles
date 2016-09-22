:syntax on
:set number
:set mouse=a
autocmd VimEnter * NERDTree
let NERDTreeWinSize = 15
let NERDTreeMinimalUI = 1
let g:neocomplete#enable_at_startup = 1
let g:SuperTabDefaultCompletionType = "<c-n>"
set laststatus=2
set guifont=Source\ Code\ Pro\ for\ Powerline "make sure to escape the spaces in the name propel 
set 

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
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'shougo/vimfiler.vim'
 call neobundle#end()

 " Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck


