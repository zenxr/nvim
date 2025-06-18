return {
  -- code formatting plugin
  "stevearc/conform.nvim",
  cond = true, -- enable
  -- cond = false, -- disable
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = {"ruff_fix" , "ruff_format" },
      -- python = { "isorr", "black" },
      javascript = { { "prettierd", "prettier" } },
      sql = { "sql_formatter" },
      xml = { "xmlformat" },
    },
  },

  -- This function is optional, but if you want to customize formatters do it here
  config = function(_, opts)
    local util = require("conform.util")
    -- util.add_formatter_args(require("conform.formatters.sql_formatter"),
    --   { "--fix", "--config", "/home/code.config/sql-formatter/config.json" })
    require("conform").setup(opts)

  end,
}
