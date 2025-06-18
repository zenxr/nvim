-- consts
local cheatsheets_dir = '$HOME/Programming/personal/dotfiles/cheatsheets'
local obsidian_dir = '$HOME/Documents/obsidian'
local obsidian_daily_dir = '$HOME/Documents/obsidian/daily'

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
-- vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>st', require('telescope.builtin').live_grep, { desc = '[S]earch [T]ext' })
-- vim.keymap.set('n', '<leader>st', '<cmd>Telescope live_grep find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<cr>', { desc = '[S]earch [T]ext' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sg', '<cmd>Telescope live_grep_args prompt_prefix=ripgrep> <cr>',
  { desc = '[S]earch [G]rep' })
vim.keymap.set('n', '<leader>gfv', '<cmd>vsplit | lua vim.lsp.buf.definition()<cr>', { desc = 'Definition vsplit' })
vim.keymap.set('n', '<leader>gfh', '<cmd>split | lua vim.lsp.buf.definition()<cr>', { desc = 'Definition split' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sC', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>sz', require('telescope.builtin').colorscheme, { desc = '[S]earch colorschemes' })
vim.keymap.set('n', '<leader>ti', '<cmd>IBLToggle<cr>', { desc = '[T]oggle [I]BL' })

local new_daily_note = function()
  return os.date("%Y-%m-%d.md")
end
vim.keymap.set('n', '<leader>dn', '<cmd>tabnew ' .. obsidian_daily_dir .. '/' .. new_daily_note() .. '<cr>',
  { desc = 'open [D]aily [N]ote' })
vim.keymap.set('n', '<leader>sc',
  '<cmd>Telescope live_grep cwd=' .. cheatsheets_dir .. ' prompt_prefix=cheatsheets> <cr>',
  { desc = '[S]earch [C]heatsheets' })
vim.keymap.set('n', '<leader>sn', '<cmd>Telescope live_grep cwd=' .. obsidian_dir .. ' prompt_prefix=notes> <cr>',
  { desc = '[S]earch [N]otes' })
vim.keymap.set('n', '<leader>sd',
  '<cmd>Telescope live_grep cwd=' .. obsidian_daily_dir .. 'prompt_prefix=daily_notes> <cr>',
  { desc = '[S]earch [D]aily notes' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })
vim.keymap.set('n', '<C-s>', ':w<cr>', { desc = 'Save', noremap = true })

-- Buffers and tabs
vim.keymap.set('n', '<leader>tb', '<cmd>tabprevious<cr>', { desc = '[T]ab [B]ack' })
vim.keymap.set('n', '<leader>tn', '<cmd>tabnext<cr>', { desc = '[T]ab [N]ext' })
vim.keymap.set('n', '<leader>bb', '<cmd>bprev<cr>', { desc = '[B]uffer [B]ack' })
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>', { desc = '[B]uffer [N]ext' })
vim.keymap.set('n', '<leader>c', '<cmd>bd<cr>', { desc = '[C]lose buffer' })

-- Easy Align
vim.keymap.set('v', '<leader>as', '<Plug>(EasyAlign)*<Space><CR>', { desc = '[A]lign [S]pace' })
vim.keymap.set('v', '<leader>ac', '<Plug>(EasyAlign)*,<CR>', { desc = '[A]lign [C]omma' })
vim.keymap.set('v', '<leader>at', '<Plug>(EasyAlign)*<Bar><CR>', { desc = '[A]lign [T]able' })

-- CLipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = '[y]ank to sysclip', noremap = true, silent = true })
vim.keymap.set("n", '<leader>Y', [["+Y"]], { desc = '[Y]ank eol to sysclip' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"_dP', { desc = '[p]aste without yanking', noremap = true, silent = true })

-- Fugitive
-- vim.keymap.set('n', '<leader>gg', '<cmd>G<cr>', { desc = 'Fugitive' })
-- vim.keymap.set('n', '<leader>gl', '<cmd>diffget //2<CR>', { noremap = true , desc = 'Diff get left (buf2)'})
-- vim.keymap.set('n', '<leader>gr', '<cmd>diffget //3<CR>', { noremap = true , desc = 'Diff get right (buf3)'})

-- Formatting
vim.keymap.set('n', '<leader>lf', '<cmd>Format<cr>', { desc = 'Format' })

local format_selection = function()
  vim.lsp.buf.format({
    async = true,
    range = {
      ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
      ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
    }
  })
end
vim.keymap.set('v', '<leader>lf', format_selection, { desc = 'Format selection' })

-- Aerial for Treelike symbols layout
-- vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
vim.keymap.set("n", '<leader>dt', "<cmd>AerialToggle!<CR>", { desc = '[D]ocument Symbol [T]ree' })

-- Just just whichkey titles
local wk = require("which-key")
wk.add({ "<leader>s", group = "+search" })
wk.add({ "<leader>b", group = "+buffers" })
wk.add({ "<leader>j", group = "+harpoon" })
wk.add({ "<leader>bc", group = "+cloak" })

-- Cloak toggles
vim.keymap.set('n', '<leader>bct', '<cmd>CloakToggle<CR>', { desc = 'Cloak [T]oggle' })
vim.keymap.set('n', '<leader>bce', '<cmd>CloakEnable<CR>', { desc = 'Cloak [E]nable' })
vim.keymap.set('n', '<leader>bcd', '<cmd>CloakDisable<CR>', { desc = 'Cloak [D]isable' })
vim.keymap.set('n', '<leader>bcp', '<cmd>CloakPreviewLine<CR>', { desc = 'Cloak [P]review Line' })
