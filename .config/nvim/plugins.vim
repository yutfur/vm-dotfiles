" -------------------------------------------------------------------------------------------
" プラグイン vim-plug
" -------------------------------------------------------------------------------------------

" 素の機能で遜色なく代替できるならそのプラグインは削除する
" よく使うプラグインだけ入れる

" vim-plug の自動インストール
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ------------------ vim-plug プラグインリスト ------------------ "

" https://github.com/junegunn/vim-plug/wiki/tutorial
" :echo stdpath('data')
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '$HOME/.vim/plugged')

" LSP プラグインの読み込み
" source $HOME/vm-dotfiles/nvim/lsp/coc.vim

" Markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
" 構文設定
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
" 箇条書きを自動で追加しない
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
" テキストを隠さずに通常通り表示する
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_conceal_code_blocks = 0

" Markdown のプレビュー表示
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" キーバインド
nnoremap <leader>mp <Plug>MarkdownPreviewToggle

" ファジーファインダー
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
" Rg(ripgrep)コマンドで検索中にプレビュー表示
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)nvi
" Filesコマンドでもプレビュー表示
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
" fzf キーバインド
let g:fzf_buffers_jump = 1
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fg :GFiles<CR>
nnoremap <silent> <Leader>fgs :GFiles?<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>fr :Rg<CR>
nnoremap <silent> <Leader>fl :Lines<CR>
nnoremap <silent> <Leader>fh :History<CR>
nnoremap <silent> <Leader>fc :Commands<CR>

" ファイラー
Plug 'preservim/nerdtree'
" <leader>tr でnerdtree表示(トグル)
nmap <leader>tr <plug>NERDTreeTabsToggle<CR>
" nnoremap <silent> <leader>tr :<C-u>NERDTreeToggle<CR>  vim-nerdtree-tabs を使うために上記で表示する
" 表示幅
let g:NERDTreeWinSize=35
" ブックマークを表示
let g:NERDTreeShowBookmarks=1
" 選択したファイルノードを s で横分割して下側に開く
let g:NERDTreeMapOpenSplit='s'
" 選択したファイルノードを v で縦分割して右側に開く
let g:NERDTreeMapOpenVSplit='v'
" 隠しファイルを表示
let g:NERDTreeShowHidden=1
" 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる
augroup vimrc_nerdtree
  autocmd!
  autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
" nerdtree 上にフォーカスがある場合に vim-tmux-navigator のキーバインドが効かないケースの修正
let g:NERDTreeMapJumpPrevSibling=""
let g:NERDTreeMapJumpNextSibling=""
" ファイルを開いたらNERDTreeを閉じる
" let g:NERDTreeQuitOnOpen=1
" デフォルトでツリーを表示させる(ファイルを直接開いた場合は表示しない、タブプラグインでない)
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" nerdtree で選択中のノード以下のファイルを fzf や grep(ripgrep) で検索 (https://blog.ottijp.com/2021/02/27/nerdtree-fzf/)
function! NERDTreeFindFile(node)
  if a:node.path.isDirectory == 1
    let path = a:node.path.str()
  else
    let path = a:node.path.getDir().str()
  endif
  echo path
  " NERDTreeClose
  call fzf#vim#files(path)
endfunction

function! NERDTreeGrepFile(node)
  if a:node.path.isDirectory == 1
    let path = a:node.path.str()
  else
    let path = a:node.path.getDir().str()
  endif
  " NERDTreeClose
  call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case \"\" ".shellescape(path), 1, fzf#vim#with_preview())
endfunction

augroup nerdtree
  autocmd!
  " zf で fzf 検索
  autocmd VimEnter * call NERDTreeAddKeyMap({
        \ 'key': 'zf',
        \ 'callback': 'NERDTreeFindFile',
        \ 'quickhelpText': 'find file under current node',
        \ 'scope': 'Node' })
  " zg で grep(ripgrep) 検索
  autocmd VimEnter * call NERDTreeAddKeyMap({
        \ 'key': 'zg',
        \ 'callback': 'NERDTreeGrepFile',
        \ 'quickhelpText': 'grep files under current node',
        \ 'scope': 'Node' })
augroup END

" タブ間で NERDTree のツリーを同期させる (https://wonderwall.hatenablog.com/entry/2016/04/07/232313)
Plug 'jistr/vim-nerdtree-tabs'

" NERDTree のツリー表示のシンタックスハイライト
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" ラグ防止
let g:NERDTreeLimitedSyntax = 1

" Git コマンド (ステータスラインにブランチ名を表示させる用、Git コマンドは内蔵ターミナルや分割したペイン上で入力すればいい)
Plug 'tpope/vim-fugitive'
set statusline+=%{fugitive#statusline()}

" Git 差分表示
Plug 'airblade/vim-gitgutter'
" 目印行を常に表示する
if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif
" キーバインド
" <leader>hp でプレビュー、<Leader>hs でステージング、<leader>hu でUndo
nnoremap <silent> <Leader>hj :GitGutterNextHunk<CR>
nnoremap <silent> <Leader>hk :GitGutterPrevHunk<CR>
nnoremap <silent> <leader>hf :GitGutterFold<CR> " 差分のみ表示(トグル)

" ステータスラインのカスタマイズ
Plug 'itchyny/lightline.vim'
" モード非表示
set noshowmode
" 曖昧幅文字の文字幅設定 (デフォルトは single 、double だと lightline.vim の表示が崩れる)
" https://www.soum.co.jp/misc/vim-no-susume/12/#id4
" set ambiwidth=double
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

" インデントガイドの表示
Plug 'Yggdroot/indentLine'
" ラインカラーをカラースキーム基準にする
let g:indentLine_setColors = 0
" ラインに使う文字の設定
let g:indentLine_char = '|'
" テキストを隠さずに通常通り表示する
let g:indentLine_conceallevel = 0

" ペア記号補完 (https://github.com/jiangmiao/auto-pairs 柔軟な操作が可能)
" lexima.vim, delimitMate というのも
Plug 'jiangmiao/auto-pairs'
" キーバインド (インサートモード中)
let g:AutoPairsShortcutFastWrap = '<C-z>w'
let g:AutoPairsShortcutJump = '<C-z>j'
let g:AutoPairsShortcutToggle = '<C-z>t'

" スムーズスクロール
Plug 'yuttie/comfortable-motion.vim'
let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 2.0
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(100)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-100)<CR>

" 置換のプレビュー表示
" far.vim, vim-subversive, vim-easy-replace, vim-over などもある
Plug 'markonm/traces.vim'
" <leader>rs で一括置換コマンド (https://deris.hatenablog.jp/entry/2014/05/20/235807)
nnoremap <leader>rs :%s///g<Left><Left><Left>
" 選択範囲内での一括置換
vnoremap rs :s///g<Left><Left><Left>
" <leader>rS で選択した文字列を一括置換する (一括置換したい文字列をヤンクしてから rs で置換する際に貼り付けてもいい)
vnoremap <leader>rS "hy:%s/<C-r>h//g<left><left><left>

" レジスタ一覧表示
" ノーマルモードで " または @ 、挿入モードで <CTRL-R> を押すとサイドバーにレジスタの内容が表示される。それ以降のキー操作で自動的にサイドバーが閉じられる。
Plug 'junegunn/vim-peekaboo'
let g:peekaboo_window = 'split botright new'

" 日本語ヘルプ
Plug 'vim-jp/vimdoc-ja'
set helplang=ja,en

" 禅モード (補助的なプラグインとして limelight.vim というのもある)
" Plug 'junegunn/goyo.vim'
" nnoremap <silent> <leader>ze :Goyo 120x100<CR>
" nnoremap <silent> <leader>zef :Goyo!<CR>

" バッファ操作

" タブ強化
" vim-xtabline

" サラウンド系 (repeat.vim必要かも)
" vim-operator-surround(replace vim-surround), vim-sandwich

call plug#end()

" ------------------ vim-plug プラグインリスト ------------------ "

