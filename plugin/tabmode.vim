if exists('g:loaded_tabmode')
	finish
endif
let g:loaded_tabmode = 1

nnoremap <silent> <unique> <Plug>(TabmodeEnter) <Cmd>lua require('tabmode')()<CR>
if mapcheck('<leader><Tab>') == ''
	nmap <silent> <unique> <leader><Tab> <Plug>(TabmodeEnter)
endif

if !exists(':TabmodeEnter')
	command! TabmodeEnter lua require('tabmode')()
endif
