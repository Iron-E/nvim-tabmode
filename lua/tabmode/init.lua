--[[
	/*
	 * IMPORTS
	 */
--]]

local _contains = vim.tbl_contains
local _api = vim.api

--[[
	/*
	 * MODULE
	 */
--]]

local tabmode = {}

local _combos = {
	['$'] = function() _api.nvim_command('tablast')  end,
	['%'] = function() _api.nvim_command('$tabmove') end,
	[')'] = function() _api.nvim_command('0tabmove') end,
	['?'] = function() _api.nvim_command('help tabmode-usage') end,
	['a'] = function() _api.nvim_command('tabnew')   end,
	['A'] = function() _api.nvim_command('$tabnew')  end,
	['d'] = function() _api.nvim_command('tabclose') end,
	['i'] = function() _api.nvim_command('-tabnew')  end,
	['I'] = function() _api.nvim_command('0tabnew')  end,
	['s'] = function() _api.nvim_call_function('execute', {{
		'tabnew', 'tabprevious', 'tabclose'
	}}) end,
}
local _go_to_beginning = {'^', '0'}
local _move_left = {'b', 'j', 'h', "<Left>"}
local _move_right = {'w', 'k', 'l', "<Right>"}
local _shift_left = {'B', 'J', 'H', "<S-Left>"}
local _shift_right = {'W', 'K', 'L', "<S-Right>"}

--[[
	/*
	 * MODE "TABS"
	 */
--]]

function tabmode._callback()
	-- local uinput = string.char(vim.api.nvim_get_var('tabsModeInput'))
	local uinput = string.char(vim.api.nvim_get_var('tabsModeInput'))

	    if _contains(_go_to_beginning , uinput) then _api.nvim_command('tabfirst'   )
	elseif _contains(_move_left       , uinput) then _api.nvim_command('tabprevious')
	elseif _contains(_shift_left      , uinput) then _api.nvim_command('-tabmove'   )
	elseif _contains(_move_right      , uinput) then _api.nvim_command('tabnext'    )
	elseif _contains(_shift_right     , uinput) then _api.nvim_command('+tabmove'   )
	elseif _combos[uinput]                      then _combos[uinput]()                end
end

function tabmode.enter()
	--[[ NOTE:
		* If you are looking to this as an example: directly referencing 'src/' isn't necessary.
	      I am only doing it because I know the exact paths.
		* You can simply use `print(require('libmodal'))` to see all of the functions
		  intended for use by users.
		* If you wish to dig into the 'src/' folder, you can attempt to gain finer control
		  over mode creation by extending this plugin yourself, as I have provided public
		  access to many of the functions.
	]]
	require('libmodal/src/mode').enter('TABS', tabmode._callback)
end

--[[
	/*
	 * PUBLICIZE MODULE
	 */
--]]

return tabmode
