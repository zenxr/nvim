return {
  {
    -- provides highlighting and context via LSP hooks
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects'
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({

        -- Add languages to be installed here that you want installed for treesitter
        -- alternative, manual install ==> :TSInstall markdown
        ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'json', 'javascript', 'typescript',
          'vimdoc',
          'vim', 'sql', 'markdown', 'markdown_inline', 'bash', 'css', 'html', 'toml' },
        sync_install = false,
        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = false,
        ignore_install = {},
        modules = {}, -- why is this required???
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
      })
    end
  },
  {
    -- allows hooking into context-aware textobjects (see `textobjects` above)
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter' },
    lazy = true,
  },
  {
    -- displays context (e.g class and func name) when deep into a scope
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  }
}
