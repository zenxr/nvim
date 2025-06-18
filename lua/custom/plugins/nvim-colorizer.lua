return {
  -- A high-performance color highlighter
  "NvChad/nvim-colorizer.lua",
  config = function(opts)
    require("colorizer").setup()
  end,
}
