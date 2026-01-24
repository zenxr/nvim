return {
  -- improved, IDE-like, bufferlines (buffer bar text)
  'akinsho/bufferline.nvim',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local highlights = require 'rose-pine.plugins.bufferline'
    require('bufferline').setup { highlights = highlights }
  end,
}
