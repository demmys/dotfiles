" ===== Basics =====
set encoding=utf-8
scriptencoding utf-8

if &compatible
  set nocompatible
endif

" Reset filetype so detection can be re-enabled explicitly
filetype off
filetype plugin indent off

" ===== Plugin manager (dein.vim) =====
let s:dein_dir      = stdpath('data') . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:rc_dir        = stdpath('config') . '/rc'

if !isdirectory(s:dein_dir)
  call mkdir(s:dein_dir, 'p')
endif
if !isdirectory(s:rc_dir)
  call mkdir(s:rc_dir, 'p')
endif

if !isdirectory(s:dein_repo_dir)
  if executable('git')
    call system(['git', 'clone', '--depth', '1', 'https://github.com/Shougo/dein.vim', s:dein_repo_dir])
  else
    echohl ErrorMsg | echom 'git is not available; install dein.vim manually under ' . s:dein_repo_dir | echohl None
  endif
endif

let s:dein_rtp = fnamemodify(s:dein_repo_dir, ':p')
if has('win32') || has('win64')
  let s:dein_rtp = substitute(s:dein_rtp, '\\', '/', 'g')
endif
let s:dein_rtp = substitute(s:dein_rtp, '/$', '', '')
execute 'set runtimepath^=' . fnameescape(s:dein_rtp)

try
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#load_toml(s:rc_dir . '/dein.toml', { 'lazy': 0 })
    call dein#load_toml(s:rc_dir . '/dein_lazy.toml', { 'lazy': 1 })
    call dein#end()
    call dein#save_state()
  endif
  if dein#check_install()
    call dein#install()
  endif
catch /^Vim\%((\a\+)\)\=:E117/
  echohl WarningMsg | echom 'Failed to load dein autoload files. Verify runtimepath and clone: ' . s:dein_rtp | echohl None
endtry

" ===== Built-in packages =====
silent! packadd matchit

" ===== Standard settings =====
syntax enable
set number
set showmatch matchtime=1
set list listchars=tab:>\ ,extends:<
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set cindent
set cinoptions=:0,=1s
set splitright
set splitbelow
set nobackup
set hlsearch
set incsearch
set ignorecase
set smartcase
set laststatus=2
set foldmethod=marker
set showcmd
nnoremap <silent> <Leader>p :set invpaste<CR>:set paste?<CR>
set backspace=indent,eol,start

if has('macunix')
  set clipboard=unnamedplus
else
  set clipboard=unnamed,unnamedplus
endif

" PHP/SQL defaults
let php_htmlInStrings = 1
let php_baselib = 1
let php_asp_tags = 1
let php_noShortTags = 1
let g:sql_type_default = 'mysql'

" ===== Keymaps =====
nnoremap <CR> o<Esc>
cnoremap <C-a> <Home> | inoremap <C-a> <Home>
cnoremap <C-e> <End>  | inoremap <C-e> <End>
cnoremap <C-f> <Right>| inoremap <C-f> <Right>
cnoremap <C-b> <Left> | inoremap <C-b> <Left>
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <silent> gc :<C-u>tabnew<CR>
nnoremap gn gt
nnoremap gp gT
nnoremap <silent> gx :<C-u>tabclose<CR>
nnoremap <silent> go :<C-u>tabonly<CR>

" ===== Colors =====
augroup FoldedColorSafe
  autocmd!
  autocmd VimEnter * call <SID>SetFoldedColor()
augroup END

function! s:SetFoldedColor() abort
  if has('termguicolors')
    set termguicolors
    let l:fg = synIDattr(hlID('LineNr'), 'fg#')
    if empty(l:fg)
      let l:fg = '#808080'
    endif
    execute 'highlight Folded guifg=' . l:fg . ' guibg=NONE'
  else
    let l:fg = synIDattr(hlID('LineNr'), 'fg', 'cterm')
    if empty(l:fg)
      let l:fg = '8'
    endif
    execute 'highlight Folded ctermfg=' . l:fg . ' ctermbg=0'
  endif
endfunction

" ===== Binary edit helpers (requires xxd) =====
augroup BinaryEditVimrcCommands
  autocmd!
  autocmd BufReadPre  *.bin let &binary = 1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1 | set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1 | set nomod | endif
augroup END

" ===== Auto cursorline =====
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

" ===== Rename command =====
command! -nargs=1 -complete=file Rename file %:h/<args>|call delete(expand('#'))

" ===== LSP and Treesitter Settings (Lua) =====
lua << EOF
-- 安全にモジュールをロードする関数
local function safe_require(module_name)
  local status, module = pcall(require, module_name)
  if not status then return nil end
  return module
end

-- Mason: LSPサーバのマネージャ
local mason = safe_require("mason")
local mason_lspconfig = safe_require("mason-lspconfig")
if mason and mason_lspconfig then
  mason.setup()
  mason_lspconfig.setup({
    ensure_installed = { "gopls" },
  })
end

-- Masonのバイナリパスを優先的に追加 (vim.lsp.config が gopls を見つけられるようにする)
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

-- LSPがアタッチされた時の動作設定
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- Inlay Hintsを有効化 (サーバが対応している場合)
    if client and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
})

-- gopls: Neovim native API (vim.lsp.config + vim.lsp.enable) で設定
-- NOTE: root_dir に関数を渡すと callback 形式 (bufnr, on_dir) が必要なため、
--       宣言的な root_markers を使用する
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gosum" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})
vim.lsp.enable("gopls")

-- Treesitter: ハイライト設定
local ts_configs = safe_require("nvim-treesitter.configs")
if ts_configs then
  ts_configs.setup {
    ensure_installed = { "go", "gomod", "gowork", "gosum", "lua", "vim" },
    highlight = {
      enable = true,
      disable = { "help" },
    },
  }
end

-- LSP関連のキーマップ設定
vim.keymap.set('n', 'K',  vim.lsp.buf.hover)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', 'gn', vim.lsp.buf.rename)
vim.keymap.set('n', 'ge', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
EOF

" ===== Filetypes / per-language =====
filetype plugin indent on
augroup FileTypeVimrcCommands
  autocmd!
  autocmd FileType go setlocal nolist | setlocal listchars=extends:<
  autocmd FileType go setlocal noexpandtab tabstop=2 shiftwidth=2
  autocmd FileType typescript,typescriptreact,javascript,javascriptreact,vue,json,ruby,scss,yaml,coffee,pug setlocal tabstop=2 shiftwidth=2
  autocmd FileType haskell,cabal setlocal foldmethod=marker
  autocmd BufRead,BufNewFile Gemfile,Guardfile setlocal filetype=ruby
  autocmd BufRead,BufNewFile *.coffee setlocal filetype=coffee
  autocmd BufRead,BufNewFile *.jade setlocal filetype=pug
  autocmd BufRead,BufNewFile *.ll setlocal filetype=llvm
  autocmd FileType * setlocal textwidth=0
augroup END
