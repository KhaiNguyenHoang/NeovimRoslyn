vim.treesitter.language.register("html", "razor")

---@type LazySpec
return {
  {
    "mason-org/mason.nvim",
    optional = true,
    opts = {
      registries = {
        "github:Crashdummyy/mason-registry",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "razor" })
      end
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "rzls", "roslyn" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "rzls", "roslyn" })
    end,
  },
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    -- enabled = false,
    dependencies = {
      { "tris203/rzls.nvim", config = true },
      {
        "Astronvim/astrolsp",
        opts = function(_, opts)
          -- Wrap config trong pcall để tránh crash
          local ok, _ = pcall(function()
            opts.config = opts.config or {}
            opts.config.rzls = { filetypes = { "cs", "razor" } }
            opts.config.roslyn = {
              filetypes = { "cs", "razor" },
              settings = {
                ["csharp|background_analysis"] = {},
                ["csharp|completion"] = {
                  dotnet_provide_regex_completions = true,
                  dotnet_show_completion_items_from_unimported_namespaces = true,
                  dotnet_show_name_completion_suggestions = true,
                },
                ["csharp|inlay_hints"] = {
                  csharp_enable_inlay_hints_for_implicit_object_creation = true,
                  csharp_enable_inlay_hints_for_implicit_variable_types = true,
                  csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                  csharp_enable_inlay_hints_for_types = true,
                  dotnet_enable_inlay_hints_for_indexer_parameters = true,
                  dotnet_enable_inlay_hints_for_literal_parameters = true,
                  dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                  dotnet_enable_inlay_hints_for_other_parameters = true,
                  dotnet_enable_inlay_hints_for_parameters = true,
                  dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                  dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                  dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
                },
                ["csharp|code_lens"] = {
                  dotnet_enable_references_code_lens = true,
                  dotnet_enable_tests_code_lens = true,
                },
                ["csharp|symbol_search"] = { dotnet_search_reference_assemblies = true },
                ["csharp|formatting"] = { dotnet_organize_imports_on_format = true },
              },
            }
          end)
          if not ok then vim.notify("[AstroLSP] Failed to init Roslyn safely", vim.log.levels.WARN) end
        end,
      },
    },
    opts = {
      broad_search = true,
    },
  },
}
