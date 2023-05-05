"-----------------------------------------------------------------------------
" Front matter
"-----------------------------------------------------------------------------
set nocompatible                " Turn on vim defaults (instead of vi compatibility)
set encoding=utf-8              " Use UTF-8 encoding for displaying properly
let mapleader=' '               " Leader key is Space instead of \


"-----------------------------------------------------------------------------
" Set up .vim-local
"-----------------------------------------------------------------------------
let s:vimlocaldir          = $HOME . "/.vim-local"
let s:vimlocaldir_swp      = s:vimlocaldir . "/swp"
if finddir(s:vimlocaldir) ==# ""
    call mkdir(s:vimlocaldir,          "", 0700)
    call mkdir(s:vimlocaldir_swp,      "", 0700)
endif


"-----------------------------------------------------------------------------
" Includes and Plugins
"-----------------------------------------------------------------------------
call plug#begin()
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/vimfiler.vim'
if executable("node")
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif
Plug 'airblade/vim-gitgutter'
if executable("fzf")
    Plug 'alok/notational-fzf-vim'
endif
Plug 'alvan/vim-closetag'
Plug 'aquach/vim-http-client'
if executable("direnv")
    Plug 'direnv/direnv.vim'
endif
Plug 'hashivim/vim-terraform'
Plug 'iamcco/markdown-preview.nvim', {'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'liuchengxu/vim-which-key'
Plug 'LnL7/vim-nix'
Plug 'mbbill/undotree'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tyru/open-browser.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-crystal/vim-crystal'
Plug 'vim-scripts/LargeFile'
Plug 'vim-scripts/utl.vim'
Plug 'zigford/vim-powershell'

" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'

" Rust
Plug 'rust-lang/rust.vim'

" JS/JSX/Typescript/GQL
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax

call plug#end()

let html_no_rendering=1         " [syntax/html.vim] Don't make html fancy, like underlining links
set t_Co=256                    " Instruct vim to use 256-color mode
let c_C99=1                     " [alternative-syntaxes] For std_c syntax to recognize C99
let g:LargeFile=20              " [LargeFile.vim] Files larger than 20 MB will not have syntax enabled
let g:paredit_mode = 0          " Paredit is annoying

filetype plugin indent on       " Detect file type, and load plugins and indents for the filetype
runtime macros/matchit.vim      " % can match more things
runtime ftplugin/man.vim        " Provides colorful Man command in vim

" Todo
let g:todo_root = '~'
let g:todo_open_command = 'elinks'

" Closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.ex,*.eex,*.leex'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml,xml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = ' >'

" FZF
nnoremap <C-p> :FZF<CR>

" Tabular
vnoremap <Leader>a :Tabular /=

" Undotree
nnoremap <leader>u :UndotreeToggle<cr>


"-----------------------------------------------------------------------------
" Global Options
"-----------------------------------------------------------------------------
set autoindent                   " Copy indent from current line when starting new line, or follow smartindent or cindent
set autoread                     " When a file was changed outside of vim and not inside, autoread it again
set background=dark              " Indicate for syntax on that we have a dark background
set backspace=indent,eol,start   " We can backspace over autoindent, line breaks (to join lines), and start of insert
set clipboard=unnamed,unnamedplus " Use the system clipboard instead of multiple clipboards
set complete=.,w,b               " C-n/C-p scans current buf, other window bufs, and other loaded buffers
set cursorline                   " Highlight the current line the cursor is on
set directory=$HOME/.vim-local/swp  " Swap files will all be at the home directory
set expandtab                    " Tab keys is spaces instead of tab (C-V Tab will tab)
set foldlevelstart=99            " Do not fold all the things by default
set formatoptions=clnqr2         " Automatic format options (about all of them except auto-format)
set grepprg=rg\ --vimgrep        " Use ripgrep/rg for grepping instead of grep
set hidden                       " Can hide buffers when abandoning them (don't need to save to switch)
set incsearch                    " Incremental search (go there while I am typing)
set laststatus=2                 " Always show a status line
set list                         " Shows special characters, like tabs, end of lines, spaces, and so forth
set listchars=tab:__,trail:.     " Tabs look like ____, and trailing spaces look like .
set matchpairs=(:),{:},[:]       " Show highlight match for these symbols
set nobackup                     " Don't make backups of files
set nohlsearch                   " Highlights search matches
set nostartofline                " When switching buffers, do not move the cursor to the start of the line
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
if has('nvim')
    set viminfo='32,f1,<10,s10,n$HOME/.vim-local/nviminfo
else
    set viminfo='32,f1,<10,s10,n$HOME/.vim-local/viminfo
endif

" Status Line settings
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''


"don't autoselect first item in omnicomplete, show if only one item (for preview)
"remove preview if you don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview

" Autoread
augroup autoread_autos
    autocmd!

    " Trigger `autoread` when files changes on disk
    " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
    " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
    " Notification after file change
    " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
    autocmd FileChangedShellPost *
      \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END


"-----------------------------------------------------------------------------
" coc
"-----------------------------------------------------------------------------
" Took a lot of advice from https://pragmaticpineapple.com/ultimate-vim-typescript-setup/

let g:airline#extensions#coc#enabled = 1
let g:coc_global_extensions = ['coc-json', 'coc-python', 'coc-go', 'coc-rust-analyzer', 'coc-tsserver', 'coc-elixir']
inoremap <silent><expr> <C-@> coc#refresh()

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


"-----------------------------------------------------------------------------
" Python
"-----------------------------------------------------------------------------
function ConfigurePython()
    nnoremap <buffer> <silent> <leader>ee :CocCommand python.execInTerminal<cr>
    vnoremap <buffer> <silent> <leader>ee :<C-u>CocCommand python.execSelectionInTerminal<cr>
endfunction

augroup python_autos
    autocmd!
    autocmd FileType python call ConfigurePython()
augroup END


"-----------------------------------------------------------------------------
" vimrc
"-----------------------------------------------------------------------------
function VimrcFoldText()
    return '+ ' . substitute(getline(v:foldstart+1), '^" ', '', '') . ' (' . (v:foldend - v:foldstart + 1) . 'L)'
endfunction

function ConfigureVimrc()
    setlocal foldmethod=expr
    setlocal foldexpr=getline(v:lnum)=~'^\"----------'&&getline(v:lnum+1)=~'^\"\ .'&&getline(v:lnum+2)=~'^\"----------'?'>1':1
    setlocal foldtext=VimrcFoldText()

    nnoremap <buffer> <Tab> za
    nnoremap <buffer> <S-Tab> zM
endfunction

augroup filetype_vim
    autocmd!
    autocmd BufNewFile,BufRead vimrc call ConfigureVimrc()
augroup END


"-----------------------------------------------------------------------------
" vimfiler
"-----------------------------------------------------------------------------
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_tree_leaf_icon = ""
let g:vimfiler_tree_opened_icon = "◿"
let g:vimfiler_tree_closed_icon = "▶"
let g:vimfiler_readonly_file_icon = "×"
let g:vimfiler_tree_indentation = 2

call vimfiler#custom#profile('default', 'context', {
      \ 'safe' : 0,
      \ })

function! s:toggle_tree(is_recursive) abort "{{{
  let file = vimfiler#get_file(b:vimfiler)
  if empty(file) || vimfiler#get_filename() == '..'
    if vimfiler#get_filename() == '..'
      call vimfiler#mappings#cd('..')
    endif
    return
  endif

  if !file.vimfiler__is_directory
    " Search parent directory.
    for cnt in reverse(range(1, line('.')-1))
      let nest_level = get(vimfiler#get_file(b:vimfiler, cnt),
            \ 'vimfiler__nest_level', -1)
      if (a:is_recursive && nest_level == 0) ||
            \ (!a:is_recursive &&
            \  nest_level >= 0 && nest_level < file.vimfiler__nest_level)
        call cursor(cnt, 0)
        call s:toggle_tree(a:is_recursive)
        break
      endif
    endfor
    return
  endif

  if file.vimfiler__is_opened
    call s:unexpand_tree()
  else
    call s:expand_tree(a:is_recursive)
  endif
endfunction"}}}
function! s:expand_tree(is_recursive) abort "{{{
  let cursor_file = vimfiler#get_file(b:vimfiler)
  if empty(cursor_file) || vimfiler#get_filename() == '..'
    if vimfiler#get_filename() == '..'
      call vimfiler#mappings#cd('..')
    endif
    return
  endif

  if !cursor_file.vimfiler__is_directory
    " Search parent directory.
    for cnt in reverse(range(1, line('.')-1))
      let nest_level = get(vimfiler#get_file(b:vimfiler, cnt),
            \ 'vimfiler__nest_level', -1)
      if (a:is_recursive && nest_level == 0) ||
            \ (!a:is_recursive &&
            \  nest_level >= 0 &&
            \ nest_level < cursor_file.vimfiler__nest_level)
        call cursor(cnt, 0)
        call s:expand_tree(a:is_recursive)
        break
      endif
    endfor
    return
  endif

  if cursor_file.vimfiler__is_opened
    if a:is_recursive
      call s:unexpand_tree()
    endif
    return
  endif

  let cursor_file.vimfiler__is_opened = 1

  " Expand tree.
  let nestlevel = cursor_file.vimfiler__nest_level + 1

  if a:is_recursive
    let original_files = vimfiler#mappings#expand_tree_rec(cursor_file)
    let files =
          \ unite#filters#matcher_vimfiler_mask#define().filter(
          \ copy(original_files),
          \ { 'input' : b:vimfiler.current_mask })
  else
    let original_files =
          \ vimfiler#get_directory_files(cursor_file.action__path)
    for file in original_files
      " Initialize.
      let file.vimfiler__nest_level = nestlevel
    endfor

    let files =
          \ unite#filters#matcher_vimfiler_mask#define().filter(
          \ copy(original_files),
          \ { 'input' : b:vimfiler.current_mask })
  endif

  if !a:is_recursive && !b:vimfiler.is_visible_ignore_files
    let files = vimfiler#helper#_call_filters(
          \ files, b:vimfiler.context)
  endif

  let index = vimfiler#get_file_index(b:vimfiler, line('.'))
  let index_orig =
        \ vimfiler#get_original_file_index(line('.'))

  call extend(b:vimfiler.all_files, files, index+1)
  call extend(b:vimfiler.current_files, files, index+1)
  call extend(b:vimfiler.original_files, original_files, index_orig+1)
  let b:vimfiler.all_files_len += len(files)

  if b:vimfiler.context.auto_expand
        \ && !a:is_recursive && len(files) == 1
        \ && files[0].vimfiler__is_directory
    " Expand recursive.
    " call cursor(line('.') + 1, 0)
    call s:expand_tree(a:is_recursive)
  elseif g:vimfiler_expand_jump_to_first_child && !a:is_recursive
        \ || b:vimfiler.context.auto_expand
    " Move to next line.
    " call cursor(line('.') + 1, 0)
  endif

  call vimfiler#view#_redraw_screen()
endfunction"}}}
function! s:unexpand_tree() abort "{{{
  let cursor_file = vimfiler#get_file(b:vimfiler)
  if empty(cursor_file) || vimfiler#get_filename() == '..'
    return
  endif

  if !cursor_file.vimfiler__is_directory ||
        \ (!has_key(cursor_file, 'vimfiler__parent')
        \ && !cursor_file.vimfiler__is_opened)
    " Search parent directory.
    for cnt in reverse(range(1, line('.')-1))
      let nest_level = get(vimfiler#get_file(b:vimfiler, cnt),
            \ 'vimfiler__nest_level', -1)
      if nest_level >= 0 && nest_level < cursor_file.vimfiler__nest_level
        call cursor(cnt, 0)
        call s:unexpand_tree()
        break
      endif
    endfor

    return
  endif

  if !cursor_file.vimfiler__is_opened &&
        \ has_key(cursor_file, 'vimfiler__parent')
    let parent_file = cursor_file.vimfiler__parent
    let parent_file.vimfiler__is_opened = 0

    call remove(cursor_file, 'vimfiler__parent')
    for key in keys(parent_file)
      let cursor_file[key] = parent_file[key]
    endfor
  endif

  let cursor_file.vimfiler__is_opened = 0
  try
    setlocal modifiable
    setlocal noreadonly
    call setline('.', vimfiler#view#_get_print_lines([cursor_file]))
  finally
    setlocal nomodifiable
    setlocal readonly
  endtry

  " Unexpand tree.
  let nestlevel = cursor_file.vimfiler__nest_level

  " Search children.
  let index = vimfiler#get_file_index(b:vimfiler, line('.'))
  let end = index
  for cursor_file in b:vimfiler.current_files[index+1 :]
    if cursor_file.vimfiler__nest_level <= nestlevel
      break
    endif

    let end += 1
  endfor

  if end - index > 0
    let index_orig = vimfiler#get_original_file_index(line('.'))
    let end_orig = index_orig
    for file in b:vimfiler.original_files[index_orig+1 :]
      if file.vimfiler__nest_level <= nestlevel
        break
      endif

      let end_orig += 1
    endfor

    " Delete children.
    let b:vimfiler.all_files = b:vimfiler.all_files[: index]
          \ + b:vimfiler.all_files[end+1 :]
    let b:vimfiler.all_files_len += len(b:vimfiler.all_files)
    let b:vimfiler.current_files = b:vimfiler.current_files[: index]
          \ + b:vimfiler.current_files[end+1 :]
    let b:vimfiler.original_files = b:vimfiler.original_files[: index_orig]
          \ + b:vimfiler.original_files[end_orig+1 :]
    let pos = getpos('.')
    call vimfiler#view#_redraw_screen()
    call setpos('.', pos)
  endif
endfunction"}}}

function ConfigureVimfiler()
    highlight link vimfilerNonMark Identifier

    " Swap these two keybindings in vimfiler to something more intuitive
    nmap <buffer> <nowait> o <Plug>(vimfiler_cd_or_edit)
    nmap <buffer> <nowait> <Enter> <Plug>(vimfiler_expand_or_edit)

    " I would rather Tab does marking than space
    nmap <buffer> <nowait> <Tab> <Plug>(vimfiler_toggle_mark_current_line)
    vunmap <buffer> <Space>
    nunmap <buffer> <Space>

    " Basic movement I don't want vimfiler to take over
    nunmap <buffer> H
    nunmap <buffer> L
    nunmap <buffer> M
    nunmap <buffer> G

    " I do not like the cursor movement after expansion, and I can only
    " disable that by copying and modifying the toggle_tree and expand_tree
    " functions.
    nnoremap <buffer><silent> <Plug>(vimfiler_expand_tree)
          \ :<C-u>call <SID>toggle_tree(0)<CR>
    nnoremap <buffer><silent> <Plug>(vimfiler_expand_tree_recursive)
          \ :<C-u>call <SID>toggle_tree(1)<CR>
endfunction

augroup vimfiler_autos
    autocmd!
    autocmd FileType vimfiler call ConfigureVimfiler()
augroup END


"-----------------------------------------------------------------------------
" vim-gitgutter
"-----------------------------------------------------------------------------
let g:gitgutter_diff_args = '-w'   " Don't diff the whitespace

"-----------------------------------------------------------------------------
" vim-go
"-----------------------------------------------------------------------------
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"-----------------------------------------------------------------------------
" notational-fzf-vim
"-----------------------------------------------------------------------------
let g:nv_search_paths = ["~/.deft"]
let g:nv_default_extension = '.md'

function! s:StartNV()
    execute "NV"
endfunction
nnoremap <silent> <F12> :call <SID>StartNV()<cr>
nnoremap <silent> <leader>s :call <SID>StartNV()<cr>

"-----------------------------------------------------------------------------
" netrw - this comes with vim for directory exploration
"-----------------------------------------------------------------------------
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 20

function ConfigureNetrw()
    syn match netrwBar /|/
    highlight link netrwBar Comment
endfunction

augroup netrw_autos
    autocmd!
    autocmd FileType netrw call ConfigureNetrw()
augroup END
"-----------------------------------------------------------------------------
" vim-markdown
"-----------------------------------------------------------------------------
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_folding_level = 0

function ConfigureMarkdown()
    highlight link htmlH1 Statement
    highlight link htmlH2 Statement
    highlight link htmlH3 Statement
    highlight link htmlH4 Statement
    highlight link htmlH5 Statement
    highlight link htmlH6 Statement
    highlight link mkdHeading Function
    nnoremap <buffer> <Tab> za
    nnoremap <buffer> <S-Tab> zM
    syntax sync minlines=10000  " A little slower but useful for larger markdown blocks
endfunction

augroup markdown_autos
    autocmd!
    autocmd FileType markdown call ConfigureMarkdown()
augroup END


"-----------------------------------------------------------------------------
" open-browser
"-----------------------------------------------------------------------------
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nnoremap gx <Plug>(openbrowser-smart-search)
vnoremap gx <Plug>(openbrowser-smart-search)


"-----------------------------------------------------------------------------
" yaml
"-----------------------------------------------------------------------------
function ConfigureYAML()
    setlocal ts=2 sts=2 sw=2 expandtab
endfunction

augroup yaml_autos
    autocmd!
    autocmd FileType yaml call ConfigureYAML()
augroup END


"-----------------------------------------------------------------------------
" Global Keymappings
"-----------------------------------------------------------------------------
" Commenting with commentary
nmap <silent> <C-c> <Plug>CommentaryLine
vmap <silent> <C-c> <Plug>Commentary

" Easier navigation of quickfix
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

" Mapping typical keys
noremap <PageUp> 
noremap <PageDown> 
noremap <Home> 0
noremap <End> $
noremap <C-Home> 1G
noremap <C-End> G$
noremap <silent> <C-d> 12j
noremap <silent> <C-u> 12k

" Fast ESC alternative in Insert mode
inoremap jk <Esc>

" Searching what is highlighted
vnoremap <leader>/ y/<C-R>"

" Like emacs occur; occur on what you last searched for
nnoremap g/ :set hlsearch<CR>:vimgrep /<C-R>//j %<CR>\|:cw<CR>

" Command line
cnoremap <C-A>     <Home>
cnoremap <C-E>     <End>
cnoremap <Esc>b    <S-Left>
cnoremap <Esc>f    <S-Right>
cnoremap <Esc><Backspace>    <C-W>
cnoremap ∫    <S-Left>
cnoremap ƒ    <S-Right>
cnoremap <A-Backspace>    <C-W>

" Playing with vimrc
nnoremap <leader>ve :e $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

" Journaling with notational/deft
function s:GetLatestJournalEntry()
    let l:all_entries = split(globpath(expand("~/.deft"), "todo-*.md"), "\n")
    call sort(l:all_entries)
    if len(l:all_entries) > 0
        return l:all_entries[-1:-1][0]
    endif
endfunction

function OpenJournal()
    let l:today = strftime("%Y-%m-%d")
    let l:today_journal = expand("~/.deft/todo-" . l:today . ".md")
    let l:yesterday_journal = s:GetLatestJournalEntry()

    if filereadable(l:today_journal)
        execute "edit" l:today_journal
    else
        if (l:yesterday_journal !=# "0") && filereadable(l:yesterday_journal)
            let l:yesterday_content = readfile(l:yesterday_journal, "b")
            call writefile(l:yesterday_content, l:today_journal, "b")
            execute "edit" l:today_journal
            call deletebufline(bufname("%"), 1, 1)
        else
            execute "edit" l:today_journal
        endif

        call appendbufline(bufname("%"), 0, "TODO:" . l:today)
        execute "write"
    endif
endfunction
command! -nargs=0 OpenJournal call OpenJournal()
nnoremap <silent> <leader>l :OpenJournal<cr>

" Fast searching with rg and fzf
function! s:HandleRgSelection(lines) abort
    let l:file_info = split(a:lines[2], ":")
    execute("edit " . l:file_info[0])
    execute("normal! " . l:file_info[1] . "G")
endfunction

command! -nargs=1 -bang Rg grep <args> *

command! -nargs=* -bang Rgi
      \ call fzf#run(
          \ fzf#wrap({
              \ 'sink*': function('<SID>HandleRgSelection'),
              \ 'window': 'edit',
              \ 'source': join([
                   \ 'rg',
                   \ '--follow',
                   \ '--smart-case',
                   \ '--line-number',
                   \ '--color never',
                   \ '--no-messages',
                   \ '--no-heading',
                   \ '--with-filename',
                   \ '""',
                   \ '2>/dev/null',
                   \ ]),
              \ 'down': '40%',
              \ 'options': join([
                               \ '--query ' . ((<q-args> is '') ?  '""' : shellescape(<q-args>)),
                               \ '--print-query',
                               \ '--ansi',
                               \ '--multi',
                               \ '--exact',
                               \ '--inline-info',
                               \ '--delimiter=":"',
                               \ '--with-nth=' . '3..',
                               \ '--tiebreak=' . 'length,begin' ,
                               \ '--expect=' . 'ctrl-s,ctrl-v,ctrl-t',
                               \ '--bind=' .  join([
                                              \ 'alt-a:select-all',
                                              \ 'alt-q:deselect-all',
                                              \ 'alt-p:toggle-preview',
                                              \ 'alt-u:page-up',
                                              \ 'alt-d:page-down',
                                              \ 'ctrl-w:backward-kill-word',
                                              \ ], ','),
                               \ '--preview="echo {} | awk -F: ''{print \$1 \" -H \" \$2 \" -r \" (\$2 < 10 ? 0 : (\$2 - 10)) \":\" (\$2 + 10)}'' | xargs bat -f 2>/dev/null || true"',
                               \ '--preview-window=' . join(filter(copy([
                                                                   \ 'right',
                                                                   \ ]),
                                                            \ 'v:val != "" ')
                                                       \ ,':')
                               \ ])},<bang>0))


" Easier formatting
function FormatOrIndent()
    normal! ml
    let l:attrName = synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")
    if l:attrName ==# "Comment"
        call SyntaxVisualSelect('b')
        normal! gq
    elseif l:attrName ==# "" || &ft ==# "" || &ft ==# "gitcommit"
        normal! gqip
    elseif &ft ==# "lisp"
        normal! =ap
    elseif &ft ==# "perl" && executable("perltidy")
        execute "normal! VaB:!perltidy -q\<cr>"
    else
        normal! ml=aB
    endif
    normal! `l
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
        normal! dw
    endif
endfunction
inoremap <silent> <C-\><C-\> <C-O>:call DeleteHorizontalSpace()<CR>
nnoremap <silent> <C-\><C-\> :call DeleteHorizontalSpace()<CR>

" Tab navigation
function CustomPreviousTab()
    bp
endfunction
function CustomNextTab()
    bn
endfunction
function CustomNewTab()
    new
endfunction

nnoremap <silent> <Esc>k :call CustomPreviousTab()<cr>
nnoremap <silent> <Esc>j :call CustomNextTab()<cr>
nnoremap <silent> <Esc>c :if len(getwininfo()) ==# 1<cr>bd!<cr>else<cr>q!<cr>endif<cr>
nnoremap <silent> <Esc>n :call CustomNewTab()<cr>
nnoremap <Esc>t :tabnew<space><C-R>=expand("%:p")<cr>
nnoremap Q :echo "I just saved you from Q"<cr>
noremap gV `[v`]
onoremap s t_

" Inserting markdown
nnoremap <silent> <leader>` o<CR>```<CR>```<CR><Esc>kO<Esc>

" Integrate with github browsing
function! GithubBrowse() range
    execute ':!gh browse ' . expand('%') . ':' . a:firstline . '-' . a:lastline
endfunction
nnoremap <silent> <leader>gl :call GithubBrowse()<cr>
vnoremap <silent> <leader>gl :call GithubBrowse()<cr>


"-----------------------------------------------------------------------------
" Autocommands
"-----------------------------------------------------------------------------

set viewoptions-=options
augroup vimrc
    autocmd!
    autocmd BufWinLeave *.md
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      mkview!
    \|  endif
    autocmd BufWinEnter *.md
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      silent loadview
    \|  endif
augroup END

" If the buffer is in viminfo, go to the last recorded cursor position
" Configure mail buffers (especially for mutt usage)
function! ConfigureMail()
  set ft=mail
  set shiftwidth=2
  set tabstop=2
  set textwidth=70
  set spell spelllang=en_us
endfunction

" Go files require a specific standard
function! ConfigureGo()
  set noexpandtab
  set nolist
endfunction

function! ConfigureTypescript()
  set shiftwidth=2
  set tabstop=2
endfunction

" function! PrettierTypescript(fileName)
"     silent execute '!npx prettier --write ' . a:fileName
"     silent redraw!
" endfunction

function! EslintTypescript(fileName)
    silent execute '!eslint --fix ' . a:fileName
    silent redraw!
endfunction

augroup general_autos
    autocmd!

    autocmd BufNewFile,BufRead */mutt-* call ConfigureMail()

    autocmd BufNewFile,BufRead *.js set shiftwidth=2
    autocmd BufNewFile,BufRead *.hbs set shiftwidth=2
    autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab

    " .asd files are also Lisp files
    autocmd BufNewFile,BufRead *.asd set ft=lisp

    " Vagrantfile and pp puppet files are ruby files
    autocmd BufNewFile,BufRead Vagrantfile set ft=ruby
    autocmd BufNewFile,BufRead *.pp set ft=ruby

    " .t files are also perl files
    autocmd BufNewFile,BufRead *.t set ft=perl

    " Programming language files tend to be small, so we'll do full syntax
    autocmd BufNewFile,BufRead,BufWinEnter *.asd,*.t,*.pl,*.pm,*.lisp,*.clj,*vimrc,*.vim,*.py,*.c,*.js,*.html,*.htm,*.tsx,*.ts syntax sync fromstart

    autocmd BufNewFile,BufRead,BufWinEnter *.go call ConfigureGo()
    autocmd BufNewFile,BufRead,BufWinEnter *.tsx,*.ts call ConfigureTypescript()

    augroup highlight_current_word
      au!
      au CursorHold * :silent! exec 'match CurrentWord /\V\<' . expand('<cword>') . '\>/'
    augroup END

    " if executable("npx") && executable("./node_modules/.bin/prettier")
    "     autocmd BufWritePost *.tsx,*.ts call PrettierTypescript(expand('<afile>'))
    " endif

    if executable("eslint")
        autocmd BufWritePost *.tsx,*.ts call EslintTypescript(expand('<afile>'))
    endif
augroup END

"-----------------------------------------------------------------------------
" Now that everything is in place, read local differences
"-----------------------------------------------------------------------------
if filereadable(s:vimlocaldir . "/vimrc")
    source $HOME/.vim-local/vimrc
endif

