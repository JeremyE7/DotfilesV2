return {
  "L3MON4D3/LuaSnip",
  config = function()
    -- Cargar los snippets personalizados
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

    -- Extender los snippets de JavaScript a TypeScript y TypeScript React
    require("luasnip").filetype_extend("typescript", { "javascript" })
    require("luasnip").filetype_extend("typescriptreact", { "javascript" })
  end,
}
