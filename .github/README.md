# NvOAH

Fork of [NvChad](https://nvchad.com) for [![Neovim Minimum Version](https://img.shields.io/badge/Neovim-0.9.0-blueviolet.svg?style=flat-square&logo=Neovim&color=90E59A&logoColor=white)](https://github.com/neovim/neovim)

## Installation
- **Operating System**: I regularly use this on my work Mac and personal Windows machines. Should work for both
- **Terminal**: I use Wezterm. It supports curly and coloured underlines and runs pretty well
- **Font**: Use a nerd font. I use JetBrains Mono
- **External Dependencies**
	- **lazygit**: Used by lazygit.nvim
	- **A C compiler**: I use Zig for Windows, Mac should come with one
	- **LSP Stuff**: You probably want emmet, prettier, styled components, etc dependencies installed globally
	- I'm probably forgetting some stuff but it will usually tell you what you're missing

```cmd
# Windows
cd $HOME\AppData\Local\nvim
git clone <this repo>

# Unix-like
cd ~/.config/nvim
git clone <this repo>

# Then
nvim
```

Lazy should run automatically to install dependencies. If you have issues, you can run the Vim command to see what's going on.
```vim
:Lazy
```

If stuff is broken, try the following
- Install the latest version of NeoVim
- Run `:Lazy` to install and update plugins
- Run `:TSUpdate` to install and update Tree-Sitter plugins
- Run `:Mason` to install and update LSPs
- Delete the problematic plugin from `$HOME\AppData\Local\nvim-data\lazy` or `~/.local/share/nvim/lazy` and install again with `:Lazy`

## Wishlist
- [ ] Better diffing in lazygit
- [ ] lazynpm support
- [ ] Terminal debugging support
- [ ] Fix tab highlighting

## Plugins list
See [plugins.lua](https://github.com/noahbald/NvOAH/blob/nvoah/lua/custom/plugins.lua)

## NvChad Plugins list

- Many beautiful themes, theme toggler by our [base46 plugin](https://github.com/NvChad/base46)
- Inbuilt terminal toggling & management with [Nvterm](https://github.com/NvChad/nvterm)
- Lightweight & performant ui plugin with [NvChad UI](https://github.com/NvChad/ui) It provides statusline modules, tabufline ( tabs + buffer manager) , beautiful cheatsheets, NvChad updater, hide & unhide terminal buffers, theme switcher and much more!
- File navigation with [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
- Beautiful and configurable icons with [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
- Git diffs and more with [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) 
- NeoVim Lsp configuration with [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) and [mason.nvim](https://github.com/williamboman/mason.nvim)
- Autocompletion with [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- File searching, previewing image and text files and more with [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
- Syntax highlighting with [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- Autoclosing braces and html tags with [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- Indentlines with [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- Useful snippets with [friendly snippets](https://github.com/rafamadriz/friendly-snippets) + [LuaSnip](https://github.com/L3MON4D3/LuaSnip).
- Popup mappings keysheet [whichkey.nvim](https://github.com/folke/which-key.nvim)

