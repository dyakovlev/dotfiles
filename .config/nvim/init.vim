""" Common Settings and Options

syntax on

set mouse=a                        " allow mouse interaction
set list listchars=tab:→\ ,trail:· " show trailing whitespace
set number                         " number lines
set scrolloff=3                    " leave more room around cursor
set showmatch                      " show matching cursor
set ignorecase                     " Case insensitive matching
set smartcase                      " Case sensitive matching if caps in search string
set splitbelow                     " Horizontal split below current
set splitright                     " Vertical split to right of current
set nojoinspaces                   " Prevents inserting two spaces after punctuation on J
set termguicolors                  " use 24-bit colors
set noerrorbells                   " don't ding
set noswapfile                     " disable swap files
set history=1000                   " more command history
set lazyredraw                     " Don't redraw while executing macros (good performance config)
set magic                          " better regex when searching

set wildmenu
set wildmode=list:longest,full     " Use BASH style completion
set wildignorecase

" tabs
set tabstop=2                      " tabs are 2 characters wide
set shiftwidth=2                   " shift by 2 chars
set shiftround                     " align column shifts to shiftwidth
set softtabstop=2                  " same shiftwidth when inserting a mixture of tabs and spaces
set expandtab                      " convert tabs to spaces on insert

" slightly cleaner statusline
set statusline=%f                  " tail of the filename
set statusline+=%m                 " modified flag
set statusline+=%=                 " left/right separator
set statusline+=%c,                " cursor column
set statusline+=%l/%L              " cursor line/total lines

let g:mapleader=","                " use , to initiate chorded commands


""" Plugins

call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'chaoren/vim-wordmotion'
Plug 'sainnhe/gruvbox-material'
Plug 'junegunn/goyo.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

""" Plugin Configs

"" wordmotion

let g:wordmotion_spaces = '_-.'    " more kinds of word boundaries

"" gitgutter

" use lightweight dots to show changes
let g:gitgutter_sign_added = '⋮'
let g:gitgutter_sign_modified = '⋮'
let g:gitgutter_sign_removed = '⋮'
let g:gitgutter_sign_modified_removed = '⋮'

"" splitjoin
"nmap <leader>j :SplitjoinJoin<cr>
"nmap <leader>s :SplitjoinSplit<cr>

"" Goyo
let g:goyo_width = 120
map <leader>g :Goyo<CR>

"" COC

set hidden          " allows modified-unsaved buffers to go into the background
set updatetime=300
set shortmess+=c    " Don't pass messages to |ins-completion-menu|.
set nobackup        " Some servers have issues with backup files.
set nowritebackup

let g:coc_global_extensions = ['coc-eslint', 'coc-json', 'coc-tsserver', 'coc-solargraph']

" use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" move around completion menu via tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" confirm selection via <cr>
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" close window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gh :call CocActionAsync('doHover')<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gf <Plug>(coc-references)
nmap <silent> gx :CocCommand<CR>

"command! -nargs=0 Prettier :CocCommand prettier.formatFile

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


""" Theme Setup

colorscheme gruvbox-material
let g:gruvbox_material_background = 'medium'  " hard/medium/soft

" disable italic comments, term font does not render them well
highlight Comment cterm=none gui=none


""" Command overrides

" auto-reload vim config when it's saved
augroup VimConfig
  au!
  au BufWritePost ~/.config/nvim/init.vim source <afile>
augroup END

" filetype-specific overrides
autocmd FileType make set noexpandtab shiftwidth=8 " make requires real tabs
autocmd FileType json syntax match Comment +\/\/.\+$+ " deal with commented json better

" check for file changes periodically and on window & buffer switches
autocmd CursorHold * checktime
autocmd WinEnter * checktime
autocmd BufWinEnter * checktime

" copy to system clipboard with <leader>y
let s:actions = ['y', 'x', 'p', 'c']
let s:modes = ['n', 'v']
for action in s:actions
    let Action = toupper(action)
    for mode_target in s:modes
        exec printf('%snoremap <leader>%s "+%s', mode_target, action, action)
        exec printf('%snoremap <leader>%s "+%s', mode_target, Action, Action)
    endfor
endfor

" Suffixes that get lower priority when doing tab completion for filenames.
set suffixes=.pyc,.bak

" jump to last cursor position when opening a file
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ 'commit\c' && &filetype !~ 'svn\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
     exe "normal g`\""
    endif
  end
endfunction

" Remove trailing whitespace on save
autocmd BufWritePre *.txt,*.js,*.ts,*.tsx,*.py,*.rb :call CleanExtraSpaces()

" Open help in a right split
autocmd FileType help wincmd L

""" Behavior Tweaks

" tweak up and down to do the right things for wrapped lines
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$

" tweak j/k to work with wrapped lines in a more logical fashion
nnoremap <silent> k gk
nnoremap <silent> j gj

" center view around search result
map N Nzz
map n nzz

" move around splits with ctrl key
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

" open files from cur dir in various ways
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>v :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>s :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>t :tabnew <C-R>=expand("%:p:h") . "/" <CR>

" quick save hotkey
nmap <leader>w :w <CR>
nmap <leader>q :q <CR>

" Switch tabs easily
nmap <Tab> gt
nmap <S-Tab> gT

" visually select everything between matching braces
noremap % v%

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>


""" Functions

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
