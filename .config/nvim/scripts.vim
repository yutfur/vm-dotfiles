" -------------------------------------------------------------------------------------------
" スクリプト
" -------------------------------------------------------------------------------------------

" 自動コメントアウトOFFに
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" ペースト時、自動インデント無効化
" https://qiita.com/ahiruman5/items/4f3c845500c172a02935
" https://qiita.com/ryoff/items/ad34584e41425362453e
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" 最後のカーソル位置を復元
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

" HTML/XML閉じタグ自動補完 (プラグインでやったほうがいいかも)
" https://github.com/alvan/vim-closetag
" augroup MyXML
"   autocmd!
"   autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
"   autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
" augroup END

