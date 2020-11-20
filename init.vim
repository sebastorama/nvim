call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-sleuth'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-tsserver', 'coc-eslint', 'coc-angular', 'coc-html', 'coc-sh']

color gruvbox
set ts=2 sw=2 et
set nu

let mapleader = ","
map <leader>f :GFiles<CR>
map <leader>s :nohl<CR>

