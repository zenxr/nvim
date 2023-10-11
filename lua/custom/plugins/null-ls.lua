-- plugins/null-ls.lua

return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.formatting.sql_formatter.with { command = { "sql-formatter"}, extra_args = { '--config', '/home/code/.config/sql-formatter/config.json'}, filetypes = { "sql" }},
      }
    })
  end
}
