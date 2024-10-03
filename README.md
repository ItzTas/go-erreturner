# go-erreturner.nvim

Are you tired of having to write if err != nil every time you want to do error checking in golang? well fear not my friend this plugin uses neovim treesitter to analise
the function signature and return the zero values of the return types of given function

## Installation

### Using lazy

```lua
{
    "ItzTas/go-erreturner.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
}
```

## Setup

```lua
require("go-erreturner").setup({
    error_variable_name = "err",
})
```

## Usage

This is a example of how to use it

```lua
local err_returner = require("go-erreturner")

vim.keymap.set("n", "<leader>er", err_returner.return_err)

vim.keymap.set("n", "<leader>el", err_returner.println_err)

vim.keymap.set("n", "<leader>en", err_returner.return_new_err)
```
