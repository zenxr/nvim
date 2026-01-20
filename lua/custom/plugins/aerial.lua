return {
  -- provides an "aerial preview" of documents, similar to document symbols
  'stevearc/aerial.nvim',
  lazy = false,
  opts = {},
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  init = function()
    vim.keymap.set("n", '<leader>dt', "<cmd>AerialToggle!<CR>", { desc = '[D]ocument Symbol [T]ree' })
  end
}
