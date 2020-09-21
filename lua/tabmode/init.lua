--[[
	/*
	 * IMPORTS
	 */
--]]

local vim  = vim
local cmd  = vim.api.nvim_command
local eval = vim.api.nvim_eval
local fn   = vim.api.nvim_call_function

--[[
	/*
	 * MODULE
	 */
--]]

-- Wrap some vim command in a function.
local function _cmd_wrap(command)
	return function() cmd(command) end
end

-- the key combos for this mode.
local _combos = {
	['$'] = _cmd_wrap('tablast'),
	['%'] = _cmd_wrap('$tabmove'),
	[')'] = _cmd_wrap('0tabmove'),
	['0'] = _cmd_wrap('tabfirst'),
	['?'] = _cmd_wrap('help tabmode-usage'),
	['a'] = _cmd_wrap('tabnew'),
	['A'] = _cmd_wrap('$tabnew'),
	['b'] = _cmd_wrap('tabprevious'),
	['B'] = _cmd_wrap('-tabmove'),
	['d'] = _cmd_wrap('tabclose'),
	['i'] = _cmd_wrap('-tabnew'),
	['I'] = _cmd_wrap('0tabnew'),
	['s'] = function()
		fn('execute', {{'tabnew', 'tabprevious', 'tabclose'}})
	end,
	['t'] = function()
		local dir = fn('input', {'Select New `tcd`: ', '', 'dir'})
		cmd('tcd '..(dir ~= '' and dir or fn('getcwd', {})))
	end,
	['w'] = _cmd_wrap('tabnext'),
	['W'] = _cmd_wrap('+tabmove'),
}

-- create a `new` link for some `existing` mapping
local function _combo_link(new, existing)
	_combos[new] = _combos[existing]
end

-- Turn some special character value into a character code.
local function _to_char(val)
	return eval('"\\'..val..'"')
end

-- Synonyms for '0'
_combo_link('^', '0')
_combo_link(_to_char('<Home>') , '0')
_combo_link(_to_char('<Up>')   , '0')

-- Synonyms for ')'
_combo_link(_to_char('<S-Home>'), ')')
_combo_link(_to_char('<S-Up>'), ')')

-- Synonyms for '$'
_combo_link(_to_char('<End>'), '$')
_combo_link(_to_char('<Down>'), '$')

-- Synonyms for '%'
_combo_link(_to_char('<S-End>'), '%')
_combo_link(_to_char('<S-Down>'), '%')

-- Synonyms for 'b'
_combo_link('j', 'b')
_combo_link('h', 'b')
_combo_link(_to_char('<Left>'), 'b')
_combo_link(_to_char('<PageUp>'), 'b')

-- Synonyms for 'B'
_combo_link('J', 'B')
_combo_link('H', 'B')
_combo_link(_to_char('<S-Left>'), 'B')
_combo_link(_to_char('<S-PageUp>'), 'B')

-- Synonyms for 'w'
_combo_link('k', 'w')
_combo_link('l', 'w')
_combo_link(_to_char('<Right>'), 'w')
_combo_link(_to_char('<PageDown>'), 'w')

-- Synonyms for 'W'
_combo_link('K', 'W')
_combo_link('L', 'W')
_combo_link(_to_char('<S-Right>'), 'W')
_combo_link(_to_char('<S-PageDown>'), 'W')

--[[
	/*
	 * PUBLICIZE MODULE
	 */
--]]

return function()
	require('libmodal').mode.enter('TABS', _combos)
end
