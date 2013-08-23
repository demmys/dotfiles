"plugin
filetype plugin indent on
set rtp+=~/.vim/vundle.git/
call vundle#rc()
"Omni completion
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
"Haskell
Bundle 'ujihisa/neco-ghc'
"Syntax highlight
Bundle 'dag/vim2hs'
"Browser
Bundle 'open-browser.vim'
Bundle 'browsereload-mac.vim'
"HTML
Bundle 'mattn/zencoding-vim'
Bundle 'surround.vim'
Bundle 'html5.vim'
"CSS
Bundle 'css3-syntax-plus'
"JavaScript
Bundle 'pangloss/vim-javascript'
"Access
Bundle 'unite.vim'
"Entertainment
Bundle 'Lokaltog/vim-powerline'
Bundle 'matrix.vim--Yang'
Bundle 'TwitVim'
"sudo
Bundle 'sudo.vim'

"view
syntax on
set number
set showmatch matchtime=1
set showcmd
set wildmenu
set list
set listchars=tab:>\ ,extends:<
	"cursor
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

"vundle
nnoremap <Space>s :BundleSearch

"edit
map <S-Enter> O<ESC>
map <Enter> o<ESC>
set autoread

"command mode
cmap <C-a> <Home>
cmap <C-e> <End>
cmap <C-f> <Right>
cmap <C-b> <Left>

"indent
set autoindent
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=0
set smartindent
set cindent
set smarttab
set nofoldenable

"move
nnoremap <silent> j gj
nnoremap <silent> k gk
"nnoremap <C-k> :call search ("^". matchstr (getline (line (".")+ 1), '\(\s*\)') ."\\S", 'b')<CR>
"nnoremap <C-j> :call search ("^". matchstr (getline (line (".")), '\(\s*\)') ."\\S")<CR>

"split
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
set splitright
set splitbelow
command! -nargs=? -complete=file Sp mz|sp|<C-k>|'z|z<Enter>|<C-j>

"window size
nnoremap <C-w>h <C-w>5>
nnoremap <C-w>l <C-w>5>
nnoremap <C-w>j <C-w>5+
nnoremap <C-w>k <C-w>5+

"unite
noremap <Space>b :Unite buffer<CR>
noremap <Space>f :UniteWithBufferDir -buffer-name=files file<CR>
noremap <Space>r :Unite file_mru<CR>
noremap <Space>y :Unite -buffer-name=register register<CR>
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 0
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><c-l> neocomplcache#complete_common_string()
inoremap <expr><c-y> neocomplcache#close_popup()
inoremap <expr><c-e> neocomplcache#cancel_popup()
inoremap <expr><c-h> neocomplcache#smart_close_popup()."\<c-h>"
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

"file
set nobackup
augroup vimrcEx
	autocmd!
	autocmd BufReadPost *
				\ if line("'\"") > 1 && line("'\"") <= line('$') |
				\   exe "normal! g`\"" |
				\ endif
augroup END

"search
set hlsearch
set incsearch
set ignorecase
set nosmartcase
set wrapscan
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

"others
set clipboard+=autoselect
set clipboard+=unnamed
set laststatus=2

"mouse
set mouse=a
set ttymouse=xterm2
if has('gui_running')
	set mousemodel=popup
	set nomousefocus
	set mousehide
endif

"encoding
set fileencoding=utf-8
set encoding=utf-8
"if &encoding !=# 'utf-8'
"	set encoding=japan
"	set fileencoding=japan
"endif
"if has('iconv')
"	let s:enc_enc = 'ecu-jp'
"	let s:enc_jis = 'iso-2022-jp'
"	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
"		let s:enc_euc = 'eucjp-ms'
"		let s:enc_jis = 'iso-2022-jp-3'
"	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
"		let s:enc_euc = 'euc-jisx0213'
"		let s:enc_jis = 'iso-2022-jp-3'
"	endif
"
"	if &encoding ==# 'utf-8'
"		let s:fileencodings_default = &fileencodings
"		let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
"		let &fileencodings = &fileencodings .','. s:fileencodings_default
"		unlet s:fileencodings_default
"	else
"		let &fileencodings = &fileencodings .','. s:enc_jis
"		set fileencodings+=utf-8,ucs-2le,ucs-2
"		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
"			set fileencodings+=cp932
"			set fileencodings-=euc-jp
"			set fileencodings-=euc-jisx0213
"			set fileencodings-=eucjp-ms
"			let &encoding = s:enc_euc
"			let &fileencoding = s:enc_euc
"		else
"			let &fileencodings = &fileencodings .','. s:enc_euc
"		endif
"	endif
"	unlet s:enc_euc
"	unlet s:enc_jis
"endif
"if has('autocmd')
"	function! AU_ReCheck_FENC()
"		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
"			let &fileencoding=&encoding
"		endif
"	endfunction
"endif
"set fileformats=unix,dos,mac
"
"if exists('ambiwidth')
"	set ambiwidth=double
"endif

"Java
let java_highlight_all=1
let java_highlight_functions="style"
let java_space_errors=1

"C++
let java_allow_cpp_keywords=1

"HTML
let g:user_zen_settings = {
    \ 'lang' : 'ja',
    \ 'html' : {
    \   'filters' : 'html',
    \   },
    \ 'css' : {
    \   'filters' : 'fc',
    \   },
    \ }
syn keyword htmlTagName contained article aside audio bb canvas command
syn keyword htmlTagName contained datalist details dialog embed figure
syn keyword htmlTagName contained header hgroup keygen mark meter nav output
syn keyword htmlTagName contained progress time ruby rt rp section time
syn keyword htmlTagName contained source figcaption
syn keyword htmlArg contained autofocus autocomplete placeholder min max
syn keyword htmlArg contained contenteditable contextmenu draggable hidden
syn keyword htmlArg contained itemprop list sandbox subject spellcheck
syn keyword htmlArg contained novalidate seamless pattern formtarget
syn keyword htmlArg contained formaction formenctype formmethod
syn keyword htmlArg contained sizes scoped async reversed sandbox srcdoc
syn keyword htmlArg contained hidden role
syn match   htmlArg "\<\(aria-[\-a-zA-Z0-9_]\+\)=" contained
syn match   htmlArg contained "\s*data-[-a-zA-Z0-9_]\+"

"binary edit
augroup BinaryXXD
    autocmd!
    autocmd BufReadPre  *.bin let &binary =1
    autocmd BufReadPre  *.class let &binary =1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | silent %!xxd -r
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END

"Web Browser
nmap <Leader>o <Plug>(openbrowser-open)
vmap <Leader>o <Plug>(openbrowser-open)
nnoremap <Leader>g :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>
let g:returnApp = 'iTerm'
nmap <Space>bc :ChromeReloadStart<CR>
nmap <Space>bC :ChromeReloadStop<CR>
nmap <Space>bf :FirefoxReloadStart<CR>
nmap <Space>bF :FirefoxReloadStop<CR>
nmap <Space>bs :SafariReloadStart<CR>
nmap <Space>bS :SafariReloadStop<CR>
nmap <Space>bo :OperaReloadStart<CR>
nmap <Space>bO :OperaReloadStop<CR>
nmap <Space>ba :AllBrowserReloadStart<CR>
nmap <Space>bA :AllBrowserReloadStop<CR>

"Twitter
let twitvim_count = 40
nnoremap <Space>tt :<C-u>PosttoTwitter<CR>
nnoremap <Space>tl :<C-u>FriendsTwitter<CR>
nnoremap <Space>tu :<C-u>UserTwitter<CR>
nnoremap <Space>tr :<C-u>MentionsTwitter<CR>
nnoremap <Space>td :<C-u>DMTwitter<CR>
nnoremap <Space>ts :<C-u>DMSentTwitter<CR>
nnoremap <Space>tn :<C-u>NextTwitter<CR>
nnoremap <Space>tp :<C-u>PreviousTwitter<CR>
nnoremap <Leader><Leader> :<C-u>RefreshTwitter<CR>
