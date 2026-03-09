# Cheat.nvim

A Neovim plugin to search code snippets on [cheat.sh](https://cheat.sh/)

## Installation

Using [lazy.nvim](https://github.com/jesseduffield/lazygit)

```lua
use {
  "Theacebutler/cheat.nvim",
  config = function()
    require("cheat").setup({
      -- open the cheat window with a key, default is <leader>sc
      open = "<leader>sc",
    })
  end,
}
```

## Usage

`:Cheat` to open the cheat window with the query entered in the command line

## Contributing

Feel free to open issues and pull requests

## License

MIT License Copyright (c) 2022 [Theacebutler](https://github.com/Theacebutler)
