" nnoremap <Leader>hw :w<cr>:GhcModTypeInsert<cr>
" nnoremap <Leader>hs :w<cr>:GhcModSplitFunCase<cr>
" nnoremap <Leader>hq :w<cr>:GhcModType<cr>
" nnoremap <Leader>he :w<cr>:GhcModTypeClear<cr>

" nnoremap <Leader>hi :InteroOpen<cr>
" nnoremap <Leader>hc :InteroHide<cr>
" nnoremap <Leader>hl :InteroLoadCurrentFile<cr>
" nnoremap <Leader>hr :InteroReload<cr>
" nnoremap <Leader>hd :IntegroGoToDef

" autocmd FileType haskell nnoremap <buffer> <leader>l :call ale#cursor#ShowCursorDetail()<cr>

" " Disable haskell-vim omnifunc
" let g:haskellmode_completion_ghc = 0

" " neco-ghc
" autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
" let g:ncoghc_enable_detailed_browse = 1

" let g:hindent_on_save = 0
" au FileType haskell nnoremap <silent> <leader>ph :Hindent<CR>
" au FileType haskell nnoremap <silent> <leader>ps :Stylishsk<CR>

" au FileType haskell nnoremap <silent> <leader>ims :HsimportSymbol<CR>
" au FileType haskell nnoremap <silent> <leader>imm :HsimportModule<CR>

" let g:stylishask_on_save = 0
