"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
"
"                        MY NEOVIM VIMRC FILE                             
"
"
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

"================================================= 
""               Plugins
"================================================= 
" Plugins will go here in the middle.

call plug#begin('~/.local/share/nvim/plugged')
" Auto complete plugins
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Python completion integrated in deoplete
Plug 'zchee/deoplete-jedi'
" Support for virtualenv
Plug 'plytophogy/vim-virtualenv'
" Syntax checker (supports Python)
Plug 'w0rp/ale'
" File explorer
Plug 'scrooloose/nerdtree'
" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Solarized colorscheme
Plug 'iCyMind/NeoSolarized'
Plug 'altercation/vim-colors-solarized'
" Solarized colorscheme with neovim-qt support
Plug 'JulioJu/neovim-qt-colors-solarized-truecolor-only'
" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

"================================================
" Basic Settings
"================================================

" turn filetype detection, indent scripts and filetype plugins on
filetype plugin indent on
set encoding=utf-8
" copy indent from current line when starting a new line
set autoindent
" syntax highlighting
syntax enable
" Copies using system clipboard
set clipboard+=unnamedplus
" display line number relatively to the current one
set rnu
" highlight the current line and column
set cursorline
set cursorcolumn
" <tab> inserts spaces instead of tabs
set expandtab
" set softtabstop=0
" size of <tab> measured in spaces 
set tabstop=4
" size of an indent, 4 spaces to match <tab>
set shiftwidth=4
" enable mouse
set mouse=a
" disable text wrapping
set textwidth=0

"============================
" Colorscheme
"============================

" use solarized as colorscheme
" colorscheme kalisi "solarized
set termguicolors
" default value is "normal", Setting this option to "high" or "low" does use the 
" same Solarized palette but simply shifts some values up or down in order to 
" expand or compress the tonal range displayed.
let g:neosolarized_contrast = "normal"

" Special characters such as trailing whitespace, tabs, newlines, when displayed 
" using ":set list" can be set to one of three levels depending on your needs. 
" Default value is "normal". Provide "high" and "low" options.
let g:neosolarized_visibility = "normal"

" I make vertSplitBar a transparent background color. If you like the origin solarized vertSplitBar
" style more, set this value to 0.
let g:neosolarized_vertSplitBgTrans = 1
set background=dark
colorscheme NeoSolarized

"============================
" Basic Mappings
"============================
" make jk to be esc
inoremap jk <ESC>
" splits behaviour
set splitbelow
set splitright
"
" set moving between windows to ctrl+hjkl
noremap <silent> <C-l> <C-w>l
noremap <silent> <C-h> <C-w>h
noremap <silent> <C-k> <C-w>k
noremap <silent> <C-j> <C-w>j


" make it easy to leave terminal
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
:au BufEnter * if &buftype == 'terminal' | :startinsert | endif
"============================
" Auto commands
"============================
" remove blank characters at the end of every line when saving file,
" need to be disabled for some filetypes like markdown or latex
" where trailing spaces are important
autocmd FileType c,cpp,java,python,javascript autocmd BufWritePre <buffer> %s/\s\+$//e

"================================================
" Deoplete Settings
"================================================

let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"

""========================
" Easymotion
"========================"
map <Leader> <Plug>(easymotion-prefix)

"========================"
" Ale
"========================"
nmap <silent> <C-W>k <Plug>(ale_previous_wrap)
nmap <silent> <C-W>j <Plug>(ale_next_wrap)

"========================
" Airline
"========================
" default setting of 'laststatus' is for the statusline to not appear until a split is created,
" set to 2 to appear all the time
"set laststatus=2
" use powerline font (need manual install)
"let g:airline_powerline_fonts = 1

"========================
" NerdTree
"========================
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
" close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
	if exists("t:NERDTreeBufName")
		if bufwinnr(t:NERDTreeBufName) != -1
			if winnr("$") == 1
				q
			endif
		endif
	endif
endfunction
" toggle file explorer visibility
map <C-A> :NERDTreeToggle<CR>

"=====================================================
"" Python settings
"=====================================================

"Path to python virtualenv where neovim is install
let g:deoplete#enable_at_startup=1
let g:deoplete#auto_complete=1
let g:python_host_prog = '/home/tbf/miniconda3/envs/neovim2/bin/python'
let g:python3_host_prog = expand('~/miniconda3/envs/neovim3/bin/python3')
let g:deoplete#sources#jedi#python_path = 'python3'

let python_highlight_all = 1

nmap <silent> <C-m> <Plug>(pydocstring)

"========================
" Jedi
"========================
let g:jedi#auto_close_doc = 0  " close scratch/preview window after completion
