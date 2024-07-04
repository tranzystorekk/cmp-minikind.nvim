# cmp-minikind

## About

Add icons to your `nvim-cmp` LSP completions!

## Dependencies

- [mini.icons](https://github.com/echasnovski/mini.icons)

## Installation

Make sure `mini.icons` is enabled in your config.

### Using lazy.nvim

```lua
{
  "hrsh7th/nvim-cmp",
  dependencies = {
    "tranzystorekk/cmp-minikind.nvim",
  },

  config = function()
    require("cmp"). setup {
      formatting = {
        format = require("cmp-minikind").cmp_format(),
      }
    }
  end
}
```

## Default config

```lua
{
  -- Ordered components to be output as the displayed LSP kind:
  --
  -- "text": kind name, e.g. "Method"
  -- "symbol": kind icon supplied by mini.icons, e.g. ""
  components = { "symbol", "text" },

  -- String to separate the components with
  separator = " ",
}
```
