syntax on

set relativenumber
set hidden
set nohlsearch
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set noshowmode
set scrolloff=8
set encoding=UTF-8
set incsearch

set guifont=DroidSansMono\ Nerd\ Font\ 11

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=50

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin("~/.vim/plugged")
	Plug 'vim-airline/vim-airline'
	Plug 'dbeniamine/cheat.sh-vim'

	" Color Theme
	Plug 'morhetz/gruvbox'

	" Auto closing
	Plug 'jiangmiao/auto-pairs'

	" fzf
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'

	" git
	Plug 'tpope/vim-fugitive'

	Plug 'vim-utils/vim-man'
	Plug 'mbbill/undotree'

	" Autocomplete and highlighting
	Plug 'neoclide/coc.nvim', {'branch': 'release'} 
	Plug 'othree/yajs.vim'
	Plug 'pangloss/vim-javascript'
	Plug 'mxw/vim-jsx'

	" Tree and icons
	Plug 'scrooloose/nerdtree'
call plug#end()

colorscheme gruvbox
set background=dark

let mapleader = "\<Space>"

" Move between panes
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

" NERDTree Setup
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <leader>pv :NERDTreeToggle<CR>

" open new slip panes to right and below
set splitright
set splitbelow
" turn the terminal to normal mode with esc
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" Open terminal on ctrl+n
function! OpenTerminal()
	split term://zsh
	resize 10
endfunction
nnoremap <C-n> :call OpenTerminal()<CR>

" fzf
nnoremap <C-p> :GFiles<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
\}

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

" Coc autocompletion and highlighting
let g:coc_global_extensions = [
	\ 'coc-emmet',
	\ 'coc-css',
	\ 'coc-eslint',
	\ 'coc-fzf-preview',
	\ 'coc-highlight',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-prettier',
	\ 'coc-python',
	\ 'coc-pyright',
	\ 'coc-sh',
	\ 'coc-snippets',
	\ 'coc-yaml',
	\ 'coc-yank'
\]

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nnoremap <silent> <leader>d :<C-u>CocList diagnostics<CR>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Github with vim fugitive
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>
