" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" バックアップファイルの無効化 (https://github.com/neoclide/coc.nvim/issues/649)
set nobackup
set nowritebackup
" この時間の間(ミリ秒単位)入力がなければ、スワップファイルがディスクに書き込まれる (coc.nvim 推奨)
set updatetime=300
" メッセージを |ins-completion-menu| に渡さない (coc.nvim 推奨)
set shortmess+=c
" 記号列を常に表示する、そうしないと、毎回テキストがずれてしまう (診断結果が表示されたり、解決されたりする)
" 最近の vim は、signcolumn と number column を 1 つにまとめることができる
if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif
" Tab で補完切り替えをする (リスト表示も出来る、この機能を設定する前に、コマンド :verbose imap <tab> を使用して、タブが他のプラグインによってマッピングされていないことを確認する)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" la で現在のバッファに CodeAction を適用する
nmap <silent> la <Plug>(coc-codeaction)
" lD で全ての診断結果を表示、<C-j,k> で診断結果を切り替える
nnoremap <silent><nowait> lD  :<C-u>CocList diagnostics<cr>
" ld でカーソル下の定義へジャンプ、<C-o> で元のファイルへ戻る
nmap <silent> ld <Plug>(coc-definition)
" lt でカーソル下の型定義へジャンプ、<C-o> で元のファイルへ戻る (タブ切り替えをオーバーライド)
nmap <silent> lt <Plug>(coc-type-definition)
" li でカーソル下の実装へジャンプ、<C-o> で元のファイルへ戻る
nmap <silent> li <Plug>(coc-implementation)
" lr でカーソル下のシンボルの関連含めた一括リネーム
nmap <silent> lr <Plug>(coc-rename)
" lR でカーソル下のシンボルの参照を表示する
nmap <silent> lR <Plug>(coc-references)
" ls で現在のドキュメントのシンボルを検索する (vista.vimで代用できそうだが)
nnoremap <silent><nowait> ls  :<C-u>CocList outline<cr>
" lS でワークスペースのシンボルを検索する
nnoremap <silent><nowait> lS  :<C-u>CocList -I symbols<cr>
" lf で現在のバッファをフォーマットする
nmap <silent> lf <Plug>(coc-format)
" lh でカーソル下のドキュメントを開く
nnoremap <silent>lh :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" 保存時にインポートを整理する
autocmd BufWritePre *.java :call CocAction('runCommand', 'editor.action.organizeImport')
" フローティングウィンドウ/ポップアップ表示時、<C-f> と <C-b> でスクロールする
" hover のフローティングウィンドウでは動かない、今の所 <C-w>w でフローティングウィンドウ内にカーソルを入れてhjklなどでスクロールするしか(同じ操作を繰り返せばカーソル戻る)
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
" coc-pairs カッコ内改行でのカーソル位置設定
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 言語用のシンタックスハイライト・セマンティックハイライト (nvim-treesitter)
Plug 'jaxbot/semantic-highlight.vim'
" java ファイル編集時に自動起動
autocmd BufEnter *.java :SemanticHighlight

" フォーマッター・フィクサー (https://github.com/google/vim-codefmt 下の方にも設定書いてある)
" vim-autoformat, ale, efm-langserverなどもある (ale, efm-langserver はリンターとしても使える)
Plug 'google/vim-codefmt'
Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'
" 選択範囲のフォーマットは、範囲選択したらそのままコマンドラインモードに入って :'<,'>FormatLines を実行すれば良い
" フォーマットの自動適用 (下は保存時)
augroup autoformat_settings
    autocmd FileType java AutoFormatBuffer google-java-format
augroup END
autocmd BufWritePre *.java :FormatCode

" アウトライン表示とジャンプ (replacing tagbar)
Plug 'liuchengxu/vista.vim'
" 言語ごとにどの情報ソース(エグゼクティブ)からシンボルを取得するかの設定 (:echo g:vista#executives で利用可能な情報ソースを全て表示する)
let g:vista_executive_for = {
    \ 'java': 'coc',
    \ }
" トグル表示
nnoremap <silent> <leader>v :Vista!!<CR>
" シンボルを fzf で絞り込み
let g:vista_fzf_preview = ['right:50%']
nnoremap <silent> <leader>vf :Vista finder<CR>
" 編集中のファイルを閉じたら自動で閉じる (https://github.com/liuchengxu/vista.vim/issues?q=is%3Aissue+auto+close)
autocmd bufenter * if (winnr("$") == 1 && &filetype =~# 'vista') | q | endif

" プロジェクトディレクトリ内での作業時にプロジェクトルートディレクトリへ移動 (https://github.com/airblade/vim-rooter 柔軟な設定が可能)
" sync-term-cwd.vimvim-findroot, telescope-project.nvim というのも
Plug 'airblade/vim-rooter'
" ルートディレクトリの識別子設定
let g:rooter_patterns = ['=src', '=bin', '.git', ]

" ステータスラインのカスタマイズ
Plug 'itchyny/lightline.vim'
" モード非表示
set noshowmode
" set ambiwidth=double を無効化しないと lightline.vim の表示がずれる
let g:lightline = {
        \ 'colorscheme': 'ayu_dark',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'absolutepath', 'gitbranch' ],
        \             [ 'modified', 'readonly', 'bufnum' ] ],
        \   'right': [ [ 'lineinfo', 'percent' ],
        \              [ 'filetype', 'fileformat', 'fileencoding' ],
        \              [ 'method', 'cocstatus' ] ],
        \ },
        \ 'component_function': {
        \   'gitbranch': 'FugitiveHead',
        \   'cocstatus': 'coc#status',
        \   'method': 'NearestMethodOrFunction',
        \ },
        \ }

" コメントアウト・アンコメントをキーバインドで行う
" <leader>cc 現在行のコメントアウト、<leader>cm で選択行を複数行コメントアウト、<leader>cu でアンコメント、<leader>cA で行末にコメントアウトを追加する
Plug 'preservim/nerdcommenter'

" quickfix
" quickr-preview.vim, vim-qf, qfreplace

" ------------------ vim-plug プラグインリスト ------------------ "

call glaive#Install()
Glaive codefmt plugin[mappings]
" google-java-format のオプションを末尾につけて適用させることが出来る
" インデントはスペース4つ(--aosp)
Glaive codefmt google_java_executable=`expand('java -jar $HOME/dev/java/google-java-format-1.9-all-deps.jar --aosp')`

