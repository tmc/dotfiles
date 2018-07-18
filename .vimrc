" don't panic.
"
" tmc's vimrc
"
" Also don't blindly use someone else's editor configuration.
""{{{ bootstrap
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"}}}

"{{{ plugins
call plug#begin()
Plug 'junegunn/vim-plug'
"{{{ core plugins
"{{{ fundamentals
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wsdjeg/vim-fetch'
"Plug 'tpope/vim-sensible'
"Plug 'tpope/vim-dispatch'
"}}}
"{{{ tools
Plug 'Shougo/vinarise.vim'
Plug 'chrisjohnson/vim-grep'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'markonm/traces.vim'
Plug 'mbbill/undotree'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
"}}}
"{{{ flair
Plug 'airblade/vim-gitgutter'
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"}}}

"{{{ completion+snippets
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
"}}}
"{{{ experiments
Plug 'dbeniamine/cheat.sh-vim'
Plug 'kana/vim-textobj-user'
Plug 'natebosch/vim-lsc'
Plug 'somini/vim-textobj-fold'
Plug 'tpope/vim-vinegar'
Plug 'tmc/vimscripts', { 'rtp': 'git-backups', 'as': 'tmc-git-backups' }
"}}}
"}}}

"{{{ language support
Plug 'Quramy/tsuquyomi'
Plug 'fatih/vim-go'
Plug 'gf3/peg.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'rhysd/vim-grammarous'
Plug 'sheerun/vim-polyglot'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'vadv/vim-chef'
Plug 'vim-scripts/SWIG-syntax'
"}}}
call plug#end()
"}}}

"{{{ basics
" basics
set nocompatible
set smartindent
set autoindent
set tabstop=4
set backspace=indent,eol,start

set path+=**
set switchbuf=useopen,usetab

set history=10000

filetype plugin indent on

silent! colorscheme jellybeans
set cursorline
set ruler
set modeline
"set t_Co=256
let g:netrw_liststyle=3
set bg=dark

set wildmenu
set wildmode=longest:full,full

set encoding=utf-8
set laststatus=2
set relativenumber
set number

" undo,backup,swap
set swapfile
set undofile
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
silent !test -d ~/.vimrc/.swp || mkdir -p ~/.vim/.{undo,backup,swp}

set scrolloff=5

set hlsearch
set incsearch
"slient! execute 'source .vimrclocal'

" color to col 128
set synmaxcol=128
" 80 col highlight
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

" balloons! (kinda buggy)
set ballooneval
set balloonevalterm

"}}}

"{{{ abbrevations
"}}}

"{{{ tags conf
set tags+=./.tags,.tags;
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_file_list_command = 'git ls-files'

"}}}

"{{{ mappings
" quickfix
map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" splits
set splitbelow
set splitright
nnoremap <leader>w <C-W>w
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" rando
"nmap ; :Buffers<CR>
"nmap <Leader>t :Files<CR>
nmap <Leader>f :Find<CR>
nmap <Leader>t :Tags<CR>

" neosnippet:
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

"}}}

"{{{ plugin configuration
" airline
let g:airline_theme='minimalist'
"let g:airline_section_z=''
"set statusline+=:%o

" gitgutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" ctrlp
" also search buffers/tabs
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }

" rg
let g:vimgrep_rg_command="rg --vimgrep --color=never --no-heading"
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" language server
let g:lsc_server_commands = {'python': 'pyls'}
let g:lsc_auto_map = v:true " Use defaults
"}}}

"{{{ language support

" jsx support
let g:jsx_ext_required = 0

" es6 support
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

" ruby support
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

"{{{ go
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_auto_type_info = 1

" mappings
"au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>gd <Plug>(go-def)
au FileType go nmap <Leader>gt <Plug>(go-def-tab)
au FileType go nmap <Leader>gs <Plug>(go-def-split)
au FileType go nmap <Leader>in <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
"au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>ss <Plug>(go-debug-step)
au FileType go nmap <Leader>sn <Plug>(go-debug-next)
au FileType go nmap <Leader>so <Plug>(go-debug-step-out)
au FileType go nmap <Leader>sc <Plug>(go-debug-continue)
au FileType go nmap <Leader>sb <Plug>(go-debug-breakpoint)

au Filetype go nmap <leader>ie :GoIfErr <CR>

"au Filetype go nnoremap <leader>r :GoRun %<CR>

au Filetype go nnoremap <leader>t :GoTest <CR>
au Filetype go nnoremap <leader>b :GoBuild  <CR>
au Filetype go nnoremap <leader>e :GoErrCheck <CR>
au Filetype go nmap <leader>l :GoLint <CR>
"au FileType go nmap <Leader>L :GoMetaLinter <CR>

au FileType go nmap <leader>L <Plug>(go-metalinter)

au FileType go nmap <Leader>dd <Plug>(go-doc)
au FileType go nmap <Leader>db <Plug>(go-doc-browser)
au FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
au FileType go nmap <Leader>C :GoGoverageBrowser <CR>

"let g:go_metalinter_autosave = 1
"let g:go_metalinter_autosave_enabled = ['vet']

let g:go_auto_sameids = 1

" eslint fix
au FileType javascript.jsx nmap <Leader>f :!$(npm bin)/eslint --fix % <CR>

" typescript
au FileType typescript nmap <Leader>gd :TsuDefinition <CR>
au FileType typescript nmap <Leader>gt :tabe % <CR> <Bar> :sleep 1 <Bar> :TsuDefinition <CR>
au FileType typescript nmap <Leader>gs :vsplit <CR> <Bar> :sleep 1 <Bar> :TsuDefinition <CR>
au FileType typescript nmap <Leader>f :!yarn fix <CR> <CR>

" js
au FileType javascript.jsx nmap <Leader>dd :TernDef<CR>
au FileType javascript.jsx nmap <Leader>dt :TernDefTab<CR>

" markdown
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<C-m>'
"let g:vim_markdown_folding_disabled = 1
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" swig
autocmd BufNewFile,BufReadPost *.swigcxx set filetype=swig
"}}}
"}}}

"{{{ completion
set completeopt=longest,menuone
set omnifunc=syntaxcomplete#Complete

" neocomplete.
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2

" tsuquyomi
let g:tsuquyomi_completion_detail = 1
autocmd FileType typescript setlocal completeopt+=menu,preview
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

"}}}

" vim:foldmethod=marker foldlevel=1
