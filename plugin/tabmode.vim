if exists('g:loaded_tabmode')
	finish
endif
let g:loaded_tabmode = 1

nnoremap <silent> <unique> <Plug>(TabmodeEnter) <Cmd>lua require('tabmode'):enter()<CR>
nmap <silent> <unique> <leader><Tab> <Plug>(TabmodeEnter)

if !exists(':TabmodeEnter')
	command! TabmodeEnter lua require('tabmode'):enter()
endif
