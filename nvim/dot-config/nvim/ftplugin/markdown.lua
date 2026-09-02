local table_filter = ":!tr -s ' ' | column -t -s '|' -o '|'<CR>"

-- format a visually selected markdown table (select with V, then run)
vim.keymap.set("v", "<leader>tf", table_filter, { buffer = true, desc = "Format markdown table" })

-- format the table under cursor without manually selecting it first
-- (works because a markdown table is a contiguous block of non-blank lines,
-- same as an inner-paragraph text object)
vim.keymap.set(
  "n",
  "<leader>tf",
  "vip" .. table_filter,
  { buffer = true, desc = "Format markdown table" }
)
