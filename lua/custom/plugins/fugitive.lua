return {
  'tpope/vim-fugitive',
  lazy = false,
  dependencies = {
    'tpope/vim-rhubarb',
    'shumphrey/fugitive-gitlab.vim',
  },
  keys = {
    { '<leader>gg', '<cmd>G<cr>', desc = 'Fugitive' },
    -- diffupdate mirrors `d2o` and `d3o` default keymaps
    { '<leader>gl', '<cmd>diffget //2<bar>diffupdate<CR>', mode = { 'v' }, desc = 'Diff get left (buf2/target)' },
    { '<leader>gr', '<cmd>diffget //3<bar>diffupdate<CR>', mode = { 'v' }, desc = 'Diff get right (buf3/merging)' },
  },
  config = function(opts)
    -- nvim 0.11 introduced linematch
    -- for better diffs, but it breaks shit
    vim.o.diffopt = 'internal,filler,closeoff'
  end,
}
