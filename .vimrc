call plug#begin()
Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'majutsushi/tagbar'
Plug 'fatih/vim-go'
"Plug 't-yuki/vim-go-coverlay'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
"Plug 'Lokaltog/vim-powerline'
Plug 'terryma/vim-expand-region'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'bling/vim-bufferline'
Plug 'vim-ruby/vim-ruby'
Plug 'gf3/peg.vim'
Plug 'vadv/vim-chef'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
"Plug 'facebook/vim-flow'
"Plug 'crahles/vim-gometalinter.vim'
Plug 'phleet/vim-arcanist'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-markdown'
Plug 'hashivim/vim-terraform'
Plug 'derekwyatt/vim-scala'
"Plug 'avakhov/vim-yaml'
"Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'suan/vim-instant-markdown'
Plug 'vim-scripts/SWIG-syntax'
"Plug 'blockloop/vim-swigjs'
Plug 'Shougo/vinarise.vim'
" fancy short-jump mappings
Plug 'tpope/vim-unimpaired'
Plug 'othree/javascript-libraries-syntax.vim'
"Plug 'ternjs/tern_for_vim'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

"Plug 'jbgutierrez/vim-babel'
Plug 'vim-scripts/groovy.vim'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'lambdatoast/elm.vim'
Plug 'tpope/vim-dispatch'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tikhomirov/vim-glsl'
call plug#end()


set swapfile
set undofile
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

set mouse=a
"set ttymouse=xterm2

set nocompatible
set smartindent
set autoindent
set tabstop=4
"set softtabstop=4
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4 softtabstop=0 noexpandtab shiftwidth=4

set autowrite

"let g:syntastic_javascript_checkers = ['eslint', 'flow']
let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_javascript_checkers = ['jsxhint']
"let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

filetype plugin indent on
"syntax on

"setlocal spell spelllang=en_us


"colorscheme tmc256
"colorscheme 256_noir
colorscheme jellybeans
set cursorline
set ruler
set modeline
set t_Co=256
let g:rehash256 = 1
let g:netrw_liststyle=3
set bg=dark

set encoding=utf-8
set laststatus=2
set relativenumber

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

let g:work_vimrc = $ADMIN_SCRIPTS . "/master.vimrc"
if filereadable(g:work_vimrc)
    silent! execute 'source ' . work_vimrc
endif

set backspace=indent,eol,start

let g:UltiSnipsExpandTrigger="<c-j>"

" also search buffers/tabs
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra'

" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

set scrolloff=5

set hlsearch

" airline
"set AirlineTheme powerlineish
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='powerlineish'
"let g:airline_left_sep=''
"let g:airline_right_sep=''
"let g:airline_section_z=''

"cpp support
let g:ycm_global_ycm_extra_conf = "~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"

" jsx support (React)
let g:jsx_ext_required = 0

" es6 support
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

" ruby support
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufNewFile,BufRead Berksfile set filetype=ruby

let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

" 80 col highlight
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

set runtimepath^=~/.vim/bundle/ctrlp.vim

" vim-go
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_auto_type_info = 1

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" speed up extra highlighting
"set re=1
set nocursorline
" color to col 128
set synmaxcol=128

"let g:go_metalinter_command = "gometalinter ./..."
"let g:go_metalinter_path = "./..."

"slient! execute 'source .vimrclocal'

nnoremap <leader>jd :YcmCompleter GoTo<CR>

" splits
set splitbelow
set splitright
nnoremap <leader>w <C-W>w
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" go
"au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dd <Plug>(go-def)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>s <Plug>(go-implements)

"au Filetype go nnoremap <leader>r :GoRun %<CR>

au Filetype go nnoremap <leader>t :GoTest <CR>
au Filetype go nnoremap <leader>b :GoBuild  <CR>
au Filetype go nnoremap <leader>e :GoErrCheck <CR>
au Filetype go nmap <leader>l :GoLint <CR>
"au FileType go nmap <Leader>L :GoMetaLinter <CR>

au FileType go nmap <leader>L <Plug>(go-metalinter)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
au FileType go nmap <Leader>C :GoGoverageBrowser <CR>

let g:go_metalinter_autosave = 1
"let g:go_metalinter_autosave_enabled = ['vet']

let g:go_auto_sameids = 1

au FileType javascript.jsx nmap <Leader>f :!$(npm bin)/eslint --fix % <CR>

" go tagbar support
"nmap <F8> :TagbarToggle<CR>
"autocmd FileType c,cpp,go nested :TagbarOpen
"autocmd BufEnter * nested :call tagbar#autoopen(0)
"autocmd VimEnter * nested :call tagbar#autoopen(1)
" force quickfix to non-tagbar 
"autocmd FileType qf wincmd J

" js
au FileType javascript.jsx nmap <Leader>dd :TernDef<CR>
au FileType javascript.jsx nmap <Leader>dt :TernDefTab<CR>


" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go','javascript.jsx'] }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=8

let g:syntastic_quiet_messages = { "type": "style" }



"markdown
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<C-m>'
"let g:vim_markdown_folding_disabled = 1
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

autocmd BufNewFile,BufReadPost *.swigcxx set filetype=swig

"#autocmd BufWritePost *.js !$(npm bin)/eslint --fix %

"let g:vinarise_enable_auto_detect=1

"set completeopt=longest,menuone
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


"set completeopt=longest,menuone,preview

" Neocomplete
 " Disable AutoComplPop.
 let g:acp_enableAtStartup = 0
 " Use neocomplete.
 let g:neocomplete#enable_at_startup = 1
 " Use smartcase.
 let g:neocomplete#enable_smart_case = 1
 " Set minimum syntax keyword length.
 let g:neocomplete#sources#syntax#min_keyword_length = 3


" neosnippet:
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>f :Find<CR>
nmap <Leader>r :Tags<CR>

set grepprg=rg\ --vimgrep

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
