vim9script

# -------------------------------------------------------------------------------------------
# プラグイン ( vim-plug )
# -------------------------------------------------------------------------------------------

# インストールするプラグイン及びその設定は最小限にすること
# Vim の標準機能によってある程度代替できる機能のプラグインはインストールしない(原則、標準機能を使う・重んじること)・Vim の標準機能(だけ)では厳しい機能を提供してくれる(＋よく使う)プラグインのみをインストールする
# https://zenn.dev/skanehira/articles/2020-12-05-vim-my-philosophy

# Space を leader キーに設定する
g:mapleader = "\<Space>"

# vim-plug がインストールされていなければインストールして、その後、:PlugInstall を実行する
# https://github.com/junegunn/vim-plug/wiki/tips
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

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
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
# 自動補完
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

# Markdown のプレビュー表示
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

# インデントガイドの表示
Plug 'nathanaelkane/vim-indent-guides'
# 設定
g:indent_guides_enable_on_vim_startup = 1
g:indent_guides_start_level = 2
g:indent_guides_guide_size = 1
g:indent_guides_exclude_filetypes = ['help']

# ファジーファインダー
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

# Git 差分表示
Plug 'airblade/vim-gitgutter'
# 目印行を常に表示する
if exists('&signcolumn')  # Vim 7.4.2201
    set signcolumn=yes
else
    g:gitgutter_sign_column_always = 1
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
g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \     'left': [ [ 'mode', 'paste' ], [ 'absolutepath', 'gitbranch' ], [ 'modified', 'readonly', 'bufnum' ] ],
    \     'right': [ [ 'lineinfo', 'percent' ], [ 'filetype', 'fileformat', 'fileencoding' ] ]
    \ },
    \ 'component_function': {
    \     'gitbranch': 'FugitiveHead',
    \ },
    \ }

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
