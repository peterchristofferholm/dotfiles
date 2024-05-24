set wrap

set autoindent
set formatoptions=tcqn

inoremap <C-P> <Space><bar>><Space>

" jump to next slide/chunk/thing
nnoremap <silent><buffer> [[ :call search('^--', "bW")<CR>
nnoremap <silent><buffer> ]] :call search('^--', "W")<CR>


augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END
