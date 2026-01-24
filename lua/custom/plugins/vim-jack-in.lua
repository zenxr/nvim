
return {
  {
    "radenling/vim-dispatch-neovim",
    lazy = true,
    dependencies = {"tpope/vim-dispatch"},
  },
  {
    "clojure-vim/vim-jack-in",
    ft = { "clojure", "fennel" }, -- etc
    lazy = true,
    dependencies = {"tpope/vim-dispatch", "radenling/vim-dispatch-neovim"},
  },
}
