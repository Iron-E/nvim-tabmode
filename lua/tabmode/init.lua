--[[
	/*
	 * IMPORTS
	 */
--]]

local contains     = vim.tbl_contains
local api          = vim.api
local nvim_command = api.nvim_command

--[[
	/*
	 * MODULE
	 */
--]]

local _combos = {
	['%'] = function() nvim_command('$tabmove') end,
	[')'] = function() nvim_command('0tabmove') end,
	['?'] = function() nvim_command('help tabmode-usage') end,
	['a'] = function() nvim_command('tabnew')   end,
	['A'] = function() nvim_command('$tabnew')  end,
	['d'] = function() nvim_command('tabclose') end,
	['i'] = function() nvim_command('-tabnew')  end,
	['I'] = function() nvim_command('0tabnew')  end,
	['s'] = function() api.nvim_call_function('execute', {{
		'tabnew', 'tabprevious', 'tabclose'
	}}) end,
}

local function to_char(val) return api.nvim_eval('"\\'..val..'"') end

local _go_to_beginning    = {'^', '0', to_char('<Home>'),   to_char('<Up>')}
local _shift_to_beginning = {     ')', to_char('<S-Home>'), to_char('<S-Up>')}

local _go_to_end    = {'$', to_char('<End>'),   to_char('<Down>')}
local _shift_to_end = {'%', to_char('<S-End>'), to_char('<S-Down>')}

local _go_to_left = {'b', 'j', 'h', to_char('<Left>'),   to_char('<PageUp>')}
local _shift_left = {'B', 'J', 'H', to_char('<S-Left>'), to_char('<S-PageUp>')}

local _go_to_right = {'w', 'k', 'l', to_char('<Right>'),   to_char('<PageDown>')}
local _shift_right = {'W', 'K', 'L', to_char('<S-Right>'), to_char('<S-PageDown>')}

--[[
	/*
	 * MODE "TABS"
	 */
--]]

local function _modeInstruction()
	-- Get the raw character value of the input.
	local uinput = api.nvim_get_var('tabsModeInput')
	-- If `getchar()` reported a number, convert it back to a character.
	uinput = (type(uinput) == 'number') and string.char(uinput) or uinput

	-- Determine what to do with the input.
	    if contains(_go_to_beginning,    uinput) then nvim_command('tabfirst')
	elseif contains(_shift_to_beginning, uinput) then nvim_command('0tabmove')

	elseif contains(_go_to_end,          uinput) then nvim_command('tablast')
	elseif contains(_shift_to_end,       uinput) then nvim_command('$tabmove')

	elseif contains(_go_to_left,         uinput) then nvim_command('tabprevious')
	elseif contains(_shift_left,         uinput) then nvim_command('-tabmove')

	elseif contains(_go_to_right,        uinput) then nvim_command('tabnext')
	elseif contains(_shift_right,        uinput) then nvim_command('+tabmove')

	elseif _combos[uinput]                       then _combos[uinput]()
	end
end

--[[
	/*
	 * PUBLICIZE MODULE
	 */
--]]

return require('libmodal').Mode.new('TABS', _modeInstruction)
