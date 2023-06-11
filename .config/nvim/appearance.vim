" -------------------------------------------------------------------------------------------
" 外観設定
" -------------------------------------------------------------------------------------------

" Neovim/Vim True Color support (https://github.com/morhetz/gruvbox/wiki/Terminal-specific)
" https://yukimemi.github.io/post/2016-09-19_true-color-in-iterm2-tmux-neovim/
set termguicolors

" シンタックスハイライトの有効化 (カラースキーム設定より上に置く)
syntax enable
" syntax on

" カラースキーム (https://qiita.com/sff1019/items/3f73856b78d7fa2731c7)
" gruvbox (https://github.com/morhetz/gruvbox)
colorscheme gruvbox
" ayu (https://github.com/ayu-theme/ayu-vim)
" let ayucolor="dark"
" colorscheme ayu
" monokai (https://github.com/sickill/vim-monokai)
" colorscheme monokai
" molokai (https://github.com/tomasr/molokai)
" colorscheme molokai

" 透明化 (カラースキームの定義より下に置く)
" https://qiita.com/s4kr4/items/b2c1b692ec430fe24f15
" https://sy-base.com/myrobotics/vim/vim-transparent/
" https://github.com/miyakogi/seiya.vim
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight SpecialKey ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE

" 行番号を表示(切り替え)
set number

" 現在の行を強調表示
set cursorline

" メッセージ表示欄の行数設定
set cmdheight=2

" 対応する括弧を強調表示
set showmatch

" ステータスラインを常に表示
set laststatus=2

" ステータスラインは lightline で設定するので無効化
" ステータスラインのテーマ設定
" let g:lightline = { 'colorscheme': 'gruvbox' }
" バッファ番号を表示
" set statusline+=[%n]
" ウィンドウの幅によってフルパスかファイル名のみ表示か切り替える
" if winwidth(0) >= 130
"   set statusline+=%F
" else
"   set statusline+=%t
" endif
" 変更チェック表示
" set statusline+=%m
" 読み込み専用かどうか表示
" set statusline+=%r
" ヘルプページなら[HELP]と表示
" set statusline+=%h
" プレビューウインドウなら[Prevew]と表示
" set statusline+=%w
" これ以降は右寄せ表示
" set statusline+=%=
" ファイルの文字コードが設定されている場合はファイルの文字コードを、それ以外ならVimの文字コードを返す、ファイルフォーマットも表示
" set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}
" バッファ内のファイルのタイプ表示
" set statusline+=%y
" 現在行数/全行数
" set statusline+=[LOW=%l/%L]

" 不可視文字を可視化
" set list
" set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" 行番号の色
" highlight LineNr ctermfg=darkyellow

" コマンド (の一部) を画面の最下行に表示する
" set showcmd

" ステータスラインの右側にカーソル位置の座標表示
" set ruler
