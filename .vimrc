set nocompatible			" Ditch strict vi compatibility

" install plugins
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'chaoren/vim-wordmotion'
Plug 'sheerun/vim-polyglot'

Plug 'sainnhe/gruvbox-material'

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

call plug#end()

" Clear existing autocommands
autocmd!
set backspace=indent,eol,start    " More powerful backspacing

set ai                      " always set autoindenting on
set autowrite               " Autosave before commands like :next and :make
set textwidth=0             " Don't wrap words by default
set showcmd                 " Show (partial) command in status line.
set encoding=utf-8          " This being the 21st century, I use Unicode
set fileencoding=utf-8

set showmatch               " Show matching brackets.
set ignorecase              " Case insensitive matching
set smartcase               " Case sensitive matching if caps in search string
set hlsearch                " Highlight search matches

set wildmenu                " Use BASH style completion
set wildmode=list:longest,full

set scrolloff=3             " leave more context around cursor
set number                  " Line numbering

set complete=.,w,b,u,t,],s{*.pm}
set nobackup                " Don't keep a backup file
set history=5000            " Keep 5000 lines of command line history
set viminfo='20,\"50        " Read/write a .viminfo file, don't store more than
                            " 50 lines of registers
" Visual stuff
set showcmd                 " Show information about ranges in the ruler
set laststatus=2
"set ruler                   " Show the cursor position all the time
set title                   " Show title in title bar
"set cursorline              " Highlight the current line

" highlight some badness
set list listchars=tab:→\ ,trail:·

" figure out tab spacing depending on some things
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" highlight tabs
syntax match Tab /\t/
hi Tab ctermbg=blue

" use 2-space tabs in some places
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab tabstop=2 softtabstop=2
au BufNewFile,BufReadPost *.rb setl shiftwidth=2 expandtab tabstop=2 softtabstop=2
au BufNewFile,BufReadPost *.erb setl shiftwidth=2 expandtab tabstop=2 softtabstop=2
au BufNewFile,BufReadPost *.arb setl shiftwidth=2 expandtab tabstop=2 softtabstop=2
au BufNewFile,BufReadPost *.js setl shiftwidth=2 expandtab tabstop=2 softtabstop=2
au BufNewFile,BufReadPost *.py setl shiftwidth=4 expandtab tabstop=4 softtabstop=4

set nohidden				" do not keep buffer after tab closed

" keep backups and temp files in ~.vim/, not next to the actual files
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

set mouse=a					" Mouse support (needs MouseEvents and SIMBL hax to work in Terminal.app)
set ttymouse=sgr            " fix mouse support to work past 220th column (http://stackoverflow.com/questions/7000960/in-vim-why-doesnt-my-mouse-work-past-the-220th-column)

set shiftround              " make >> and << shift to nearest indentation-level column

" set default split opening position to be below and to the right of currently active split
set splitbelow
set splitright

set statusline=%f           " tail of the filename
set statusline+=%m          " modified flag
set statusline+=%=			" left/right separator
set statusline+=%c,			" cursor column
set statusline+=%l/%L		" cursor line/total lines

set nofoldenable			" everything unfolded by default

" set up zenburn
"set t_Co=256
"let g:zenburn_high_Contrast=1
"let g:zenburn_force_dark_Background=1
"colors zenburn

" set up gruvbox
set termguicolors
set background=dark
" available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'medium'

colorscheme gruvbox-material

" tweak the numberline to look ok in zenburn
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE

" highlight trailing whitespace and non-tab indents
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
match ExtraWhitespace /^\t*\zs \+/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

highlight Pmenu term=bold ctermfg=Cyan

syntax on                    " syntax highlighting on

" highlight jsx in .js files
let g:jsx_ext_required = 0

" set up prettier to run on save
let g:prettier#exec_cmd_async = 1
let g:prettier#quickfix_enabled = 0
let g:prettier#config#print_width = 100
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'always'
let g:prettier#config#trailing_comma = 'all'
let g:prettier#config#config_precedence = 'file-override'
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" Extra filetypes
"au BufNewFile,BufRead *.tmpl set filetype=html
"au BufNewFile,BufRead *.js.tmpl set filetype=javascript
"au BufNewFile,BufRead *.css.tmpl set filetype=css

autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" Keep comments indented
inoremap # #

" make requires real tabs
autocmd FileType make set noexpandtab shiftwidth=8

" Check for file changes periodically and on window & buffer switches
autocmd CursorHold * checktime
autocmd WinEnter * checktime
autocmd BufWinEnter * checktime

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.py,.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
"http://structurallysoundtreehouse.com/my-almost-perfect-vim-files
"http://github.com/fredlee/mydotfiles/tree/master
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ 'commit\c' && &filetype !~ 'svn\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
     exe "normal g`\""
    endif
  end
endfunction

" automatically figure out if we want Tab or complete
function! Mosh_Tab_Or_Complete()
    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-N>"
    else
        return "\<Tab>"
endfunction
inoremap <Tab> <C-R>=Mosh_Tab_Or_Complete()<CR>

" Omni Completion
autocmd FileType html :set omnifunc=htmlcomplete#CompleteTags
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" gitgutter - dots
let g:gitgutter_sign_added = '⋮'
let g:gitgutter_sign_modified = '⋮'
let g:gitgutter_sign_removed = '⋮'
let g:gitgutter_sign_modified_removed = '⋮'

" tags file - this looks in current directory, then recurses up until it finds
" a file named 'tags'.
set tags=./tags;/

" Suppress the no-ruby warning from Lusty Explorer
let g:LustyJugglerSuppressRubyWarning = 1

let mapleader = ","

" -------------
" various key combinations and tweaks
" -------------
" tweak up and down to do the right things for wrapped lines
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Toggle search highlighting
map <silent> <F1> :set invhlsearch<CR>

" Toggle line numbers
nmap <silent> <F5> :set invnumber<CR>
map <silent> <F5> :set invnumber<CR>

" backtick goes to the exact mark location, single-quote just the line; swap 'em
nnoremap ' `
nnoremap ` '

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$

" tweak j/k to work with wrapped lines in a more logical fashion
nnoremap <silent> k gk
nnoremap <silent> j gj

" rotate vertical/horizontal splits
nnoremap <leader>x ^Wt^WH
nnoremap <leader>z ^Wt^WK

" center view around search result
map N Nzz
map n nzz

" Move around splits with ctrl key!
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

" ctags descend/return
nmap <F4> :pop<CR>

" open ctags in various ways
"nmap .e 
"nmap .v :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"nmap .s :sp <CR>:exec("tag ".expand("<cword>"))<CR>
"nmap .t :tabnew <CR>:exec("tag ".expand("<cword>"))<CR>

" open files from cur dir in various ways
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>v :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>s :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>t :tabnew <C-R>=expand("%:p:h") . "/" <CR>

" toggle git blame display
nmap <leader>b :GitBlame <CR>

" quick save hotkey
nmap <leader>w :w <CR>
nmap <leader>q :q <CR>

" horizontal split accordionator
map zk <C-W>k<C-W>_<CR>
map zj <C-W>j<C-W>_<CR>

" Switch tabs easily
nmap <Tab> gt

" visually select everything between matching braces
noremap % v%

