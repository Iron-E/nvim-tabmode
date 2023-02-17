--- The keymaps for this mode
local MODE_KEYMAPS =
{
	['$'] = 'tablast',
	['%'] = '$tabmove',
	[')'] = '0tabmove',
	['0'] = 'tabfirst',
	['?'] = 'help tabmode-usage',
	['a'] = 'tabnew',
	['A'] = '$tabnew',
	['b'] = 'tabprevious',
	['B'] = '-tabmove',
	['d'] = 'tabclose',
	['i'] = '-tabnew',
	['I'] = '0tabnew',
	['s'] = function() vim.api.nvim_command 'tabnew | tabprevious | tabclose' end,
	['t'] = function()
		vim.ui.input(
			{completion = 'dir', prompt = 'Select new `tcd`: '},
			function(dir)
				if dir then
					vim.api.nvim_command('tcd '.. dir)
				end
			end
		)
	end,
	['w'] = 'tabnext',
	['W'] = '+tabmove',
}

--- create a link to some existing mapping
--- @param parent string
--- @param children string[]
local function inherit(parent, children)
	for _, child in ipairs(children) do
		MODE_KEYMAPS[child] = MODE_KEYMAPS[parent]
	end
end

--- Turn some special character value into a character code.
--- @param val string
--- @return string termcodes_replaced
local function tochar(val)
	return vim.api.nvim_replace_termcodes(val, true, true, true)
end

inherit('0', {'^' , tochar '<Home>', tochar '<Up>'})
inherit(')', {tochar '<S-Home>', tochar '<S-Up>'})
inherit('$', {tochar '<End>', tochar '<Down>'})
inherit('%', {tochar '<S-End>' , tochar '<S-Down>'})
inherit('b', {'j', 'h', tochar '<Left>', tochar '<PageUp>'})
inherit('B', {'J', 'H', tochar '<S-Left>', tochar '<S-PageUp>'})
inherit('w', {'k', 'l', tochar '<Right>', tochar '<PageDown>'})
inherit('W', {'K', 'L', tochar '<S-Right>', tochar '<S-PageDown>'})

--- @type boolean|nil
--- whether the previous `setup` call was done automatically by the `plugin` folder
local prev_setup_auto

--[[/* MODULE */]]

--- @class bufmode.options
--- @field auto boolean whether the `setup` call was performed by the `plugin/bufmode.lua` file
--- @field enter_mapping false|string custom binding to enter buffers mode
--- @field keymaps? {[string]: fun()|string} custom key bindings to apply
local DEFAULT_OPTS = {auto = false, enter_mapping = '<leader><tab>', keymaps = nil}

--- @class bufmode
local tabmode = {}

--- @param opts? bufmode.options
function tabmode.setup(opts)
	--- @type bufmode.options
	opts = opts and vim.tbl_extend('keep', opts, DEFAULT_OPTS) or vim.deepcopy(DEFAULT_OPTS)

	-- if a setup was already run, don't automatically run it again.
	if opts.auto and prev_setup_auto ~= nil then
		return
	end

	-- add user mappings
	local keymaps = MODE_KEYMAPS
	if vim.g.bufmode_mappings then
		keymaps = vim.tbl_extend('force', keymaps, vim.g.bufmode_mappings)
	elseif opts.keymaps then
		keymaps = vim.tbl_extend('force', keymaps, opts.keymaps)
	end

	if prev_setup_auto == true
		and opts.enter_mapping ~= DEFAULT_OPTS.enter_mapping
		and vim.fn.maparg(DEFAULT_OPTS.enter_mapping):match 'bufmode'
	then
		vim.api.nvim_del_keymap('n', DEFAULT_OPTS.enter_mapping)
	end

	--- the description for all keymaps
	local DESC = 'Enter buffer mode'

	--- enter the buffer mode
	local function mode()
		require('libmodal').mode.enter('TABS', keymaps)
	end

	-- setup `enter_mapping`, unless it was automatically setup and there's no override
	if opts.enter_mapping ~= false and (
		(opts.auto and vim.fn.maparg(opts.enter_mapping) == '')
		or (not opts.auto and not vim.deep_equal(opts, DEFAULT_OPTS))
	) then
		vim.api.nvim_set_keymap('n', opts.enter_mapping, '', {callback = mode, desc = DESC})
	end

	--- The name of the user-command which enters the buffer mode.
	local CMD_NAME = 'TabmodeEnter'

	vim.api.nvim_create_user_command(CMD_NAME, mode, {desc = DESC})

	-- first setup things
	if prev_setup_auto == nil then
		vim.api.nvim_set_keymap('n', '<Plug>(' .. CMD_NAME .. ')', '<Cmd>' .. CMD_NAME .. '<CR>', {desc = DESC})
	end

	prev_setup_auto = opts.auto
end

return tabmode
