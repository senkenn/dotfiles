-- タブインデント設定
vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- 行番号表示
vim.opt.number = true

-- プロジェクトローカル設定を許可
vim.opt.exrc = true

-- LSP診断ハイライト無効
vim.g.lsp_diagnostics_highlights_enabled = 0

-- lazy.nvim bootstrap
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require("lazy").setup({
  -- vim-lsp
  { "prabirshrestha/vim-lsp" },
  -- vim-lsp-settings (auto config)
  { "mattn/vim-lsp-settings" },
  -- completion
  { "prabirshrestha/asyncomplete.vim" },
  { "prabirshrestha/asyncomplete-lsp.vim" },
})
