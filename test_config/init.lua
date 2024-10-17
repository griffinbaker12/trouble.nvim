local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Add the current directory to the runtimepath
vim.opt.rtp:prepend(".")

require("lazy").setup({
  -- Local path to your Trouble development directory
  { dir = ".", name = "trouble.nvim" },

  -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },

  -- Add any other plugins you need for development/testing
})

-- Basic Neovim settings
vim.opt.number = true
vim.opt.relativenumber = true

-- Set leader key
vim.g.mapleader = " "

-- Setup Trouble
require("trouble").setup({
  -- Your trouble configuration here
})

-- Setup keymaps
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xn", function()
  require("trouble").next_file({ skip_groups = true, jump = true })
end, { desc = "Next file in Trouble" })

-- Setup LSP
require("mason").setup()
require("mason-lspconfig").setup()

local lspconfig = require("lspconfig")

-- Setup lua_ls for Lua files
lspconfig.lua_ls.setup({})

-- Add configurations for other language servers as needed
