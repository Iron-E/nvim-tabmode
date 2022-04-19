--[[/* MODULE */]]

-- Wrap some vim command in a function.
local function cmd(command)
	return function() vim.api.nvim_command(command) end
end

-- the key combos for this mode.
local _combos = {
	['$'] = cmd 'tablast',
	['%'] = cmd '$tabmove',
	[')'] = cmd '0tabmove',
	['0'] = cmd 'tabfirst',
	['?'] = cmd 'help tabmode-usage',
	['a'] = cmd 'tabnew',
	['A'] = cmd '$tabnew',
	['b'] = cmd 'tabprevious',
	['B'] = cmd '-tabmove',
	['d'] = cmd 'tabclose',
	['i'] = cmd '-tabnew',
	['I'] = cmd '0tabnew',
	['s'] = function() vim.fn.execute {'tabnew', 'tabprevious', 'tabclose'} end,
	['t'] = function()
		vim.ui.input(
			{completion = 'dir', prompt = [[Select new `tcd`:]]},
			function(dir)
				if dir then
					vim.api.nvim_command('tcd '.. dir)
				end
			end
		)
	end,
	['w'] = cmd('tabnext'),
	['W'] = cmd('+tabmove'),
}

-- create a `new` link for some `existing` mapping
local function inherit(new, existing)
	_combos[new] = _combos[existing]
end

-- Turn some special character value into a character code.
local function char(val)
	return vim.api.nvim_replace_termcodes(val, true, true, true)
end

-- Synonyms for '0'
inherit('^', '0')
inherit(char '<Home>' , '0')
inherit(char '<Up>'   , '0')

-- Synonyms for ')'
inherit(char '<S-Home>', ')')
inherit(char '<S-Up>', ')')

-- Synonyms for '$'
inherit(char '<End>', '$')
inherit(char '<Down>', '$')

-- Synonyms for '%'
inherit(char '<S-End>', '%')
inherit(char '<S-Down>', '%')

-- Synonyms for 'b'
inherit('j', 'b')
inherit('h', 'b')
inherit(char '<Left>', 'b')
inherit(char '<PageUp>', 'b')

-- Synonyms for 'B'
inherit('J', 'B')
inherit('H', 'B')
inherit(char '<S-Left>', 'B')
inherit(char '<S-PageUp>', 'B')

-- Synonyms for 'w'
inherit('k', 'w')
inherit('l', 'w')
inherit(char '<Right>', 'w')
inherit(char '<PageDown>', 'w')

-- Synonyms for 'W'
inherit('K', 'W')
inherit('L', 'W')
inherit(char '<S-Right>', 'W')
inherit(char '<S-PageDown>', 'W')

--[[/* PUBLICIZE MODULE */]]

return function()
	require('libmodal').mode.enter('TABS', _combos)
end
