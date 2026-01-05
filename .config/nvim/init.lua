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
