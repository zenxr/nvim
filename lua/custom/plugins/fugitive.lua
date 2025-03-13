return {
  "tpope/vim-fugitive",
  lazy = false,
  dependencies = {
    "tpope/vim-rhubarb",
    "shumphrey/fugitive-gitlab.vim",
  },
  keys = {
    { '<leader>gg', '<cmd>G<cr>', desc = 'Fugitive' },
    { '<leader>gl', '<cmd>diffget //2<CR>', desc='Diff get left (buf2)'},
    { '<leader>gr', '<cmd>diffget //3<CR>', desc='Diff get right (buf3)'}
  }
}

-- vim.keymap.set('n', '<leader>gg', '<cmd>G<cr>', { desc = 'Fugitive' })
-- vim.keymap.set('n', '<leader>gl', '<cmd>diffget //2<CR>', { noremap = true , desc = 'Diff get left (buf2)'})
-- vim.keymap.set('n', '<leader>gr', '<cmd>diffget //3<CR>', { noremap = true , desc = 'Diff get right (buf3)'})

