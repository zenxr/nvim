-- I don't love this, but at least once I was unable to identify trailing
-- whitespace in python code, where the line was 4 spaces [    ]
--
-- This is at least a really simple plugin, importing it is almost overkill

return {
  "johnfrankmorgan/whitespace.nvim",
  cond = false,
  config = {
            -- configuration options and their defaults

            -- `highlight` configures which highlight is used to display
            -- trailing whitespace
            highlight = 'DiffDelete',

            -- `ignored_filetypes` configures which filetypes to ignore when
            -- displaying trailing whitespace
            ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help' },

            -- `ignore_terminal` configures whether to ignore terminal buffers
            ignore_terminal = true,
  }
}
