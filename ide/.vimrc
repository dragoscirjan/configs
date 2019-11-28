"" https://www.youtube.com/watch?v=gnupOrSEikQ


if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Utils
Plug 'junegunn/vim-plug'

" Make it more IDEish

Plug 'scrooloose/nerdtree'


" HTML
Plug 'mattn/emmet-vim'

" Initialize plugin system
call plug#end()


"
" Make it more IDEish
"

" Toggle Nerd Tree
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>


" HTML
let g:user_emmet_mode='a'    "enable all function in all mode.
"Enable just for html/css
"let g:user_emmet_install_global = 0
"autocmd FileType html,css,javascript EmmetInstall




