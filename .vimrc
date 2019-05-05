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

" plugins {{{
call plug#begin()
Plug 'junegunn/vim-plug'
" core plugins {{{
" fundamentals {{{
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
Plug 'tpope/vim-dispatch'
"Plug 'tpope/vim-sensible'
"}}}
" tools {{{
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
" flair {{{
Plug 'airblade/vim-gitgutter'
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"}}}
"
" completion+snippets {{{
"Plug 'Shougo/neocomplete.vim'
"Plug 'lifepillar/vim-mucomplete'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
"}}}
"" experiments {{{
Plug 'dbeniamine/cheat.sh-vim'
Plug 'kana/vim-textobj-user'
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'somini/vim-textobj-fold'
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'
""Plug 'broesler/jupyter-vim'
""Plug 'tpope/vim-vinegar'
Plug 'whiteinge/diffconflicts'
Plug 'tmc/vimscripts', { 'rtp': 'git-backups', 'as': 'tmc-git-backups' }
"Plug 'tmc/vimscripts', { 'rtp': 'mucomplete-neosnippet', 'as': 'tmc-mucomplete-neosnippet' }
Plug 'w0rp/ale'
Plug 'vim-scripts/dbext.vim'
Plug 'hashivim/vim-terraform'
""}}}
""}}}
"
" language support {{{
"Plug 'Quramy/tsuquyomi'
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
set cryptmethod=blowfish2
filetype plugin indent on

silent! colorscheme jellybeans
set cursorline
set ruler
set modeline
set t_Co=256
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
set undodir=~/.vim/.undo/
set backupdir=~/.vim/.backup/
set directory=~/.vim/.swp/
if !isdirectory("~/.vim/.swp")
    silent !mkdir ~/.vim/.swp > /dev/null 2>&1
    silent !mkdir ~/.vim/.undo > /dev/null 2>&1
    silent !mkdir ~/.vim/.backup > /dev/null 2>&1
endif

set scrolloff=5

set hlsearch
set incsearch
"slient! execute 'source .vimrclocal'

packadd! matchit

" color to col 128
set synmaxcol=128
" 80 col highlight
highlight OverLength ctermbg=black ctermfg=white guibg=#592929
match OverLength /\%101v.\+/

set foldcolumn=3
set foldlevel=2

" }}}

" balloons {{{
set mouse=a
silent set ballooneval
silent set balloonevalterm
set ttymouse=sgr
"set balloonexpr=go#tool#DescribeBalloon()
set balloondelay=150

let g:ale_set_balloons=1
"}}}

" abbrevations {{{
"}}}

" tags conf {{{
set tags+=./.tags,.tags;
let g:gutentags_ctags_tagfile = '.tags'
"let g:gutentags_file_list_command = 'git ls-files'
"let g:gutentags_ctags_extra_args = [system("python -c \"import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))\"")]

"}}}

" mappings {{{
" quickfix
map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

inoremap . .<C-x><C-o>

" splits
set splitbelow
set splitright
nnoremap <leader>w <C-W>w
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


"
function! OpenJSONLink()
  normal! :vsgf
  set filetype=json
  set foldmethod=syntax
  set foldlevel=2
endfunction
nnoremap <Leader>gj :call OpenJSONLink()<CR>

function! ViewHtmlText(url)
  if !empty(a:url)
    new
    setlocal buftype=nofile bufhidden=hide noswapfile
    execute 'r !elinks ' . a:url . ' -dump -dump-width ' . winwidth(0)
    1d
  endif
endfunction
" Save and view text for current html file.
nnoremap <Leader>H :update<Bar>call ViewHtmlText(expand('%:p'))<CR>
" View text for visually selected url.
vnoremap <Leader>h y:call ViewHtmlText(@@)<CR>
" View text for URL from clipboard.
" On Linux, use @* for current selection or @+ for text in clipboard.
nnoremap <Leader>h :call ViewHtmlText(@+)<CR>

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

let g:netrw_http_xcmd='-s -n -o'
"}}}

" plugin configuration {{{
" ale
let g:ale_completion_enabled=1
"let g:ale_python_flake8_args="--ignore=E501"
"let g:ale_python_pyls_use_global=1
"let g:ale_linters = {'python': ['flake8', 'pyls']}
let g:ale_python_pyls_executable='pyls'
let g:ale_linters = {
\  'go': ['gofmt', 'golint', 'govet', 'gopls'],
\  'python': ['pyls'],
\  'typescript': ['tsserver', 'typecheck', 'tslint'],
\}
let g:ale_fixers = {
\  'typescript': ['tslint'],
\}
"\  'typescript': ['eslint','prettier','tslint', 'trim_whitespace'],
"\  'sh': ['shfmt'],
let g:ale_fix_on_save=1
let g:ale_history_enabled = 1
let g:ale_history_log_output = 1
"let g:ale_python_flake8_change_directory = 0
let g:airline#extensions#ale#enabled = 1

" airline
let g:airline_theme='minimalist'
let g:airline_section_z=''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
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

" mu
"nnoremap <leader>mu :MUcompleteAutoToggle<CR>
"let g:mucomplete#completion_delay = 800

"if executable('typescript-language-server')
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'typescript-language-server',
"        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
"        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
"        \ 'whitelist': ['typescript'],
"        \ })
"endif
"if executable('pyls')
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'pyls',
"        \ 'cmd': {server_info->['pyls']},
"        \ 'whitelist': ['python'],
"        \ 'workspace_config': {'pyls': {'plugins': {'jedi_definition': {'follow_imports': 'true'}}}}
"        \ })
"endif

" rg
let g:vimgrep_rg_command="rg --vimgrep --color=never --no-heading"
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" language server
"let g:lsc_server_commands = {'python': 'pyls'}
"let g:lsc_auto_map = v:true " Use defaults
"}}}

" language support {{{

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
"au FileType typescript nmap <Leader>gd :TsuDefinition <CR>
au FileType typescript nmap <Leader>gs :vsplit <CR> <Bar> :sleep 1 <Bar> :TsuDefinition <CR>
au FileType typescript nmap <Leader>f :!yarn fix <CR> <CR>

"nmap <Leader>gd :LspDefinition <CR>
nmap <Leader>gd :ALEGoToDefinition <CR>

" js
au FileType javascript.jsx nmap <Leader>dd :TernDef<CR>
au FileType javascript.jsx nmap <Leader>dt :TernDefTab<CR>

" markdown
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<C-m>'
"let g:vim_markdown_folding_disabled = 1
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md setlocal textwidth=100


" swig
autocmd BufNewFile,BufReadPost *.swigcxx set filetype=swig
"}}}
"}}}

" completion {{{
" filetype plugin on
set omnifunc=syntaxcomplete#Complete
set completeopt=menuone
set completeopt+=noselect
set completeopt+=noinsert
set completeopt+=preview
set shortmess+=c
set belloff+=ctrlg

"autocmd Filetype *
"        \	if &omnifunc == "" |
"        \		setlocal omnifunc=syntaxcomplete#Complete |
"        \	endif

"let g:mucomplete#enable_auto_at_startup = 1

" tsuquyomi
let g:tsuquyomi_completion_detail = 1
autocmd FileType typescript setlocal completeopt+=menu,preview
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

let g:mucomplete#user_mappings = { 'neosnippet': "\<c-r>=mucomplete_neosnippet#complete()\<cr>" }
let g:mucomplete#chains = { 'default': ['neosnippet', 'path', 'omni', 'keyn', 'dict', 'uspl'] }

"}}}

" vim:foldmethod=marker foldlevel=1
