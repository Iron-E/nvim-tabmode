# Description

`nvim-tabmode` is a plugin that provides a new mode in Neo/vim for managing tabs.

Although it is recommended that splits and buffers are used over tabs when possible, there _are_ scenarios when tabs are necessary. This plugin hopes to make that easier.

## Installation

Either use `packadd` or any package manager. I recommend using [lazy.nvim](https://github.com/folke/lazy.nvim).

### Requirements

* Neovim 0.7+
* [nvim-libmodal](https://github.com/Iron-E/nvim-libmodal)
* [vim-tabmode](https://github.com/Iron-E/vim-tabmode) is __NOT__ installed.

### Examples

`lazy.nvim`:

```lua
{'Iron-E/nvim-tabmode',
  cmd = 'TabmodeEnter', -- don't load until using this command
  config = true, -- automatically call `bufmode.setup()`; not needed if you specify `opts`
  dependencies = {'Iron-E/nvim-libmodal'},
  keys = {{'<Leader><Tab>', desc = 'Enter buffer mode', mode = 'n'}}, -- don't load until pressing these keys
  -- opts = {}, (put `setup` options here, e.g. `opts = {enter_mapping = false}`
},
```

Other examples:

* [dein.vim](https://github.com/Shougo/dein.vim):
  * Add `call dein#add('https://github.com/Iron-E/nvim-bufmode')` to `~/.config/nvim/init.vim`
  * `:call dein#install()`
* [NeoBundle](https://github.com/Shougo/neobundle.vim):
  * Add `NeoBundle 'https://github.com/Iron-E/nvim-bufmode'` to `~/.config/nvim/init.vim`
  * Re-open vim or execute `:source ~/.vimrc`
* [vim-plug](https://github.com/junegunn/vim-plug):
  * Add `Plug 'https://github.com/Iron-E/nvim-bufmode'` to `~/.config/nvim/init.vim`
  * `:PlugInstall` or `$ vim +PlugInstall +qall`
* [Vundle](https://github.com/gmarik/vundle):
  * Add `Plugin 'https://github.com/Iron-E/nvim-bufmode'` to `~/.config/nvim/init.vim`
  * `:PluginInstall` or `$ vim +PluginInstall +qall`

## Usage

Enter `nvim-tabmode` with `<leader><Tab>` or `:TabmodeEnter`.

| Key         | Use                                                    |
|:-----------:|:------------------------------------------------------:|
| `<Esc>`     | Leave `tabmode`                                        |
| `?`         | Show help message                                      |
| `^`/`0`     | Go to the beginning of the tab list.                   |
| `<S-0>`     | Move the current tab to the beginning of the tab list. |
| `$`         | Go to the end of the tab list.                         |
| `%`         | Move the current tab to the end of the tab list.       |
| `b`/`j`/`h` | Tab left                                               |
| `w`/`k`/`l` | Tab right                                              |
| `a`         | Append a tab and switch to it.                         |
| `A`         | Append a tab to the end and switch to it.              |
| `i`         | Prepend a tab and switch to it.                        |
| `I`         | Prepend a tab to the beginning and switch to it.       |
| `d`         | Delete the current tab.                                |
| `s`         | Replace the current tab with a new tab.                |

See `:help tabmode-usage` for additional details.

## Configuration

To customize the plugin, set `vim.g.bufmode_mappings` before loading it, or call
`setup` after:

```vim
let g:bufmode_mappings = {
  \ '$': 'tablast',
  \ '%': '$tabmove',
  \ ')': '0tabmove',
  \ '0': 'tabfirst',
  \ '?': 'help tabmode-usage',
  \ 'a': 'tabnew',
  \ 'A': '$tabnew',
  \ 'b': 'tabprevious',
  \ 'B': '-tabmove',
  \ 'd': 'tabclose',
  \ 'i': '-tabnew',
  \ 'I': '0tabnew',
}
```
```lua
require('tabmode').setup {
  enter_mapping = '<leader><tab>', -- false to disable
  bufferline = false, -- add bufferline.nvim keymaps
  barbar = false, -- add barbar.nvim keymaps
  keymaps = { -- defaults:
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
  }
}
```
