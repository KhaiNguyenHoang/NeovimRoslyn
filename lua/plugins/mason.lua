---@type LazySpec
return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        keymaps = {
          -- đổi Ctrl+F sang Ctrl+L để lọc ngôn ngữ
          apply_language_filter = "<C-h>",
        },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = {
      ensure_installed = {
        -- install language servers
        "taplo",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "emmet-ls",
        "marksman",
        "yaml-language-server",

        -- install formatters
        "rust-analyzer",
        "stylua",
        "markdown-toc",
        "isort",
        "black",

        -- linters
        "shellcheck",
        "dotenv-linter",

        -- install debuggers
        "debugpy",
        "local-lua-debugger-vscode",
        "firefox-debug-adapter",

        -- install any other package
        "tree-sitter-cli",
        "fish-lsp",
        "gh-actions-language-server",
      },
    },
  },
}
