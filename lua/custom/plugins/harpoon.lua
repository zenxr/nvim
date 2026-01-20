return {
  -- similar to marks, harpoon allows marking frequently visited files for quickly accessing them later
  "ThePrimeagen/harpoon",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function(opts)
    require("harpoon").setup()
    local ui = require("harpoon.ui")
    local mark = require("harpoon.mark")

    vim.keymap.set('n', '<leader>hl', function() ui.toggle_quick_menu() end, { desc = '[L]ist Harpoon'})
    vim.keymap.set('n', '<leader>hh', function() ui.nav_next() end, { desc = 'Next Harpoon'})
    vim.keymap.set('n', '<leader>hu', function() ui.nav_prev() end, { desc = 'Prev Harpoon'})
    vim.keymap.set('n', '<leader>ht', function() mark.add_file() end, { desc = 'Add Harpoon'})
  end,
}
