-- [[ Setting options ]]
-- See `:help vim.o`

-- The wildmode setting allows you to customize the way that Vim handles
-- tab-completion at the command prompt.
-- This is somewhat close to bash
vim.opt.wildmode = "list:longest,list:full"

-- netrw opens BROWSER rather than system default
vim.g.netrw_browsex_viewer = os.getenv("BROWSER") or "chromium"
-- disable netrw file browser for nvim-tree
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
-- new splits default to right & bottom
vim.opt.splitbelow = true
vim.opt.splitright = true
-- maintain 8 lines around buffer at all times
vim.opt.scrolloff = 8

-- Useful for showing unwanted whitespace chars
-- vim.opt.listchars = {
--   eol = '⏎',
--   tab = '␉·',
--   trail = '␠',
--   nbsp = '⎵',
-- }

-- line wrap is for suckers, don't make long lines
vim.opt.wrap = false

-- maybe todo? keep block selected when indenting
-- alternative: learn to use `.`, dummy
-- :vnoremap < <gv
-- :vnoremap > >gv

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
-- Shows even if only one completion, and no select by default
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.opt.colorcolumn = "80"
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
-- vim.opt.smartindent = true
-- vim.opt.smarttab = true
vim.opt.textwidth = 80
