# Description

`nvim-tabmode` is a plugin that provides a new mode in Neo/vim for managing tabs.

Although it is recommended that splits and buffers are used over tabs when possible, there _are_ scenarios when tabs are necessary. This plugin hopes to make that easier.

## Requirements

* Neovim 0.7
* [nvim-libmodal](https://github.com/Iron-E/nvim-libmodal)
* [vim-tabmode](https://github.com/Iron-E/vim-tabmode) is __NOT__ installed.

## Installation

Either use `packadd` or any package manager.

### Examples

* [dein.vim](https://github.com/Shougo/dein.vim):
	* Add `call dein#add('https://github.com/Iron-E/nvim-tabmode')` to `~/.vimrc`
	* `:call dein#install()`
* [NeoBundle](https://github.com/Shougo/neobundle.vim):
	* Add `NeoBundle 'https://github.com/Iron-E/nvim-tabmode'` to `~/.vimrc`
	* Re-open vim or execute `:source ~/.vimrc`
* [vim-plug](https://github.com/junegunn/vim-plug):
	* Add `Plug 'https://github.com/Iron-E/nvim-tabmode'` to `~/.vimrc`
	* `:PlugInstall` or `$ vim +PlugInstall +qall`
* [Vundle](https://github.com/gmarik/vundle):
	* Add `Plugin 'https://github.com/Iron-E/nvim-tabmode'` to `~/.vimrc`
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

## Documentation

```vim
:help tabmode
```

The actual document for help is in [tabmode.txt](doc/win.txt).
