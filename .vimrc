" tmc's vimrc
" don't panic.
" Also, don't blindly use someone else's editor configuration.
""{{{ bootstrap (automatically install vim-plug in new environments)
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -sfLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"}}}

" plugins {{{
call plug#begin()
Plug 'junegunn/vim-plug'
" core plugins {{{
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wsdjeg/vim-fetch'
Plug 'tpope/vim-dispatch'
"Plug 'tpope/vim-sensible'
"}}}
" tools {{{
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/local_vimrc'
Plug 'Shougo/vinarise.vim'
Plug 'chrisjohnson/vim-grep'
Plug 'majutsushi/tagbar'
Plug 'markonm/traces.vim'
Plug 'mbbill/undotree'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'ludovicchabant/vim-gutentags'
"}}}
" flair {{{
Plug 'airblade/vim-gitgutter'
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"}}}
" completion+snippets {{{
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
"Plug 'Shougo/neocomplete.vim'
"}}}
" experiments {{{
Plug 'chiedo/vim-px-to-em'
Plug 'bazelbuild/vim-bazel'
Plug 'junegunn/fzf.vim'
Plug 'terrastruct/d2-vim'
"Plug 'dbeniamine/cheat.sh-vim'
Plug 'google/vim-maktaba'
Plug 'hashivim/vim-terraform'
Plug 'kana/vim-textobj-user'
Plug 'michaeljsmith/vim-indent-object'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'rhysd/git-messenger.vim'
Plug 'somini/vim-textobj-fold'
Plug 'tmc/vimscripts', { 'rtp': 'git-backups', 'as': 'tmc-git-backups' }
Plug 'vim-scripts/dbext.vim'
Plug 'dense-analysis/ale'
Plug 'bufbuild/vim-buf'
Plug 'whiteinge/diffconflicts'
Plug 'github/copilot.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
if !has('nvim')
  Plug 'tmc/vimscripts', { 'rtp': 'git-backups', 'as': 'tmc-git-backups' }
endif
""}}}

" language support {{{
"Plug 'Quramy/tsuquyomi'
Plug 'cappyzawa/starlark.vim'
Plug 'fatih/vim-go'
"Plug 'davidhalter/jedi-vim'
Plug 'gf3/peg.vim'
" Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'rhysd/vim-grammarous'
Plug 'sheerun/vim-polyglot'
" Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-bundler'
" Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'vadv/vim-chef'
Plug 'vim-scripts/SWIG-syntax'
"}}}
call plug#end()
"}}}

" basics {{{
" basics
set nocompatible
set smartindent
set autoindent
set tabstop=4
set backspace=indent,eol,start

set path+=**
set switchbuf=useopen,usetab

set history=10000
set exrc

if !has('nvim')
  set cryptmethod=blowfish2
endif

filetype plugin indent on

set wildmenu
set wildmode=longest:full,full
set wildignore+=**/node_modules/**

set encoding=utf-8
set laststatus=2
set relativenumber
set number
set statusline+=%{gutentags#statusline()}

" tag config
" let g:gutentags_trace = 1

" undo,backup,swap
set swapfile
set noswapfile
set undofile
set undodir=~/.vim/.undo/
set backupdir=~/.vim/.backup/
set directory=~/.vim/.swp/
if has('nvim')
  set undodir=~/.vim/.nundo/
  set backupdir=~/.vim/.nbackup/
  set directory=~/.vim/.nswp/
endif
if !isdirectory("~/.vim/.swp")
    silent !mkdir ~/.vim/.swp > /dev/null 2>&1
    silent !mkdir ~/.vim/.undo > /dev/null 2>&1
    silent !mkdir ~/.vim/.backup > /dev/null 2>&1
endif

" visuals
set cursorline
set ruler
set modeline
set t_Co=256
let g:netrw_liststyle=3
set bg=dark
silent! colorscheme jellybeans
set scrolloff=5
" searching
set hlsearch
set incsearch

packadd! matchit
" color to col 128
set synmaxcol=128
" folds
set foldcolumn=3
set foldlevel=2

set mouse=a
" }}}
"
" completion {{{
set omnifunc=syntaxcomplete#Complete
set completeopt=menuone
set completeopt+=noselect
set completeopt+=noinsert
set completeopt+=preview
set shortmess+=c
set belloff+=ctrlg
"}}}

" mappings {{{
" quickfix
map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

inoremap . .<C-x><C-o>

nmap gx yiW:!open <cWORD><CR> <C-r>" & <CR><CR>

" OS keyboard yanking
vmap <Leader>y "+y
vmap <Leader>p "+p
nnoremap <Leader>y "+yy
nnoremap <Leader>p "+p
nnoremap <Leader>Y "*y
nnoremap <Leader>P "*p

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

" neosnippet:
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

vnoremap <leader>p :<C-U>ShadenPatchSelection<CR>
nnoremap <leader>p :<C-U>ShadenPatchLine<CR>
nnoremap <leader>r :<C-U>ShadenRepatch<CR>

" let g:netrw_http_xcmd='-s -n -o'
"}}}

" abbrevations {{{
"}}}

" tags {{{
set tags+=./.tags,.tags;
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_cache_dir = '~/.vim/tags'

"}}}

" plugin configuration {{{
" ale
let g:ale_completion_enabled=1
"let g:ale_floating_preview = 1
let g:ale_set_balloons = 1
"let g:ale_hover_to_preview = 1
let g:ale_hover_to_floating_preview = 1
let g:ale_python_pyls_executable='pyls'
let g:go_gopls_options = ['-rpc.trace']
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_doc_url='https://pkg.go.dev/'
let g:ale_linters = {
\  'go': ['gopls'],
\  'python': ['pyright'],
\  'cpp': ['clang'],
\  'proto': ['buf-check-lint'],
\}
" \  'typescript': ['tsserver', 'typecheck', 'tslint'],
" \  'typescript': ['tslint'],
let g:ale_fixers = {
\  'java': ['google_java_format'],
\  'python': ['black'],
\  'javascript': ['eslint', 'prettier'],
\  'typescript': ['eslint','prettier'],
\  'typescriptreact': ['eslint','prettier'],
\  'javascript.jsx': ['eslint', 'prettier'],
\  'jsx': ['eslint', 'prettier'],
\}
let g:ale_fix_on_save=1
let g:ale_history_enabled = 1
let g:ale_history_log_output = 1
let g:airline#extensions#ale#enabled = 1

" airline
let g:airline_theme='minimalist'
let g:airline_section_z=''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

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

"}}}

" LSP
nmap <Leader>gd :ALEGoToDefinition <CR>

" jsx support
let g:jsx_ext_required = 0

" es6 support
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

" ruby support
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" go {{{
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
let g:go_fmt_command = "goimports"

" mappings
au FileType go nmap <Leader>e <Plug>(go-rename)
au Filetype go nnoremap <leader>t :GoTest <CR>
au Filetype go nnoremap <leader>b :GoBuild  <CR>
au Filetype go nnoremap <leader>e :GoErrCheck <CR>
au Filetype go nmap <leader>l :GoLint <CR>
au FileType go nmap <Leader>dd <Plug>(go-doc)
au FileType go nmap <Leader>db <Plug>(go-doc-browser)
au FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
au FileType go nmap <Leader>C :GoGoverageBrowser <CR>
"}}}

" eslint fix
au FileType javascript.jsx nmap <Leader>f :!$(npm bin)/eslint --fix % <CR>

" typescript
au FileType typescript nmap <Leader>f :!yarn fix <CR> <CR>

" markdown
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<C-m>'
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md setlocal textwidth=100

" swig
autocmd BufNewFile,BufReadPost *.swigcxx set filetype=swig

" yaml
" For github.com/miekg/yamlfmt
au FileType yaml command! Fmt call YamlFmt(120)
let yaml_fmt = "yamlfmt /dev/stdin"
au FileType yaml let &l:formatprg=yaml_fmt

" helm
au FileType helm command! Fmt call YamlFmt(120)
let yaml_fmt = "yamlfmt /dev/stdin"
au FileType helm let &l:formatprg=yaml_fmt

"}}}

" vim:foldmethod=marker foldlevel=1
