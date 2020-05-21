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
	['$'] = function() nvim_command('tablast')  end,
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

local _go_to_beginning = {'^', '0'}
local _move_left       = {'b', 'j', 'h', "<Left>"}
local _move_right      = {'w', 'k', 'l', "<Right>"}
local _shift_left      = {'B', 'J', 'H', "<S-Left>"}
local _shift_right     = {'W', 'K', 'L', "<S-Right>"}

--[[
	/*
	 * MODE "TABS"
	 */
--]]

local function _modeInstruction()
	-- local uinput = string.char(vim.api.nvim_get_var('tabsModeInput'))
	local uinput = string.char(api.nvim_get_var('tabsModeInput'))

	    if contains(_go_to_beginning , uinput) then nvim_command('tabfirst'   )
	elseif contains(_move_left       , uinput) then nvim_command('tabprevious')
	elseif contains(_shift_left      , uinput) then nvim_command('-tabmove'   )
	elseif contains(_move_right      , uinput) then nvim_command('tabnext'    )
	elseif contains(_shift_right     , uinput) then nvim_command('+tabmove'   )
	elseif _combos[uinput]                      then _combos[uinput]()                end
end

--[[
	/*
	 * PUBLICIZE MODULE
	 */
--]]

return require('libmodal').Mode.new('TABS', _modeInstruction)
