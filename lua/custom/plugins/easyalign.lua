return {
  "junegunn/vim-easy-align",
  cmd = "EasyAlign",
  lazy = false,
  ft = "md",
  config = function(_)
    vim.keymap.set('v', '<leader>as', '<Plug>(EasyAlign)*<Space><CR>', { desc = '[A]lign [S]pace' })
    vim.keymap.set('v', '<leader>ac', '<Plug>(EasyAlign)*,<CR>', { desc = '[A]lign [C]omma' })
    vim.keymap.set('v', '<leader>at', '<Plug>(EasyAlign)*<Bar><CR>', { desc = '[A]lign [T]able' })
  end
}
