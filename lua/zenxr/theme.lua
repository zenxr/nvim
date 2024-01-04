require('catppuccin').setup({
  transparent_background = true,
  styles = {
    comments = { "italic" },
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true
  }
})
vim.cmd.colorscheme 'catppuccin'
