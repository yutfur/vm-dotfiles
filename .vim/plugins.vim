
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

