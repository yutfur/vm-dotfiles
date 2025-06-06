vim9script

# -------------------------------------------------------------------------------------------
# プラグイン ( vim-plug )
# -------------------------------------------------------------------------------------------

# インストールするプラグイン及びその設定(量)は最小限にする・極力減らす (原則、標準割当/標準機能/標準動作を使う・重んじること)
# Vim の標準機能によってある程度代替できる機能のプラグインはインストールしない(原則、標準機能を使う・重んじること)・Vim の標準機能(だけ)では厳しい機能を提供してくれる(＋よく使う)プラグインのみをインストールする
# 特にキーバインドを変える(コマンドの割当変更/機能変更/動作変更などの)設定(量)は最小限にする・極力減らす (原則、標準割当/標準機能/標準動作を使う・重んじること)
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

# Git 差分表示
Plug 'airblade/vim-gitgutter'
# 目印行を常に表示する
set signcolumn=yes

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
