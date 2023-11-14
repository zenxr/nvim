-- consts
local cheatsheets_dir = '$HOME/Programming/personal/dotfiles/cheatsheets'
local obsidian_dir = '$HOME/Documents/obsidian'
local obsidian_daily_dir = '$HOME/Documents/obsidian/daily'

--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/


  And then you can explore or search through `:help lua-guide`
  - https://neovim.io/doc/user/lua-guide.html


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
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

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'shumphrey/fugitive-gitlab.vim',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
      end,
    },
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  { "catppuccin/nvim",      name = "catppuccin", priority = 1000 },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',  opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
      {
        -- this is pretty neat, try :Telescope docker
        "lpoto/telescope-docker.nvim"
      }
    },
    config = function()
      require("telescope").load_extension('live_grep_args')
      require("telescope").load_extension('docker')
    end
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  {
    'akinsho/bufferline.nvim',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('bufferline').setup()
    end
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

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

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },

  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      additional_args = { "--hidden" }
    }
  },
  -- Default configuration for builtin pickers goes here:
  -- picker_name = {
  --   picker_config_key = value,
  --   ...
  -- }
  -- Now the picker_config_key will be applied every time you call this
  -- builtin picker
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

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

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>st', require('telescope.builtin').live_grep, { desc = '[S]earch [T]ext' })
-- vim.keymap.set('n', '<leader>st', '<cmd>Telescope live_grep find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<cr>', { desc = '[S]earch [T]ext' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sg', '<cmd>Telescope live_grep_args<cr>', { desc = '[S]earch [G]rep' })
vim.keymap.set('n', '<leader>sc', '<cmd>Telescope live_grep cwd=$HOME/Programming/personal/dotfiles/cheatsheets<cr>',
local new_daily_note = function()
  return os.date("%Y-%m-%d.md")
end
vim.keymap.set('n', '<leader>dn', '<cmd>tabnew ' .. obsidian_daily_dir .. '/' .. new_daily_note() .. '<cr>',
  { desc = 'open [D]aily [N]ote' })
vim.keymap.set('n', '<leader>sc', '<cmd>Telescope live_grep cwd=' .. cheatsheets_dir .. '<cr>',
  { desc = '[S]earch [C]heatsheets' })
vim.keymap.set('n', '<leader>sn', '<cmd>Telescope live_grep cwd=' .. obsidian_dir .. '<cr>',
  { desc = '[S]earch [N]otes' })
vim.keymap.set('n', '<leader>sd', '<cmd>Telescope live_grep cwd=' .. obsidian_daily_dir .. '<cr>',
  { desc = '[S]earch [D]aily notes' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  -- alternative, manual install ==> :TSInstall markdown
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'json', 'javascript', 'typescript', 'vimdoc', 'vim', 'sql', 'markdown', 'markdown_inline' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  -- note pressing K again will go into the popup
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
  --   vim.lsp.buf.format()
  -- end, { desc = 'Format current buffer with LSP' })
end

vim.api.nvim_create_user_command('Format', function(_)
  vim.lsp.buf.format()
end, { desc = 'Format current buffer with LSP' })


-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  pyright = {},
  rust_analyzer = {},
  jsonls = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
vim.opt.colorcolumn = "80"
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
-- vim.opt.smartindent = true
-- vim.opt.smarttab = true
vim.opt.textwidth = 80

vim.keymap.set('n', '<leader>gg', '<cmd>G<cr>', { desc = 'Fugitive' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })
vim.keymap.set('n', '<C-s>', ':w<cr>', { desc = 'Save', noremap = true })
vim.keymap.set('n', '<leader>lf', '<cmd>Format<cr>', { desc = 'Format' })
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
vim.keymap.set('n', '<leader>gt', '<cmd>tabnext<cr>', { desc = '[G]oto [T]ab' })
vim.keymap.set('n', '<leader>bb', '<cmd>bprev<cr>', { desc = '[B]uffer [B]ack' })
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>', { desc = '[B]uffer [N]ext' })

vim.cmd.colorscheme 'catppuccin'
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--

-- vim.api.nvim_create_user_command("Format", function(args)
--   local range = nil
--   if args.count ~= -1 then
--     local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
--     range = {
--       start = { args.line1, 0 },
--       ["end"] = { args.line2, end_line:len() },
--     }
--   end
--   require("conform").format({ async = true, lsp_fallback = true, range = range })
-- end, { range = true })
--
vim.keymap.set('v', '<leader>as', '<Plug>(EasyAlign)*<Space><CR>', { desc = '[A]lign [S]pace'} )
vim.keymap.set('v', '<leader>ac', '<Plug>(EasyAlign)*,<CR>', { desc = '[A]lign [C]omma'} )
vim.keymap.set('v', '<leader>at', '<Plug>(EasyAlign)*<Bar><CR>', { desc = '[A]lign [T]able'} )

vim.keymap.set('n', '<leader>c', '<cmd>bd<cr>', { desc = '[C]lose buffer' })
