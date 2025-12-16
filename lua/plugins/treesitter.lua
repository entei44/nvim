return {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      highlight = { enable = true },
      indent = { enable = true },
      autoage = { enable = true },
      ensure_installed = {
        "lua", "vim", "vimdoc", "html", "css", "json", "yaml", "toml", "rust", "python"
      },
      auto_install = false,
    })
  end
}
