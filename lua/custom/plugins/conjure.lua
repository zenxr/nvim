return {
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "python" }, -- etc
    lazy = true,
    init = function()
      -- Set configuration options here
      -- Uncomment this to get verbose logging to help diagnose internal Conjure issues
      -- This is VERY helpful when reporting an issue with the project
      -- vim.g["conjure#debug"] = true
      -- Create (or reuse) an augroup
      local group = vim.api.nvim_create_augroup("conjure-remove-sponsor", {})

      -- Clear any existing autocmds in that group (safe if none exist)
      pcall(vim.api.nvim_clear_autocmds, { group = group })

      -- Replace distracting sponsors line
      vim.api.nvim_create_autocmd("BufWinEnter", {
        group = group,
        pattern = "conjure-log-*",
        callback = function(args)
          local buf = args.buf
          if vim.api.nvim_buf_is_valid(buf) then
            local lines = vim.api.nvim_buf_get_lines(buf, 0, 1, false)
            local first_line = lines[1]
            if first_line and first_line:find("; Sponsored by @") then
              vim.api.nvim_buf_set_lines(buf, 0, 1, false, { "; Conjure" })
            end
          end
        end,
      })
    end,

    -- Optional cmp-conjure integration
    -- dependencies = { "PaterJason/cmp-conjure" } -- "clojure-vim/vim-jack-in"},
  },
}
