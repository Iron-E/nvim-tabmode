if exists('g:loaded_tabmode')
	finish
endif
let g:loaded_tabmode = 1

if !hasmapto('<Plug>TabmodeEnter')
	silent! nmap <unique> <leader><Tab> <Plug>TabmodeEnter
endif

nnoremap <unique> <silent> <script> <Plug>TabmodeEnter <SID>TabmodeEnter
nnoremap <SID>TabmodeEnter :<C-u>lua require('tabmode'):enter()<CR>

if !exists(':TabmodeEnter')
	command! TabmodeEnter :call <Plug>TabmodeEnter
endif
