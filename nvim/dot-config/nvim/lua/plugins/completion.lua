return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      completion = { documentation = { auto_show = false } },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "atfile" },
        providers = {
          atfile = {
            name = "atfile",
            module = "atfile",
            enabled = function() return vim.bo.filetype == "markdown" end,
            should_show_items = function(ctx)
              return ctx.trigger.initial_kind == "trigger_character"
            end,
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
