-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Seleccionar todo el contenido del buffer con Ctrl+A en modo normal
vim.keymap.set('n', '<C-a>', 'ggVG', { noremap = true, silent = true })
vim.keymap.set("n", "<C-A-k>", ":m .-2<CR>==", { desc = "Mover línea arriba", silent = true })
vim.keymap.set("n", "<C-A-j>", ":m .+1<CR>==", { desc = "Mover línea abajo", silent = true })

vim.keymap.set("v", "<C-A-j>", ":m '>+1<CR>gv=gv", { desc = "Mover línea abajo (visual)", silent = true })
vim.keymap.set("v", "<C-A-k>", ":m '<-2<CR>gv=gv", { desc = "Mover línea arriba (visual)", silent = true })

local function get_visual_selection()
  vim.cmd('normal! "sy') -- guarda la selección visual en el registro s
  return vim.fn.getreg("s")
end

local function get_current_word_or_selection()
  if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
    return get_visual_selection()
  else
    return vim.fn.expand("<cword>")
  end
end

-- Buscar en el buffer actual con <leader>/
vim.keymap.set({ "n", "v" }, "<leader>//", function()
  local word = get_current_word_or_selection()
  vim.cmd("let @/ = '" .. word .. "'")
  vim.cmd("set hlsearch")
end, { desc = "Buscar palabra en buffer actual" })

-- Buscar en todo el proyecto con <leader>/f
vim.keymap.set({ "n", "v" }, "<leader>/f", function()
  local word = get_current_word_or_selection()
  require("telescope.builtin").grep_string({
    search = word,
  })
end, { desc = "Buscar palabra en todo el proyecto (Telescope)" })

vim.keymap.set("n", "<leader>rw", ':%s/\\<<C-r><C-w>\\>//g<Left><Left>',
  { desc = "Reemplazar palabra en todo el buffer" })

vim.keymap.set("n", "<C-/>", function()
  local snacks = require("snacks")
  local ft     = vim.bo.filetype

  local cwd

  if ft == "minifiles" then
    local ok, mini_files = pcall(require, "mini.files")
    if ok and mini_files.get_current_path then
      cwd = mini_files.get_current_path()
    end
  else
    cwd = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h") -- carpeta del archivo actual
  end

  if not cwd or cwd == "" then
    cwd = vim.fn.getcwd() -- fallback
  end

  vim.notify("Terminal abierta en: " .. cwd, vim.log.levels.INFO, { title = "Snacks Terminal" })

  snacks.terminal.open(nil, {
    cwd = cwd,
    win = {
      size = { width = 0.8, height = 0.8 },
      position = "float",
      border = "rounded",
    },
  })
end, { desc = "Abrir terminal contextual flotante" })
