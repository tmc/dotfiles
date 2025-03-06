" tmc's vimrc
" 
" don't panic.
" Also, don't blindly use cargo cult someone else's editor configuration!
" This is the standard version - balanced for daily use.

""{{{ bootstrap (automatically install vim-plug in new environments)
if empty(glob('~/.vim/autoload/plug.vim'))
  " Use vim-plug v0.14.0
  silent !curl -sfLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/d80f495fabff8446972b8695ba251ca636a047b0/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"}}}

" plugins {{{
call plug#begin()

" core plugins {{{
Plug 'junegunn/vim-plug'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
"}}}

" language support {{{
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
"}}}

" optional AI support {{{
if !exists('$NO_AI_FEATURES')
  Plug 'github/copilot.vim'
  Plug 'tmc/cgpt', { 'rtp': 'vim', 'do': 'go install ./cmd/cgpt' }
endif
"}}}

" tools {{{
Plug 'tmc/vimscripts', { 'rtp': 'git-backups', 'as': 'tmc-git-backups' }
Plug 'chrisjohnson/vim-grep'
Plug 'markonm/traces.vim'
Plug 'mbbill/undotree'
"Plug 'ludovicchabant/vim-gutentags'
"}}}

" flair {{{
Plug 'airblade/vim-gitgutter'
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"}}}

" experiments {{{
Plug 'google/vim-maktaba'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'whiteinge/diffconflicts'
Plug 'tpope/vim-bundler'
"}}}

call plug#end()
"}}}

" basics {{{
set nocompatible
set smartindent
set autoindent
set tabstop=4
set backspace=indent,eol,start
set encoding=utf-8
set relativenumber
set number
set path+=**
set wildmenu
set wildmode=longest:full,full
set wildignore+=**/node_modules/**,**/dist/**
set history=10000
set exrc
set laststatus=2
packadd! matchit

" completion
set omnifunc=syntaxcomplete#Complete
set completeopt=menuone
set completeopt+=noselect
set completeopt+=noinsert
set completeopt+=preview
set shortmess+=c
set belloff+=ctrlg

" undo/backup
set undofile
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp/
if has('nvim')
  set undodir=~/.vim/.nundo//
  set backupdir=~/.vim/.nbackup//
  set directory=~/.vim/.nswp//
endif
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
    call mkdir(expand(&backupdir), "p")
    call mkdir(expand(&directory), "p")
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
set foldcolumn=3
set foldlevel=2
set mouse=a

" searching
set hlsearch
set incsearch
"}}}

" language support {{{
" go {{{
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_doc_url='https://pkg.go.dev/'

" mappings
au FileType go nmap <Leader>t :GoTest<CR>
au FileType go nmap <Leader>b :GoBuild<CR>
au FileType go nmap <Leader>d :GoDef<CR>
au FileType go nmap <Leader>e <Plug>(go-rename)
au Filetype go nnoremap <leader>e :GoErrCheck <CR>
au Filetype go nmap <leader>l :GoLint <CR>
au FileType go nmap <Leader>dd <Plug>(go-doc)
au FileType go nmap <Leader>db <Plug>(go-doc-browser)
au FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
au FileType go nmap <Leader>C :GoCoverageBrowser <CR>
"}}}

" typescript {{{
let g:ale_linters = {
\  'typescript': ['eslint', 'tsserver'],
\  'typescriptreact': ['eslint', 'tsserver'],
\  'go': ['gopls'],
\  'python': ['pyright'],
\  'cpp': ['clang'],
\  'proto': ['buf-check-lint'],
\}
let g:ale_fixers = {
\  'typescript': ['eslint', 'prettier'],
\  'typescriptreact': ['eslint', 'prettier'],
\  'javascript': ['eslint', 'prettier'],
\  'javascript.jsx': ['eslint', 'prettier'],
\  'java': ['google_java_format'],
\  'python': ['black'],
\  'jsx': ['eslint', 'prettier'],
\}
" \   '*': ['cgpt'],
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_set_balloons = 1
let g:ale_hover_to_floating_preview = 1
let g:ale_history_enabled = 1
let g:ale_history_log_output = 1

" LSP mappings
au FileType typescript nmap <Leader>d :ALEGoToDefinition<CR>
au FileType typescript nmap <Leader>r :ALERename<CR>
au FileType typescript nmap <Leader>t :ALEHover<CR>
au FileType typescript nmap <Leader>f :!yarn fix <CR> <CR>
"}}}

" bash {{{
au FileType sh setlocal expandtab shiftwidth=2 softtabstop=2
let g:ale_sh_shellcheck_options = '-x'
"}}}

" jsx support {{{
let g:jsx_ext_required = 0
au FileType javascript.jsx nmap <Leader>f :!$(npm bin)/eslint --fix % <CR>
"}}}

" ruby support {{{
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
"}}}

" es6 support {{{
autocmd BufRead,BufNewFile *.es6 setfiletype javascript
"}}}

" markdown {{{
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<C-m>'
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md setlocal textwidth=100
"}}}

" swig {{{
autocmd BufNewFile,BufReadPost *.swigcxx set filetype=swig
"}}}

" yaml {{{
" For github.com/miekg/yamlfmt
au FileType yaml command! Fmt call YamlFmt(120)
let yaml_fmt = "yamlfmt /dev/stdin"
au FileType yaml let &l:formatprg=yaml_fmt
"}}}

" helm {{{
au FileType helm command! Fmt call YamlFmt(120)
let yaml_fmt = "yamlfmt /dev/stdin"
au FileType helm let &l:formatprg=yaml_fmt
"}}}
"}}}

" mappings {{{
" splits
set splitbelow
set splitright
nnoremap <leader>w <C-W>w
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" quickfix
map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" OS clipboard
vmap <Leader>y "+y
vmap <Leader>p "+p
nnoremap <Leader>y "+yy
nnoremap <Leader>p "+p
nnoremap <Leader>Y "*y
nnoremap <Leader>P "*p

" file opening
nmap gx yiW:!open <cWORD><CR> <C-r>" & <CR><CR>

" auto-complete with omnifunc
inoremap . .<C-x><C-o>

" LSP
nmap <Leader>gd :ALEGoToDefinition <CR>
"}}}

" tags {{{
set tags+=./.tags,.tags;
" let g:gutentags_ctags_tagfile = '.tags'
" let g:gutentags_cache_dir = '~/.vim/tags'
"}}}

" plugin configuration {{{
" ale
let g:go_gopls_options = ['-rpc.trace']
let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = '--fast'

" airline
let g:airline_theme='minimalist'
let g:airline_section_z=''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#ale#enabled = 1

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

" vim:foldmethod=marker foldlevel=1
