set nocompatible                " Turn on vim defaults (instead of vi compatibility)
set encoding=utf-8

"-----------------------------------------------------------------------------
" Set up .vim-local
"-----------------------------------------------------------------------------
let s:vimlocaldir          = $HOME . "/.vim-local"
let s:vimlocaldir_swp      = s:vimlocaldir . "/swp"
if finddir(s:vimlocaldir) == ""
    call mkdir(s:vimlocaldir,          "", 0700)
    call mkdir(s:vimlocaldir_swp,      "", 0700)
endif


"-----------------------------------------------------------------------------
" Includes and Plugins
"-----------------------------------------------------------------------------
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'elixir-editors/vim-elixir'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/LargeFile'
Plug 'vlime/vlime'
call plug#end()

let html_no_rendering=1         " [syntax/html.vim] Don't make html fancy, like underlining links
set t_Co=256                    " Instruct vim to use 256-color mode
let c_C99=1                     " [alternative-syntaxes] For std_c syntax to recognize C99
let g:LargeFile=20              " [LargeFile.vim] Files larger than 20 MB will not have syntax enabled
let g:EnhCommentifyUserBindings = 'yes'              " [EnhCommentify.vim] Use my own keybindings for comments
let g:EnhCommentifyPretty       = 'Yes'              " [EnhCommentify.vim] Add extra space to the comment chars
let g:paredit_mode = 0          " Paredit is annoying

filetype plugin indent on       " Detect file type, and load plugins and indents for the filetype
runtime macros/matchit.vim      " % can match more things
runtime ftplugin/man.vim        " Provides colorful Man command in vim

" Using vlime
" sbcl --load ~/.vim/plugged/vlime/lisp/start-vlime.lisp
" ros run --load ~/.vim/plugged/vlime/lisp/start-vlime.lisp
let g:vlime_cl_impl = "ros"
function! VlimeBuildServerCommandFor_ros(vlime_loader, vlime_eval)
    return ["ros", "run",
                \ "--load", a:vlime_loader,
                \ "--eval", a:vlime_eval]
endfunction

" Todo
let g:todo_root = '~'
let g:todo_open_command = 'elinks'

" ctrlp
let g:ctrlp_open_multiple_files = 't'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard && git submodule foreach --recursive --quiet "git ls-files -oc --exclude-standard | sed \"s/^/\$path\//\""']


"-----------------------------------------------------------------------------
" Global Options
"-----------------------------------------------------------------------------
set autoindent                   " Copy indent from current line when starting new line, or follow smartindent or cindent
set autoread                     " When a file was changed outside of vim and not inside, autoread it again
set background=dark              " Indicate for syntax on that we have a dark background
set backspace=indent,eol,start   " We can backspace over autoindent, line breaks (to join lines), and start of insert
set clipboard=unnamed            " Use the system clipboard instead of multiple clipboards
set complete=.,w,b               " C-n/C-p scans current buf, other window bufs, and other loaded buffers
set cursorline                   " Highlight the current line the cursor is on
set directory=$HOME/.vim-local/swp  " Swap files will all be at the home directory
set expandtab                    " Tab keys is spaces instead of tab (C-V Tab will tab)
set formatoptions=clnqr2         " Automatic format options (about all of them except auto-format)
set hidden                       " Can hide buffers when abandoning them (don't need to save to switch)
set laststatus=2                 " Always show a status line
set list                         " Shows special characters, like tabs, end of lines, spaces, and so forth
set listchars=tab:__,trail:.     " Tabs look like ____, and trailing spaces look like .
set matchpairs=(:),{:},[:]       " Show highlight match for these symbols
set nobackup                     " Don't make backups of files
set nohlsearch                   " Highlights search matches
set nowrap                       " Turn off visual line wrap
set nowritebackup                " Turn off making a backup before overwriting a file
set number
set pastetoggle=<F11>            " F11 toggles Paste vs Nopaste for Insert mode
set ruler                        " Show the line and column number of the cursor position
set shiftwidth=4                 " Indention spaces
set shortmess+=c                 " Don't give ins-completion-menu messages
set showcmd                      " Show partial commands at the last line of the screen
set showmode                     " Show mode in the last line (--INSERT--, etc)
set sidescroll=0                 " At the end of a line, shift screen so cursor is at the middle
set signcolumn=yes               " Always show signcolumns
set nosmartindent                " No smart indention; it isn't actually smart
set smarttab                     " Use shiftwidth to guide tab indention
set nospell                      " By default, don't spellcheck
set spelllang=en_us              " Spell language is US English
set splitbelow                   " If you split the window, the new window will be below the current
set suffixes=.bak,.obj,.swp,.o   " These get low priority when matching wildcards (see wildchar)
set tabstop=4                    " Tab spaces
set textwidth=78                 " Maximum width of text being inserted
set updatetime=300               " You will have bad experience for diagnostic messages when it's default 4000
set visualbell                   " Flash instead of beeping
set wildchar=^I                  " Tab starts wildchar expansion in the command-line
set wildmenu                     " When wildchar is activate, you can cycle through a menu of matches
set wildmode=list:longest        " When more than one match, list all matches and complete till longest common string
syntax on
colorscheme shadow


" viminfo settings
" '32  => remember marks for 32 previous files
" f1   => remember marks '0 to '9 and 'A to 'Z; '0 is current cursor position
" <10  => Max number of lines saved for each register (10)
" s10  => Max size of a register in kB (10 kB)
" n... => Name of the viminfo file
set viminfo='32,f1,<10,s10,n$HOME/.vim-local/viminfo

" Status Line settings
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

"don't autoselect first item in omnicomplete, show if only one item (for preview)
"remove preview if you don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview

" Autoread
" Trigger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


" ----------------------------------------------------------------------
" vim-gitgutter
" ----------------------------------------------------------------------
let g:gitgutter_diff_args = '-w'   " Don't diff the whitespace

" ----------------------------------------------------------------------
" vim-go
" ----------------------------------------------------------------------
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1


"-----------------------------------------------------------------------------
" Global Keymappings
"-----------------------------------------------------------------------------
" Commenting with commentary
nmap <silent> <C-c> gcc
vmap <silent> <C-c> gc

" Mapping typical keys
map <PageUp> 
map <PageDown> 
map <Home> 0
map <End> $
map <C-Home> 1G
map <C-End> G$

" Searching what is highlighted
vmap \/ y/<C-R>"

" Like emacs occur; occur on what you last searched for
nmap g/ :set hlsearch<CR>:vimgrep /<C-R>//j %<CR>\|:cw<CR>

" Command line
cnoremap <C-A>     <Home>
cnoremap <C-E>     <End>
cnoremap <Esc>b    <S-Left>
cnoremap <Esc>f    <S-Right>
cnoremap <Esc><Backspace>    <C-W>
cnoremap ∫    <S-Left>
cnoremap ƒ    <S-Right>
cnoremap <A-Backspace>    <C-W>

" Easier formatting
function FormatOrIndent()
    normal ml
    let l:attrName = synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")
    if l:attrName == "Comment"
        call SyntaxVisualSelect('b')
        normal gq
    elseif l:attrName == "" || &ft == "" || &ft == "gitcommit"
        normal gqip
    elseif &ft == "lisp"
        normal =ap
    elseif &ft == "perl" && executable("perltidy")
        normal VaB:!perltidy -q
    else
        normal ml=aB
    endif
    normal `l
endfunction
inoremap <silent> <Esc>q <Esc>:call FormatOrIndent()<CR>a
nnoremap <silent> <Esc>q :call FormatOrIndent()<CR>
vnoremap <silent> <Esc>q :call FormatOrIndent()<CR>
inoremap <silent> œ <Esc>:call FormatOrIndent()<CR>a
nnoremap <silent> œ :call FormatOrIndent()<CR>
vnoremap <silent> œ :call FormatOrIndent()<CR>

" Horizontal space deletion
function DeleteHorizontalSpace()
    call searchpos(' *', 'bc')
    if getline(".")[col(".") - 1] =~ "\\s"
        normal dw
    endif
endfunction
inoremap <silent> <C-\><C-\> <C-O>:call DeleteHorizontalSpace()<CR>
nnoremap <silent> <C-\><C-\> :call DeleteHorizontalSpace()<CR>

" Tab navigation
function! CustomPreviousTab()
    if tabpagenr('$') == 1
        bp
    else
        tabprevious
    endif
endfunction
function! CustomNextTab()
    if tabpagenr('$') == 1
        bn
    else
        tabnext
    endif
endfunction
function! CustomNewTab()
    if tabpagenr('$') == 1
        new
    else
        tabnew
    endif
endfunction

nmap <silent> <Esc>k :call CustomPreviousTab()<cr>
nmap <silent> <Esc>j :call CustomNextTab()<cr>
nmap <silent> <Esc>c :if len(getwininfo()) == 1<cr>bd!<cr>else<cr>q!<cr>endif<cr>
nmap <silent> <Esc>n :call CustomNewTab()<cr>
nmap <Esc>t :tabnew<space><C-R>=expand("%:p")<cr> <Backspace>
nmap <silent> ˚ :call CustomPreviousTab()<cr>
nmap <silent> ∆ :call CustomNextTab()<cr>
nmap <silent> � :bd<cr>
nmap † :tabnew<space><C-R>=expand("%:p")<cr> <Backspace>
nmap Q :echo "I just saved you from Q"<cr>
noremap gV `[v`]


" Custom alignment with \a
command! -nargs=? -range Align <line1>,<line2>call AlignSection('<args>')
vnoremap <Leader>a :Align 
function! AlignSection(regex) range
  let extra = 1
  let sep = empty(a:regex) ? '=' : a:regex
  let maxpos = 0
  let section = getline(a:firstline, a:lastline)
  for line in section
    let pos = match(line, ' *'.sep)
    if maxpos < pos
      let maxpos = pos
    endif
  endfor
  call map(section, 'AlignLine(v:val, sep, maxpos, extra)')
  call setline(a:firstline, section)
endfunction
function! AlignLine(line, sep, maxpos, extra)
  let m = matchlist(a:line, '\(.\{-}\) \{-}\('.a:sep.'.*\)')
  if empty(m)
    return a:line
  endif
  let spaces = repeat(' ', a:maxpos - strlen(m[1]) + a:extra)
  return m[1] . spaces . m[2]
endfunction


"-----------------------------------------------------------------------------
" Autocommands
"-----------------------------------------------------------------------------

" If the buffer is in viminfo, go to the last recorded cursor position
function! RestoreCursor()
    try
        if bufname(".") !~ "COMMIT_EDITMSG"
            normal `"zz
        endif
    catch
        return 1
    endtry
endfunction
autocmd BufNewFile,BufReadPost,BufNew * call RestoreCursor()

" Turn off folding in every new buffer
autocmd BufNewFile,BufReadPost,BufNew * normal zn

" Configure mail buffers (especially for mutt usage)
function! ConfigureMail()
  set ft=mail
  set shiftwidth=2
  set tabstop=2
  set textwidth=70
  set spell spelllang=en_us
endfunction
autocmd BufNewFile,BufRead */mutt-* call ConfigureMail()

autocmd BufNewFile,BufRead *.js set shiftwidth=2
autocmd BufNewFile,BufRead *.hbs set shiftwidth=2
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab


" .asd files are also Lisp files
autocmd BufNewFile,BufRead *.asd set ft=lisp

" Vagrantfile and pp puppet files are ruby files
autocmd BufNewFile,BufRead Vagrantfile set ft=ruby
autocmd BufNewFile,BufRead *.pp set ft=ruby

" .t files are also perl files
autocmd BufNewFile,BufRead *.t set ft=perl

" Programming language files tend to be small, so we'll do full syntax
autocmd BufNewFile,BufRead,BufWinEnter *.asd,*.t,*.pl,*.pm,*.lisp,*.clj,*vimrc,*.vim,*.py,*.c,*.js,*.html,*.htm syntax sync fromstart

" Go files require a specific standard
function! ConfigureGo()
  set noexpandtab
  set nolist
endfunction
autocmd BufNewFile,BufRead,BufWinEnter *.go call ConfigureGo()

"-----------------------------------------------------------------------------
" Now that everything is in place, read local differences
"-----------------------------------------------------------------------------
if filereadable(s:vimlocaldir . "/vimrc")
    source $HOME/.vim-local/vimrc
endif

