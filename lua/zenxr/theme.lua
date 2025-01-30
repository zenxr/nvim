-- CATPUCCIN
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
-- CATPUCCIN


-- ROSE-PINE
-- require('rose-pine').setup(
--   {
--     variant = "auto",      -- auto, main, moon, or dawn
--     dark_variant = "main", -- main, moon, or dawn
--     dim_inactive_windows = false,
--     extend_background_behind_borders = true,
--     disable_background = true,
--
--     enable = {
--       terminal = true,
--       legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
--       migrations = true,        -- Handle deprecated options automatically
--     },
--
--     styles = {
--       bold = true,
--       italic = true,
--       transparency = false,
--     },
--     groups = {
--       border = "muted",
--       link = "iris",
--       panel = "surface",
--
--       error = "love",
--       hint = "iris",
--       info = "foam",
--       note = "pine",
--       todo = "rose",
--       warn = "gold",
--
--       git_add = "foam",
--       git_change = "rose",
--       git_delete = "love",
--       git_dirty = "rose",
--       git_ignore = "muted",
--       git_merge = "iris",
--       git_rename = "pine",
--       git_stage = "iris",
--       git_text = "rose",
--       git_untracked = "subtle",
--
--       h1 = "iris",
--       h2 = "foam",
--       h3 = "rose",
--       h4 = "gold",
--       h5 = "pine",
--       h6 = "foam",
--     },
--     highlight_groups = {
--         Comment = { fg = "foam" },
--         VertSplit = { fg = "muted", bg = "muted" },
--     },
--   }
-- )
-- vim.cmd.colorscheme 'rose-pine'

-- rose-pine specific, 'cause randomly stolen from primagen's config
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })


-- ROSE-PINE

-- KANAGAWA
-- require('kanagawa').setup({
--     compile = false,             -- enable compiling the colorscheme
--     undercurl = true,            -- enable undercurls
--     commentStyle = { italic = true },
--     functionStyle = {},
--     keywordStyle = { italic = true},
--     statementStyle = { bold = true },
--     typeStyle = {},
--     transparent = false,         -- do not set background color
--     dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
--     terminalColors = true,       -- define vim.g.terminal_color_{0,17}
--     colors = {                   -- add/modify theme and palette colors
--         palette = {},
--         theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
--     },
--     overrides = function(colors) -- add/modify highlights
--         return {}
--     end,
--     theme = "wave",              -- Load "wave" theme when 'background' option is not set
--     background = {               -- map the value of 'background' option to a theme
--         dark = "wave",           -- try "dragon" !
--         light = "lotus"
--     },
-- })
-- vim.cmd("colorscheme kanagawa")
-- KANAGAWA

-- TOKYO NIGHT
-- require("tokyonight").setup({
--   -- use the night style
--   style = "night",
--   transparent = true,
--   -- disable italic for functions
--   -- styles = {
--   --   functions = {}
--   -- },
--   -- sidebars = { "qf", "vista_kind", "terminal", "packer" },
--   -- Change the "hint" color to the "orange" color, and make the "error" color bright red
--   -- on_colors = function(colors)
--   --   colors.hint = colors.orange
--   --   colors.error = "#ff0000"
--   -- end
-- })
-- vim.cmd("colorscheme tokyonight-night")
-- -- TOKYO NIGHT
