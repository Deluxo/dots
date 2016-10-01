syntax on
filetype plugin indent on
filetype indent on

"CUSTOM MAPPINGS"
"editing"
let mapleader = '`'
nnoremap <c-_> :let @/ = ""<CR>
nnoremap <leader>s :%sno/<c-r><c-w>//g<Left><Left>
vnoremap <leader>s :sno///g<Left><Left><Left>
vnoremap <s-j> :m '>+1<CR>gv=gv
vnoremap <s-k> :m '<-2<CR>gv=gv
"window management"
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-l> :wincmd l<CR>
map QQ :bd<CR>
"usability"
nnoremap Q <Nop>
map <F11> : !ctags

"SETTINGS"
"search"
set ignorecase
set smartcase
set incsearch
set hlsearch
"usability"
set scrolloff=10
set relativenumber
set fileencodings=utf-8
set encoding=utf-8
set clipboard=unnamedplus
set mouse=a
set autoread
set autoindent
set smartindent
"presentability"
set wrap
set linebreak
set foldmethod=indent
set foldlevel=0
set nofoldenable
set list
set listchars=tab:│\ ,trail:•,eol:¬
set ttyfast
set cursorline
set synmaxcol=500
set t_Co=256
set wildmode=full
set wildmenu
set background=dark
set tabstop=4
set shiftwidth=4

let g:kolor_italic=1
let g:kolor_bold=1
let g:kolor_underlined=0
let g:kolor_alternative_matchparen=0
colorscheme kolor

"AUTO SETTINGS"
"general"
function! DeleteEmptyBuffers()
	let [i, n; empty] = [1, bufnr('$')]
	while i <= n
		if bufexists(i) && bufname(i) == ''
			call add(empty, i)
		endif
		let i += 1
	endwhile
	if len(empty) > 0
		exe 'bdelete' join(empty)
	endif
endfunction
au BufHidden call DeleteEmptyBuffers()

"PATHOGEN"
execute pathogen#infect()
