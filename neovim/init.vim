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

" Add plugins to &runtimepath
call plug#end()

"
set background=dark
set t_Co=256 " make sure our terminal use 256 color
let g:solarized_termcolors = 256

" colorscheme solarized
