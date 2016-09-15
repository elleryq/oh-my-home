
" Plugins
call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" vim-jedi
" https://github.com/davidhalter/jedi-vim
Plug 'davidhalter/jedi-vim'

Plug 'kien/ctrlp.vim'

" Add plugins to &runtimepath
call plug#end()

"
set background=dark
set t_Co=256 " make sure our terminal use 256 color
let g:solarized_termcolors = 256

" colorscheme solarized


" ctrlp: invoke by <ctrl-p>
let g:ctrlp_working_path_mode = ''
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10,results:10'
let g:ctrlp_follow_symlinks = 2
let g:ctrlp_max_files = 0 " Unset cap of 10,000 files so we find everything
nnoremap <unique> <leader>bs :CtrlPBuffer<CR>
