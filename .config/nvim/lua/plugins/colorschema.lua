-- Configuración de temas de color para Neovim
return {
  -- Configuración base de LazyVim
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vim-moonfly-colors", -- Establece CitrusZest como el tema predeterminado
    },
  },

  -- Configuración del tema CitrusZest
  {
    "zootedb0t/citruszest.nvim", -- Plugin del tema CitrusZest
    lazy     = false,            -- false = cargar durante el inicio de Neovim
    priority = 1000,             -- Alta prioridad para cargar antes que otros temas
    opts     = {
      -- Opciones generales del tema
      option = {
        transparent = true,  -- Fondo transparente (utiliza el color del terminal)
        bold        = false, -- Desactiva el texto en negrita por defecto
        italic      = true,  -- Activa el texto en cursiva
      },
      -- Personalizaciones específicas de estilos
      style = {
        -- Personaliza el estilo de las constantes
        Constant = {
          fg = "#FFFFFF", -- Color blanco para las constantes
          bold = true,    -- Las constantes sí aparecerán en negrita
        },
      },
    },
  },
  {
    'bluz71/vim-moonfly-colors',
    name = 'moonfly',
    lazy = false,
    priority = 1000,
    config = function()
      -- Activar modo transparente de moonfly
      vim.g.moonflyTransparent = true
      vim.cmd.colorscheme('moonfly')
    end,
  }

}
