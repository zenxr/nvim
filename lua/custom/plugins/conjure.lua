return {
  {
    'Olical/conjure',
    ft = { 'clojure', 'fennel', 'python' }, -- etc
    main = 'conjure.main',
    lazy = true,
    init = function()
      -- Set configuration options here
      -- Uncomment this to get verbose logging to help diagnose internal Conjure issues
      -- This is VERY helpful when reporting an issue with the project
      -- vim.g["conjure#debug"] = true
      -- Create (or reuse) an augroup
      local group = vim.api.nvim_create_augroup('conjure-remove-sponsor', {})

      -- Clear any existing autocmds in that group (safe if none exist)
      pcall(vim.api.nvim_clear_autocmds, { group = group })

      -- Replace distracting sponsors line
      vim.api.nvim_create_autocmd('BufWinEnter', {
        group = group,
        pattern = 'conjure-log-*',
        callback = function(args)
          local buf = args.buf
          if vim.api.nvim_buf_is_valid(buf) then
            local lines = vim.api.nvim_buf_get_lines(buf, 0, 1, false)
            local first_line = lines[1]
            if first_line and first_line:find '; Sponsored by @' then
              vim.api.nvim_buf_set_lines(buf, 0, 1, false, { '; Conjure' })
            end
          end
        end,
      })
      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'ConjureEval',
        callback = function()
          if vim.fn.expand('%:t'):match '^conjure%-log%-' then
            vim.cmd 'normal! G'
          end
        end,
      })
      -- autocmd User ConjureEval if expand("%:t") =~ "^conjure-log-" | exec "normal G" | endif
    end,
    -- Optional cmp-conjure integration
    dependencies = { 'PaterJason/cmp-conjure' },
  },
  {
    'PaterJason/cmp-conjure',
    lazy = true,
    dependencies = { 'saghen/blink.compat', 'saghen/blink.cmp' },
    config = function()
      local blink = require 'blink.cmp'
      blink.add_source_provider('conjure', { module = 'blink.compat.source', name = 'conjure', score_offset = 0 })
      blink.add_filetype_source('clojure', 'conjure')
    end,
  },
  { -- blink compat layer for nvim-cmp completion plugins
    'saghen/blink.compat',
    -- use v2.* for blink.cmp v1.*
    version = '2.*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
}
