return {
  "ThePrimeagen/harpoon",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function(opts)
    require("harpoon").setup()
    local ui = require("harpoon.ui")
    local mark = require("harpoon.mark")

    vim.keymap.set('n', '<leader>jl', function() ui.toggle_quick_menu() end, { desc = '[L]ist Harpoon'})
    vim.keymap.set('n', '<leader>jj', function() ui.nav_next() end, { desc = 'Next Harpoon'})
    vim.keymap.set('n', '<leader>jf', function() ui.nav_prev() end, { desc = 'Prev Harpoon'})
    vim.keymap.set('n', '<leader>jk', function() mark.add_file() end, { desc = 'Add Harpoon'})
  end,
}
