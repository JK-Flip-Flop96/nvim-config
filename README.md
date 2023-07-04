## WARNING: This config is broken as shit, new one in the works

# NeoVim Configuration Files

A full fat Nvim configuration with nothing optimised in the slightest. Lots of stuff to click on.
shoddyy metre meter sulphur sulfur civilisationd 


## Table of Contents

* [Files](#files)
* [Plugins](#plugins)
* [Known Issues](#Known Issues)

## Files

```
.
├── lua
│  ├── configs
│  │  ├── lsp
│  │  │  ├── init.lua
│  │  │  ├── null-ls.lua
│  │  │  ├── pyright.lua
│  │  │  └── sumneko_lua.lua
│  │  ├── alpha-nvim.lua
│  │  ├── colours.lua
│  │  ├── completion.lua
│  │  ├── file-tree.lua
│  │  ├── heirline.lua
│  │  ├── indent-blankline.lua
│  │  ├── mason.lua
│  │  ├── neoscroll.lua
│  │  ├── noice.lua
│  │  ├── telescope.lua
│  │  └── treesitter.lua
│  ├── options
│  │  ├── diagnostics.lua
│  │  ├── keymap.lua
│  │  └── options.lua
│  └── plugins.lua
└── init.lua
```

## Plugins

[packer.nvim](https://github.com/wbthomason/packer.nvim) - Package manager for Neovim

[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Neovim Treesitter compatability

[nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua) - File Tree

[heirline.nvim](https://github.com/rebelot/heirline.nvim) - An endlessly customisable statusline plugin, also used in this config to style both Neovim's winbar and bufferline

[nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) - Icons

[alpha-nvim](https://github.com/goolord/alpha-nvim) - A configurable start screen for Neovim

[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Gutter signs for git, also used by other plugins for git compatability

## Known Issues
* Tabline doesn't appear when opening a file from the command line.

