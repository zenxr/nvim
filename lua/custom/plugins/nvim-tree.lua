local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5

return {
  "nvim-tree/nvim-tree.lua",
  cmd = "NvimTree",
  keys = {
    { "<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
  },
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = {
    update_focused_file = {
      enable = true
    },
    filters = {
      dotfiles = true,
    },
    -- re-enabled netrw, against plugin advice
    -- because i like `gx` to open links
    -- disable_netrw = true,
    -- 
    -- here down can safely be removed, just fancy floating file tree
    view = {
      float = {
        enable = true,
        open_win_config = function()
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * WIDTH_RATIO
          local window_h = screen_h * HEIGHT_RATIO
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = (screen_w - window_w) / 2
          local center_y = ((vim.opt.lines:get() - window_h) / 2)
              - vim.opt.cmdheight:get()
          return {
            border = 'rounded',
            relative = 'editor',
            row = center_y,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
      width = function()
        return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
      end,
    },

  }
}
