" -------------------------------------------------------------------------------------------
" キーバインド(最小限にする)
" -------------------------------------------------------------------------------------------

" leaderキーを Space に
let mapleader = "\<Space>"

" バックスペースキーを有効化
set backspace=indent,eol,start

" ESC キー2度押しでハイライトを消す
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

" 行頭・行末移動は <Home>, <End> でも行える
" <Home> で現在行の空白・インデントを除く先頭に移動 (空白・インデントを含めた行頭に移動したいときは 0 が使える)
nnoremap <Home>  ^
vnoremap <Home>  ^

" 論理行移動キーと表示行移動キーの入れ替え
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gk k
nnoremap gj j
vnoremap gk k
vnoremap gj j

" <Tab>t でタブ(tab)作成
nnoremap <Tab>t :tabe<CR>
" <Tab>n で右/次(next)のタブに移動
nnoremap <Tab>n :tabnext<CR>
" <Tab>p で左/前(previous)のタブに移動
nnoremap <Tab>p :tabprevious<CR>
" <Tab>l で現在のタブを右に移動
nnoremap <Tab>l :+tabmove<CR>
" <Tab>h で現在のタブを左に移動
nnoremap <Tab>h :-tabmove<CR>
