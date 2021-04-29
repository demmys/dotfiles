set encoding=utf-8
scriptencoding utf-8
" encodingでVimの内部文字コードをUTF-8に設定
" scriptencodingでこのVimScript中のコメントなどでマルチバイト文字を使用できるよう設定

" vi互換モードで起動されたとしてもこれはvimなので互換モードにしない
if &compatible
    set nocompatible
endif

" 意図せずfiletypeがonになっているとファイルタイプの検出がうまく動作しないので一度off
filetype off
filetype plugin indent off

"""
" プラグイン設定 {{{
"""
" dein.vimに関するディレクトリ
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:rc_dir = expand('~/.vim/rc')

if has('vim_starting')
    " 起動にかかる読み込み時のみ以下を実行
    if &runtimepath !~# '/dein.vim'
        if !isdirectory(s:dein_repo_dir)
            " dein.vimがcloneされていない場合はcloneする
            execute '!git clone https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
        endif
        " runtimepathの先頭にdein.vimを追加
        execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
    endif
endif

if dein#load_state(s:dein_dir)
    " キャッシュされたdeinの状態を読み込めなかった場合だけ以下を実行
    call dein#begin(s:dein_dir)
    " 必ず読み込むプラグインのリスト
    call dein#load_toml(s:rc_dir . '/dein.toml', { 'lazy': 0 })
    " 状況に応じて読み込むプラグインのリスト
    call dein#load_toml(s:rc_dir . '/dein_lazy.toml', { 'lazy': 1 })
    call dein#end()
    " 次回起動時のために状態をキャッシュする
    call dein#save_state()
endif

if dein#check_install()
    " インストールされていないパッケージがある場合にはインストールを行う
    call dein#install()
endif

" %がHTMLタグやdef~endなどに対しても有効になるように
runtime macros/matchit.vim
" }}}

"""
" 標準設定 {{{
"""
" シンタックスハイライトをON
syntax enable
" 行番号を表示
set number
" マッチするカッコを強調表示
set showmatch matchtime=1
" タブと行の折り返しを可視化
set list listchars=tab:>\ ,extends:<
" 常にタブをスペースに展開
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
" 自動インデントをON
set smartindent
" 新しいウィンドウを開く際に現在のウィンドウの位置が変わらないように
set splitright
set splitbelow
" バックアップファイルを作成しない
set nobackup
" 検索でマッチしたワードをハイライト
set hlsearch
" インクリメンタルサーチを有効化
set incsearch
" 大文字を含まない文字列での検索では大文字小文字を区別しない
set ignorecase
set smartcase
" 常にステータスラインを表示
set laststatus=2
" マーカーで折り畳む
set foldmethod=marker
" 常にコマンドを表示
set showcmd
" \+pでPasteモードと切り替え
set pastetoggle=<Leader>p
" Insertモード中に<BS>で直前の文字を消せるように
set backspace=indent,eol,start
" PHPの文字列中のHTMLをハイライトする
let php_htmlInStrings = 1
" PHPの標準ライブラリ関数をハイライトする
let php_baselib = 1
" PHPのASPスタイルタグをハイライトする
let php_asp_tags = 1
" PHPのショートタグをハイライトしない
let php_noShortTags = 1
" SQLのハイライトをMySQLベースのものにする
let g:sql_type_default = 'mysql'
" }}}

"""
" キーマップ設定 {{{
"""
" Returnキーは常に新しい行を追加するように
noremap <CR> o<Esc>
" シェルのカーソル移動コマンドを有効化
cnoremap <C-a> <Home>
inoremap <C-a> <Home>
cnoremap <C-e> <End>
inoremap <C-e> <End>
cnoremap <C-f> <Right>
inoremap <C-f> <Right>
cnoremap <C-b> <Left>
inoremap <C-b> <Left>
" 折り返した行を複数行として移動
nnoremap <silent> j gj
nnoremap <silent> k gk
" ウィンドウの移動をCtrlキーと方向指定でできるように
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Esc2回で検索のハイライトを消す
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
" gをバインドキーとしたtmuxと同じキーバインドでタブを操作
nnoremap <silent> gc :<C-u>tabnew<CR>
nnoremap gn gt
nnoremap gp gT
nnoremap <silent> gx :<C-u>tabclose<CR>
" g+oで現在開いている以外のタブを全て閉じる
nnoremap <silent> go :<C-u>tabonly<CR>
" }}}

"""
" 色設定 {{{
"""
" 折り畳んだ箇所を行番号と同じ色にする
execute 'highlight Folded ctermfg=' . synIDattr(hlID('LineNr'), 'fg') . ' ctermbg=0'
" }}}

"""
" その他設定 {{{
"""
" -bオプションで起動した場合にバイナリ編集モードを有効化する
"     original by KaWaZ (http://www.kawaz.jp/pukiwiki/?vim#ib970976) {{{
augroup BinaryEditVimrcCommands
    autocmd!
    autocmd BufReadPre  *.bin let &binary = 1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r | endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END
" }}}

" カーソルの位置を表すラインを必要なときだけ表示する
"     original by thinca (http://d.hatena.ne.jp/thinca/20090530/1243615055) {{{
augroup AutoCursorLineVimrcCommands
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
" }}}

" Renameで現在開いているファイルのファイル名を変更可能にする
"     original by ujihisa (http://vim-jp.org/vim-users-jp/2009/05/27/Hack-17.html)
command! -nargs=1 -complete=file Rename file %:h/<args>|call delete(expand('#'))
" }}}

"""
" 構文に関する設定を上書き {{{
"""
" 先頭でoffにしたfiletypeをonに
filetype plugin indent on
augroup FileTypeVimrcCommands
    autocmd!
    " Goではタブは可視化せず行の折り返しだけを可視化
    autocmd FileType go setlocal nolist
    autocmd FileType go setlocal listchars=extends:<
    " Goではタブを展開せずにスペース2つとして表示
    autocmd FileType go setlocal noexpandtab tabstop=2 shiftwidth=2
    " TypeScriptではタブをスペース2つに展開
    autocmd FileType typescript setlocal tabstop=2 shiftwidth=2
    " JavaScriptではタブをスペース2つに展開
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
    " JSONではタブをスペース2つに展開
    autocmd FileType json setlocal tabstop=2 shiftwidth=2
    " Rubyではタブをスペース2つに展開
    autocmd FileType ruby setlocal tabstop=2 shiftwidth=2
    " SCSSではタブをスペース2つに展開
    autocmd FileType scss setlocal tabstop=2 shiftwidth=2
    " YAMLではタブをスペース2つに展開
    autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
    " Gemfile, GuardfileをRubyファイルとして認識
    autocmd BufRead,BufNewFile Gemfile setlocal filetype=ruby
    autocmd BufRead,BufNewFile Guardfile setlocal filetype=ruby
    " .coffeeをCoffeeScriptとして認識
    autocmd BufRead,BufNewFile *.coffee setlocal filetype=coffee
    " CoffeeScriptではタブをスペース2つに展開
    autocmd FileType coffee setlocal tabstop=2 shiftwidth=2
    " Haskellでも折り畳み方法をマーカーに固定
    autocmd FileType haskell setlocal foldmethod=marker
    " Cabalでも折り畳み方法をマーカーに固定
    autocmd FileType cabal setlocal foldmethod=marker
    " .jadeをPugとして認識
    autocmd BufRead,BufNewFile *.jade setlocal filetype=pug
    " Pugではタブをスペース2つに展開
    autocmd FileType pug setlocal tabstop=2 shiftwidth=2
    " .llをLLVM-IRファイルとして認識
    autocmd BufRead,BufNewFile *.ll setlocal filetype=llvm
    " 常に文字数による自動改行は行わない
    autocmd FileType * setlocal textwidth=0
augroup END
" }}}
