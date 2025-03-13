-- plugins/null-ls.lua

return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- null_ls.builtins.formatting.ruff,
        null_ls.builtins.diagnostics.shellcheck,
        -- fix eslint issues, ignore broken rules
        null_ls.builtins.code_actions.eslint_d,
        -- typescript, javascript formatter
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.formatting.prettierd.with({
        --   filetypes = { "javascript","typescript","css","scss","html","json","yaml","markdown","graphql","md","txt" }
        -- }),
        -- null_ls.builtins.diagnostics.pylint,
        -- pgformatter > sqlformat > sql-formatter
        null_ls.builtins.formatting.pg_format.with({
          -- https://github.com/darold/pgFormatter
          command = { "pg_format" },
          extra_args = {
            '--comma-start',
            '--wrap-comment',
            '--function-case', '1',
            '--type-case', '1',
            '--keyword-case', '1',
          },
          filetypes = { "sql" },
        }),
        null_ls.builtins.formatting.xmlformat,
        -- notice: pgcli requires sqlformat, it's likely already on path
        -- null_ls.builtins.formatting.sqlformat.with({
        --   -- only_local = vim.fn.expand("~/.local/bin"),
        --   command = { "sqlformat" },
        --   extra_args = {
        --     '--keywords', 'lower',
        --     '--identifiers', 'lower',
        --     '--reindent',
        --     '--comma_first', 'True',
        --     '--indent_columns'
        --   },
        --   filetypes = { "sql" }
        -- })
        -- null_ls.builtins.formatting.sql_formatter.with(
        --  {
        --    command = { "sql-formatter"},
        --    extra_args = { '--config', '/home/code/.config/sql-formatter/config.json'},
        --    filetypes = { "sql" }
        --  }),
      },
    })
  end
}
