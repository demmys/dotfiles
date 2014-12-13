set encoding=utf-8
scriptencoding utf-8

" filetypeを一度オフにする
filetype off
filetype plugin indent off

" %がHTMLタグやdef~endなどに対しても有効になる
runtime macros/matchit.vim



"+---------------+
"| NeoBundle.vim |
"+---------------+

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'


" 非同期コマンド実行プラグイン
NeoBundle 'Shougo/vimproc.vim', {
            \     'build' : {
            \         'windows' : 'tools\\update-dll-mingw',
            \         'cygwin' : 'make -f make_cygwin.mak',
            \         'mac' : 'make -f make_mac.mak',
            \         'unix' : 'make -f make_unix.mak',
            \     }
            \ }
" 自動補完
NeoBundle 'Shougo/neocomplcache.vim'
" データ選択インターフェース
NeoBundle 'Shougo/unite.vim', {
            \     'depends': ['Shougo/vimproc.vim']
            \ }
" ファイルエクスプローラ
NeoBundle 'Shougo/vimfiler.vim', {
            \     'depends': ['Shougo/unite.vim']
            \ }
" コードスニペット集
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets', {
            \     'depends': ['Shougo/neosnippet.vim']
            \ }
" ステータスラインのデコレート
NeoBundle 'itchyny/lightline.vim'
" シェル
NeoBundle 'Shougo/vimshell.vim', {
            \     'depends': ['Shougo/vimproc.vim']
            \ }
" Visualモード時に*で選択した文字を検索できる
NeoBundle 'thinca/vim-visualstar'
" .vimrcを活かしたままsudoできる
NeoBundle 'sudo.vim'
" matchit.vimでマッチする文字をハイライト
NeoBundleLazy 'vimtaku/hl_matchit.vim.git', {
            \     'autoload': {
            \         'filetypes': ['vim', 'verilog', 'html']
            \     }
            \ }
" Vim内でGitのコマンドを使える
NeoBundle 'tpope/vim-fugitive'
" Twitterクライアント
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
" ベースネームが同じファイル間を移動する
NeoBundle 'kana/vim-altr'
" ファイルタイプにあったコメントアウトを挿入
NeoBundle 'tyru/caw.vim'
" HTMLやCSSの構文を簡単に記述できる
NeoBundleLazy 'mattn/emmet-vim', {
            \     'autoload': {
            \         'filetypes': ['html']
            \     }
            \ }
" HTML5のシンタックスハイライト
NeoBundleLazy 'othree/html5.vim', {
            \     'autoload': {
            \         'filetypes': ['html']
            \     }
            \ }
" Lessのシンタックスハイライト
NeoBundleLazy 'groenewege/vim-less', {
            \     'autoload': {
            \         'filetypes': ['less']
            \     }
            \ }
" CSSの色を表示
NeoBundleLazy 'ap/vim-css-color', {
            \     'autoload': {
            \         'filetypes': ['css', 'less', 'sass']
            \     }
            \ }
" JavaScriptのインデンテーション
NeoBundleLazy 'pangloss/vim-javascript', {
            \     'autoload': {
            \         'filetypes': ['javascript']
            \     }
            \ }
" Markdownのシンタックスハイライト
NeoBundleLazy 'rcmdnk/vim-markdown', {
            \     'autoload': {
            \         'filetypes': ['markdown']
            \     }
            \ }
" Markdownのプレビュー
NeoBundleLazy 'kannokanno/previm', {
            \     'depends': [
            \         'open-browser.vim'
            \     ],
            \     'autoload': {
            \         'filetypes': ['markdown']
            \     }
            \ }
" Scalaのシンタックスハイライト
NeoBundleLazy 'derekwyatt/vim-scala', {
            \     'autoload': {
            \         'filetypes': ['scala']
            \     }
            \ }
" Play! Frameworkの設定ファイルをシンタックスハイライト
NeoBundleLazy 'gre/play2vim', {
            \     'depends': [
            \         'derekwyatt/vim-scala',
            \         'othree/html5.vim'
            \     ],
            \     'autoload': {
            \         'filename_patterns': ['.*\.scala\.html', '.*\/conf\(.*\|\)routes', '.*\/conf\/.*\.conf', 'plugins.sbt'],
            \         'filetypes': ['play2-html', 'play2-routes', 'play2-conf', 'scala']
            \     }
            \ }
" Swiftのシンタックスハイライト
NeoBundleLazy 'Keithbsmiley/swift.vim', {
            \     'autoload': {
            \         'filetypes': ['swift']
            \     }
            \ }
" Haskellのシンタックスハイライトとインデンテーション
NeoBundleLazy 'dag/vim2hs', {
            \     'autoload': {
            \         'filetypes': ['haskell']
            \     }
            \ }
" Shakespeare HTMLテンプレートのシンタックスハイライト
NeoBundleLazy 'pbrisbin/vim-syntax-shakespeare', {
            \     'autoload': {
            \         'filetypes': ['hamlet', 'julius', 'lucius']
            \     }
            \ }
" HaskellのためのNeocomplecacheを使った自動補完
NeoBundleLazy 'eagletmt/neco-ghc', {
            \     'depends': [ 'Shougo/neocomplcache.vim' ],
            \     'autoload': {
            \         'filetypes': ['haskell']
            \     }
            \ }
" LLVM IRのシンタックスハイライト
NeoBundleLazy 'qnighy/llvm.vim', {
            \     'autoload': {
            \         'filetypes': ['llvm']
            \     }
            \ }

call neobundle#end()
" 起動時にプラグインがインストールされているか確認する
NeoBundleCheck



"+--------------------+
"| Neocomplecache.vim |
"+--------------------+

" 常に自動補完をON
let g:neocomplcache_enable_at_startup = 1
" completefuncが他のプラグインで定義されていても上書きする
let g:neocomplcache_force_overwrite_completefunc = 1
" 大文字・小文字が異なっていても自動補完候補を出す
let g:neocomplcache_enable_smart_case = 1
" アンダースコアを含む文字列も自動補完する
let g:neocomplcache_enable_underbar_completion = 1
" 3文字以上のものについて自動補完を行う
let g:neocomplcache_min_syntax_length = 3
" TABキーで補完候補を選択する
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" Ctrl+hで補完候補表示を閉じる
inoremap <expr><C-h> neocomplcache#close_popup()



"+----------------+
"| Neosnippet.vim |
"+----------------+

" Returnキーでスニペットを展開
imap <expr><CR> !pumvisible() ? "\<CR>" :
            \ neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" :
            \ neocomplcache#close_popup()



"+---------------+
"| Lightline.vim |
"+---------------+

let g:lightline = {
            \     'colorscheme': 'wombat',
            \     'active': {
            \         'left': [
            \             ['mode', 'paste'],
            \             ['readonly', 'filename', 'modified']
            \         ],
            \         'right': [
            \             ['lineinfo'],
            \             ['persent'],
            \             ['fileformat', 'fileencoding', 'filetype']
            \         ]
            \     },
            \     'component_function': {
            \         'filename': 'VimrcLightLineFileName'
            \     },
            \     'component_expand': {
            \         'readonly': 'VimrcLightLineReadOnly'
            \     },
            \     'component_type': {
            \         'readonly': 'error'
            \     }
            \ }

" helpなど自明な場合以外はわかりやすくReadOnlyを表示
function! VimrcLightLineReadOnly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'RO' : ''
endfunction

" VimFiler・VimShell・Uniteではステータス表示、それ以外はファイルパス表示
function! VimrcLightLineFileName()
    if &ft == 'vimfiler'
        return vimfiler#get_status_string()
    elseif &ft == 'unite'
        return unite#get_status_string()
    elseif &ft == 'vimshell'
        return vimshell#get_status_string()
    elseif expand('%') == ''
        return '[No Name]'
    else
        return expand('%')
    endif
endfunction



"+-----------+
"| Unite.vim |
"+-----------+

" Uniteのステータスラインを自前のものにする
let g:unite_force_overwrite_statusline = 0



"+--------------+
"| VimFiler.vim |
"+--------------+

" VimFilerのステータスラインを自前のものにする
let g:vimfiler_force_overwrite_statusline = 0
" VimFilerを標準のファイルマネージャーとして使う
let g:vimfiler_as_default_explorer = 1
" Space+ffかSpace+fs、Space+fvでカレントバッファのディレクトリを開く
noremap <silent> <Space>ff :<C-u>VimFilerBufferDir<CR>
noremap <silent> <Space>fs :<C-u>VimFilerBufferDir -split -horizontal<CR>
noremap <silent> <Space>fv :<C-u>VimFilerBufferDir -split<CR>



"+----------+
"| Vim-Altr |
"+----------+

" \+aでベースネームが同じファイルへ移動
nmap <Leader>a <Plug>(altr-forward)
" \+bで移動前のファイルに戻る
nmap <Leader>b <Plug>(altr-back)
augroup VimAltrVimrcCommands
    autocmd!
    " C用の設定
    autocmd Filetype c call altr#define('%.c', '%.h')
    " C++用の設定
    autocmd Filetype cpp call altr#define('%.cc', '%.h', '%.c')
    autocmd Filetype cpp call altr#define('src/%.cc', 'src/%.h', 'test/src/%_test.cc')
    " Play!Framework(java)用の設定
    autocmd Filetype java call altr#define('app/%.java', 'test/%Test.java')
augroup END



"+--------------+
"| VimShell.vim |
"+--------------+

" \+cでコメントアウトを挿入/解除
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)



"+--------------+
"| VimShell.vim |
"+--------------+

" プロンプトに現在のディレクトリを表示
let g:vimshell_prompt_expr = 'getcwd()." $ "'
let g:vimshell_prompt_pattern = '^\f\+\$ '



"+----------------+
"| HL_Matchit.vim |
"+----------------+

" Vim・BashScript・Verilog・Rubyでのみハイライトを有効化
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_allow_ft = 'vim,sh,verilog,ruby'
" ハイライト時の色グループを設定
let g:hl_matchit_hl_groupname = 'IncSearch'
" 対応を示すのが遅くなる場合はハイライトしない
let g:hl_matchit_speed_level = 1



"+--------------+
"| Vim-Markdown |
"+--------------+

" 自動で折りたたまないようにする
let g:vim_markdown_folding_disabled = 1



"+--------+
"| Previm |
"+--------+

" リアルタイムプレビューを有効化
let g:previm_enable_realtime = 1



"+----------+
"| TweetVim |
"+----------+

" Ctrl+tでTweetVimのUniteバッファを開く
nnoremap <silent> <Space>t :<C-u>Unite tweetvim<CR>



"+----------------------+
"| Vim default settings |
"+----------------------+

" シンタックスハイライトをON
syntax enable
" ファイルタイプ毎の設定をON
filetype plugin indent on
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
" 常にコマンドを表示
set showcmd



"+--------------+
"| Key mappings |
"+--------------+

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



"+----------------+
"| Other settings |
"+----------------+

" -bオプションで起動した場合にバイナリ編集モードを有効化する
"     original by KaWaZ (http://www.kawaz.jp/pukiwiki/?vim#ib970976)
augroup BinaryEditVimrcCommands
    autocmd!
    autocmd BufReadPre  *.bin let &binary = 1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r | endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END



" カーソルの位置を表すラインを必要なときだけ表示する
"     original by thinca (http://d.hatena.ne.jp/thinca/20090530/1243615055)
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



"+--------------------+
"| File type settings |
"+--------------------+

" filetypeを有効にする
filetype plugin indent on

augroup FileTypeVimrcCommands
    autocmd!
    " NeoComplcacheのオムニ補完を有効化
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    " Esc2回でUniteウィンドウを閉じる
    autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
    autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
    " Swift.vimの設定を上書きしてタブはスペース4つに展開
    autocmd FileType swift setlocal tabstop=4 shiftwidth=4
    " TweetVim内でsを押すと新規ツイート作成
    autocmd FileType tweetvim nnoremap <buffer> <silent> s :<C-u>TweetVimSay<CR>
    " 常に文字数による自動改行は行わない
    autocmd FileType * setlocal textwidth=0
augroup END
