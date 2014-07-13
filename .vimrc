"+-----------+
"| NeoBundle |
"+-----------+

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
            \     },
            \ }
" auto completion system
NeoBundle 'Shougo/neocomplcache.vim'
" data choose interface
NeoBundle 'Shougo/unite.vim'
" html, css syntax expander
NeoBundle 'mattn/emmet-vim'
" decorate status line
NeoBundle 'itchyny/lightline.vim'

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
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags



"+----------------------+
"| Vim default settings |
"+----------------------+

" disable vi compatible mode
set nocompatible
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



"+--------------------------------------+
"| Redefine file type specific settings |
"+--------------------------------------+

" always disable limitation of text width
autocmd FileType * setlocal textwidth=0



"+--------------+
"| Key mappings |
"+--------------+

" to press enter always create new line
map <Enter> o<Esc>
map <S-Enter> O<Esc>
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
" display a searched word in the center
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
" create new tab
nnoremap gc :<C-u>tabnew<CR>
" move tab
nnoremap gn gt
nnoremap gp gT
" close current tab
nnoremap gx :<C-u>tabclose<CR>
" close all another tabs
nnoremap go :<C-u>tabonly<CR>



"+---------------+
"| Lightline.vim |
"+---------------+

let g:lightline = { 'colorscheme': 'wombat' }



"+---------------------------------------------------------------+
"| Auto cursor line                                              |
"|  by thinca (http://d.hatena.ne.jp/thinca/20090530/1243615055) |
"+---------------------------------------------------------------+

" do not show cursor line while cursor hold event occured (controlled by updatetime)
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



"+--------------------------------------------------------+
"| BinaryXXD                                              |
"|  by KaWaZ (http://www.kawaz.jp/pukiwiki/?vim#ib970976) |
"+--------------------------------------------------------+

" enable binary edit mode when launched with -b option
augroup BinaryXXD
    autocmd!
    autocmd BufReadPre  *.bin let &binary = 1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r | endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END
