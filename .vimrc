"+----------------+
"| Initialization |
"+----------------+

" disable vi compatible mode
set nocompatible
" html tag, strings % match extention
runtime macros/matchit.vim



"+---------------+
"| NeoBundle.vim |
"+---------------+

" initialization
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'


" async command execution
NeoBundle 'Shougo/vimproc.vim', {
            \     'build' : {
            \         'windows' : 'tools\\update-dll-mingw',
            \         'cygwin' : 'make -f make_cygwin.mak',
            \         'mac' : 'make -f make_mac.mak',
            \         'unix' : 'make -f make_unix.mak',
            \     }
            \ }
" auto completion system
NeoBundle 'Shougo/neocomplcache.vim'
" data choose interface
NeoBundle 'Shougo/unite.vim', {
            \     'depends': ['Shougo/vimproc.vim']
            \ }
" insert code snippet
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets', {
            \     'depends': ['Shougo/neosnippet.vim']
            \ }
" decorate status line
NeoBundle 'itchyny/lightline.vim'
" use asynchronous shell in vim
NeoBundleLazy 'Shougo/vimshell.vim', {
            \     'depends': ['Shougo/vimproc.vim'],
            \     'autoload': {
            \         'commands': ['VimShell', 'VimShellPop', 'VimShellInteractive']
            \     }
            \ }
" use vim with sudo
NeoBundle 'sudo.vim'
" highlight matchit.vim matched strings
NeoBundleLazy 'vimtaku/hl_matchit.vim.git', {
            \     'autoload': {
            \         'filetypes': ['vim', 'verilog', 'html']
            \     }
            \ }
" use git in vim
NeoBundle 'tpope/vim-fugitive'
" use twitter in vim
NeoBundleLazy 'tweetvim', {
            \     'depends': [
            \         'Shougo/unite.vim',
            \         'mattn/webapi-vim',
            \         'open-browser.vim',
            \         'basyura/twibill.vim',
            \         'basyura/bitly.vim'
            \     ],
            \     'autoload': {
            \         'commands': ['TweetVimHomeTimeline', 'TweetVimMentions'],
            \         'unite_sources': ['tweetvim']
            \     }
            \ }
" html, css syntax expander
NeoBundleLazy 'mattn/emmet-vim', {
            \     'autoload': {
            \         'filename_patterns': ['.*\.html'],
            \         'filetype': ['html']
            \     }
            \ }
" html5 syntax highlighting
NeoBundleLazy 'othree/html5.vim', {
            \     'autoload': {
            \         'filename_patterns': ['.*\.html'],
            \         'filetype': ['html']
            \     }
            \ }
" less syntax highlighting
NeoBundle 'groenewege/vim-less'
" display color of css
NeoBundleLazy 'ap/vim-css-color', {
            \     'autoload': {
            \         'filename_patterns': ['.*\.css', '.*\.less', '.*\.sass'],
            \         'filetype': ['css', 'less', 'sass']
            \     }
            \ }
" markdown syntax highlighting
NeoBundle 'rcmdnk/vim-markdown'
" scala syntax highlighting
NeoBundleLazy 'derekwyatt/vim-scala', {
            \     'autoload': {
            \         'filename_patterns': ['.*\.scala'],
            \         'filetype': ['scala']
            \     }
            \ }
" play framework files syntax highlighting
NeoBundleLazy 'gre/play2vim', {
            \     'depends': [
            \         'derekwyatt/vim-scala',
            \         'othree/html5.vim'
            \     ],
            \     'autoload': {
            \         'filename_patterns': ['.*\.scala\.html', '.*\/conf\(.*\|\)routes', '.*\/conf\/.*\.conf', 'plugins.sbt'],
            \         'filetype': ['play2-html', 'play2-routes', 'play2-conf', 'scala']
            \     }
            \ }

call neobundle#end()
" check whether plugins are installed
NeoBundleCheck



"+--------------------+
"| Neocomplecache.vim |
"+--------------------+

" always enable completion
let g:neocomplcache_enable_at_startup = 1
" ignore case of input while used upper case for completion
let g:neocomplcache_enable_smart_case = 1
" enable completion separated by under bar
let g:neocomplcache_enable_underbar_completion = 1
" cache all words longer than 3 characters for completion
let g:neocomplcache_min_syntax_length = 3
" completion with tab
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" close completion popup with ctrl-h
inoremap <expr><C-h> neocomplcache#close_popup()
" enable omni completion
augroup NeocomplcacheVimrcCommands
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END



"+--------------------+
"| Neocomplecache.vim |
"+--------------------+

" expand snippet with Return
imap <expr><CR> !pumvisible() ? "\<CR>" :
            \ neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" :
            \ neocomplcache#close_popup()



"+---------------+
"| Lightline.vim |
"+---------------+

" change colorscheme
let g:lightline = { 'colorscheme': 'wombat' }



"+-----------+
"| Unite.vim |
"+-----------+

" open file index with space + f
noremap <Space>f :<C-u>UniteWithBufferDir file<CR>
" close unite with double esc
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>



"+--------------+
"| VimShell.vim |
"+--------------+

" display current directory in prompt
let g:vimshell_prompt_expr = 'getcwd()." $ "'
let g:vimshell_prompt_pattern = '^\f\+\$ '



"+-----------+
"| Unite.vim |
"+-----------+

let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_hl_groupname = 'IncSearch'
let g:hl_matchit_speed_level = 1
let g:hl_matchit_allow_ft = 'html,vim,sh,verilog'



"+--------------+
"| Vim-Markdown |
"+--------------+

let g:vim_markdown_folding_disabled = 1



"+-----------+
"| Unite.vim |
"+-----------+

nnoremap <Space>t :<C-u>Unite tweetvim<CR>



"+----------------------+
"| Vim default settings |
"+----------------------+

" enable syntax highlight
syntax enable
" enable file type cognition
filetype plugin indent on
" show line number
set number
" show matching paren
set showmatch matchtime=1
" show tabs and wrapped lines
set list listchars=tab:>\ ,extends:<
" always insert spaces instead of tab
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
" auto indentation
set smartindent
" put the new window current window place
set splitright
set splitbelow
" do not remain backup file after close file
set nobackup
" highlight matches when search
set hlsearch
" enable increment search
set incsearch
" enable ignore case when search without upper case
set ignorecase
set smartcase
" display the status line anytime
set laststatus=2
" always display command
set showcmd



"+--------------+
"| Key mappings |
"+--------------+

" to press enter always create new line
map <CR> o<Esc>
" shell like cursor move in command mode
cmap <C-a> <Home>
cmap <C-e> <End>
cmap <C-f> <Right>
cmap <C-b> <Left>
" always move in visual line
nnoremap <silent> j gj
nnoremap <silent> k gk
" simplify commands to move window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" clear search highlight with double esc
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>
" create new tab
nnoremap gc :<C-u>tabnew<CR>
" move tab
nnoremap gn gt
nnoremap gp gT
" close current tab
nnoremap gx :<C-u>tabclose<CR>
" close all another tabs
nnoremap go :<C-u>tabonly<CR>



"+----------------------------+
"| Language specific settings |
"+----------------------------+


" Machine Language
"     enable binary edit mode when launched with -b option
"     by KaWaZ (http://www.kawaz.jp/pukiwiki/?vim#ib970976)
augroup BinaryXXD
    autocmd!
    autocmd BufReadPre  *.bin let &binary = 1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r | endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END



"+----------------+
"| Other settings |
"+----------------+

" do not show cursor line while cursor hold event occured (controlled by updatetime)
"     by thinca (http://d.hatena.ne.jp/thinca/20090530/1243615055)
augroup vimrc-auto-cursorline
    autocmd!
    autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
    autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
    autocmd WinEnter * call s:auto_cursorline('WinEnter')
    autocmd WinLeave * call s:auto_cursorline('WinLeave')

    let s:cursorline_lock = 0
    function! s:auto_cursorline(event)
        if a:event ==# 'WinEnter'
            setlocal cursorline
            let s:cursorline_lock = 2
        elseif a:event ==# 'WinLeave'
            setlocal nocursorline
        elseif a:event ==# 'CursorMoved'
            if s:cursorline_lock
                if 1 < s:cursorline_lock
                    let s:cursorline_lock = 1
                else
                    setlocal nocursorline
                    let s:cursorline_lock = 0
                endif
            endif
        elseif a:event ==# 'CursorHold'
            setlocal cursorline
            let s:cursorline_lock = 1
        endif
    endfunction
augroup END

" redifine file type specific settings
augroup RedifineFileTypeSpecificSettingsVimrcCommands
    autocmd!
    " always disable limitation of text width
    autocmd FileType * setlocal textwidth=0
augroup END
