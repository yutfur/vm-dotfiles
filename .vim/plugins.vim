vim9script

# -------------------------------------------------------------------------------------------
# プラグイン ( vim-plug )
# -------------------------------------------------------------------------------------------

# インストールするプラグイン及びその設定は最小限にすること
# Vim の標準機能によってある程度代替できる機能のプラグインはインストールしない(原則、標準機能を使う・重んじること)・Vim の標準機能(だけ)では厳しい機能を提供してくれる(＋よく使う)プラグインのみをインストールする
# https://zenn.dev/skanehira/articles/2020-12-05-vim-my-philosophy

# Space を leader キーに設定する
g:mapleader = "\<Space>"

# vim-plug の自動インストール & インストールされていないプラグインがあった場合に自動で :PlugInstall を実行する
# https://github.com/junegunn/vim-plug/wiki/tips
# Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
# Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

# ------------------ vim-plug プラグインリスト ------------------ #
# https://github.com/junegunn/vim-plug
# https://github.com/junegunn/vim-plug/wiki/tutorial
# https://github.com/junegunn/vim-plug/wiki/faq
call plug#begin()
# The default plugin directory will be as follows:
#   - Vim (Linux/macOS): '~/.vim/plugged'
#   - Vim (Windows): '~/vimfiles/plugged'
#   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
# You can specify a custom plugin directory by passing it as the argument
#   - e.g. `call plug#begin('~/.vim/plugged')`
#   - Avoid using standard Vim directory names like 'plugin'
# Make sure you use single quotes

# LSP / コーディング

# Markdown のプレビュー表示
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

# ファジーファインダー
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
# Rg(ripgrep)コマンドで検索中にプレビュー表示
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)nvi
# Filesコマンドでもプレビュー表示
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
# fzf キーバインド
let g:fzf_buffers_jump = 1
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fg :GFiles<CR>
nnoremap <silent> <Leader>fgs :GFiles?<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>fr :Rg<CR>
nnoremap <silent> <Leader>fl :Lines<CR>
nnoremap <silent> <Leader>fh :History<CR>
nnoremap <silent> <Leader>fc :Commands<CR>

# Git 差分表示
Plug 'airblade/vim-gitgutter'
# 目印行を常に表示する
if exists('&signcolumn')  # Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

# Git コマンド (ステータスラインにブランチ名を表示させる用、Git コマンドは内蔵ターミナルや分割したペイン上で入力すればいい)
Plug 'tpope/vim-fugitive'
set statusline+=%{fugitive#statusline()}

# ステータスラインのカスタマイズ
Plug 'itchyny/lightline.vim'
# モード非表示
set noshowmode
# 曖昧幅文字の文字幅設定 (デフォルトは single 、double だと lightline.vim の表示が崩れる)
# https://www.soum.co.jp/misc/vim-no-susume/12/#id4
# set ambiwidth=double
let g:lightline = {
        \ 'colorscheme': 'gruvbox',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'absolutepath', 'gitbranch' ], [ 'modified', 'readonly', 'bufnum' ] ],
        \   'right': [ [ 'lineinfo', 'percent' ], [ 'filetype', 'fileformat', 'fileencoding' ] ]
	\ },
        \ 'component_function': {
        \   'gitbranch': 'FugitiveHead',
        \ },
        \ }

# インデントガイドの表示
Plug 'Yggdroot/indentLine'
# ラインカラーをカラースキーム基準にする
let g:indentLine_setColors = 0
# ラインに使う文字の設定
let g:indentLine_char = '|'
# テキストを隠さずに通常通り表示する
let g:indentLine_conceallevel = 0

# レジスタ一覧表示
# ノーマルモードで # または @ 、挿入モードで <CTRL-R> を押すとサイドバーにレジスタの内容が表示される。それ以降のキー操作で自動的にサイドバーが閉じられる。
Plug 'junegunn/vim-peekaboo'
let g:peekaboo_window = 'split botright new'

# 日本語ヘルプ
Plug 'vim-jp/vimdoc-ja'
set helplang=ja,en

# Call plug#end to update &runtimepath and initialize the plugin system.
# - It automatically executes `filetype plugin indent on` and `syntax enable`
call plug#end()
# You can revert the settings after the call like so:
#   filetype indent off   " Disable file-type-specific indentation
#   syntax off            " Disable syntax highlighting

# Color schemes should be loaded after plug#end().
# We prepend it with 'silent!' to ignore errors when it's not yet installed.
# ------------------ vim-plug プラグインリスト ------------------ #

