return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_fix" },
        typst = { "typstyle" },
        lua = { "stylua" },
        markdown = { "mdformat" },
        cpp = { "clang-format" },
        toml = { "taplo" },
        sh = { "shellcheck", "shfmt" },
      },
      formatters = {
        ruff_fix = {
          prepend_args = {
            "--config",
            "lint.isort.relative-imports='from'",
            "--config",
            "lint.isort.force-single-line=false",
            "--config",
            "line-length=100",
          },
        },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
