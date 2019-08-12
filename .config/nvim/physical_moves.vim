nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> 0 g0
nnoremap <silent> $ g$

nnoremap <silent> gk k
nnoremap <silent> gj j
nnoremap <silent> g0 0
nnoremap <silent> g0 0

vnoremap <silent> k gk
vnoremap <silent> j gj
vnoremap <silent> 0 g0
vnoremap <silent> $ g$

vnoremap <silent> gk k
vnoremap <silent> gj j
vnoremap <silent> g0 0
vnoremap <silent> g0 0

" function! NoremapNormalCmd(key, preserve_omni, ...)
"   let cmd = ''
"   let icmd = ''
"   for x in a:000
"     let cmd .= x
"     let icmd .= "<C-\\><C-O>" . x
"   endfor
"   execute ":nnoremap <silent> " . a:key . " " . cmd
"   execute ":vnoremap <silent> " . a:key . " " . cmd
"   if a:preserve_omni
"     execute ":inoremap <silent> <expr> " . a:key . " pumvisible() ? \"" . a:key . "\" : \"" . icmd . "\""
"   else
"     execute ":inoremap <silent> " . a:key . " " . icmd
"   endif
" endfunction

" " Cursor moves by screen lines
" call NoremapNormalCmd("k", 0, "gk")
" call NoremapNormalCmd("j", 0, "gj")
" call NoremapNormalCmd("0", 0, "g<Home>")
" call NoremapNormalCmd("$", 0, "g<End>")

" call NoremapNormalCmd("<Up>", 0, "gk")
" call NoremapNormalCmd("<Down>", 0, "gj")
" call NoremapNormalCmd("<Home>", 0, "g<Home>")
" call NoremapNormalCmd("<End>", 0, "g<End>")

" call NoremapNormalCmd("gk", 0, "k")
" call NoremapNormalCmd("gj", 0, "j")
" call NoremapNormalCmd("g0", 0, "<Home>")
" call NoremapNormalCmd("g$", 0, "<End>")

" " PageUp/PageDown preserve relative cursor position
" call NoremapNormalCmd("<PageUp>", 0, "<C-U>", "<C-U>")
" call NoremapNormalCmd("<PageDown>", 0, "<C-D>", "<C-D>")
