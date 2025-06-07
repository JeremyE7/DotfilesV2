-- ~/.config/nvim/lua/config/colorscheme.lua

vim.cmd.colorscheme("citruszest")
require("citruszest").setup({
  option = {
    transparent = false,
    bold        = false,
    italic      = true,
  },
  style = {
    Constant = { fg = "#FFFFFF", bold = true },
  },
})
