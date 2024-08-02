local not_vscode = require("util").not_vscode
return {
  {
    "jellydn/hurl.nvim",
    cond = not_vscode,
    ft = "hurl",
    lazy = true,
    opts = {
      show_notification = true,
      env_file = {
        ".envrc",
        ".env",
        "vars.env",
        "hurl.env",
      },
    },
    keys = {
      -- Run API request
      { "<leader>rA", "<cmd>HurlRunner<CR>", desc = "Run all requests" },
      { "<leader>ra", "<cmd>HurlRunnerAt<CR>", desc = "Run api request" },
      { "<leader>re", "<cmd>HurlRunnerToEntry<CR>", desc = "Run api request to entry" },
      { "<leader>rt", "<cmd>HurlToggleMode<CR>", desc = "Hurl toggle mode" },
      { "<leader>rv", "<cmd>HurlVerbose<CR>", desc = "Run api in verbose mode" },
      -- Run Hurl request in visual mode
      { "<leader>ra", ":HurlRunner<CR>", desc = "Hurl runner", mode = "v" },
    },
  },
  -- markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cond = not_vscode,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown preview toggle" },
    },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = { theme = "dark" },
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {},
      }
    end,
    ft = { "markdown" },
  },
  -- neovim in browser
  {
    "glacambre/firenvim",
    cond = not_vscode,
    lazy = not vim.g.started_by_firenvim,
    init = function()
      vim.g.firenvim_config = {
        globalSettings = { alt = "all" },
        localSettings = {
          [".*"] = {
            cmdline = "firenvim",
            content = "text",
            priority = 0,
            selector = "textarea:not([readonly], [aria-readonly])",
            takeover = "never",
          },
        },
      }
    end,
    build = ":call firenvim#install(0)",
    config = function()
      vim.api.nvim_set_keymap(
        "n",
        "<Esc><Esc>",
        "<Cmd>call firenvim#focus_page()<CR>",
        { desc = "Firenvim focus page" }
      )
    end,
  },
  -- db manage
  {
    "kristijanhusak/vim-dadbod-ui",
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui_queries"
      vim.g.vim_dadbod_completion_mark = ""
      -- set filetype to sql to make snip completion work
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "mysql,plsql",
        callback = function()
          vim.bo.filetype = "sql"
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sql",
        callback = function()
          vim.api.nvim_set_keymap(
            "x",
            "<leader>rq",
            "db#op_exec()",
            { expr = true, desc = "DB exec current query" }
          )
        end,
      })
    end,
    dependencies = {
      { "tpope/vim-dadbod" },
    },
    keys = {
      { "<leader><leader>d", "<cmd>DBUIToggle<cr>", desc = "DBUI toggle" },
    },
    ft = { "sql", "mysql", "plsql" },
    cond = not_vscode,
    cmd = "DBUIToggle",
  },
  -- search and replace tool
  {
    "windwp/nvim-spectre",
    cond = not_vscode,
    keys = {
      {
        "<leader>st",
        '<cmd>lua require("spectre").toggle()<CR>',
        desc = "Toggle spectre",
      },
      {
        "<leader>sv",
        '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
        mode = { "n", "v" },
        desc = "Spectre search current word",
      },
      {
        "<leader>sf",
        '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
        desc = "Search on current file",
      },
    },
  },
  {
    "uga-rosa/translate.nvim",
    cmd = "Translate",
    keys = {
      -- Display translation in a window
      { "<leader>tt", "<cmd>Translate ZH<CR>", mode = { "n", "x" }, desc = "Translate to a pop window" },
      -- Replace the text with translation
      { "<leader>tr", "<cmd>Translate ZH -output=replace<CR>", mode = { "n", "x" }, desc = "Translate and replace" },
      -- Insert the text with translation
      { "<leader>ti", "<cmd>Translate ZH -output=insert<CR>", mode = { "n", "x" }, desc = "Translate and insert word" },
      -- copy translation to register
      { "<leader>ty", "<cmd>Translate ZH -output=register<CR>", mode = { "n", "x" }, desc = "Translate to register" },
    },
    cond = not_vscode,
    opts = function()
      local default_command = "google"
      if vim.fn.executable("trans") then
        default_command = "translate_shell"
      end
      return {
        default = {
          command = default_command,
        },
      }
    end,
  },
  {
    "jbyuki/venn.nvim",
    cmd = { "VBox" },
    keys = {
      { "<leader>vv", ":VBox<cr>", mode = "v", desc = "Draw a single line box or arrow" },
      { "<leader>vd", ":VBoxD<cr>", mode = "v", desc = "Draw a double line box or arrow" },
      { "<leader>vh", ":VBoxH<cr>", mode = "v", desc = "Draw a heavy line box or arrow" },
      { "<leader>vo", ":VBoxO<cr>", mode = "v", desc = "Draw over a existing box or arrow" },
      { "<leader>vO", ":VBoxDO<cr>", mode = "v", desc = "Draw over a doulbe line on a existing box or arrow" },
      { "<leader>vH", ":VBoxHO<cr>", mode = "v", desc = "Draw over a heavy line on a existing box or arrow" },
      { "<leader>vf", ":VFill<cr>", mode = "v", desc = "Draw fill a area with a solid color" },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    event = "BufRead",
    opts = function()
      local adapter = "anthropic"
      if vim.fn.has("ollama") == 1 then
        local handle = io.popen("ollama ps")
        if handle then
          for line in handle:lines() do
            local first_word = line:match("%S+")
            if first_word ~= nil and first_word ~= "NAME" then
              adapter = "ollama"
              break
            end
          end
        end
      end
      return {
        adapters = {
          anthropic = function()
            return require("codecompanion.adapters").use("anthropic", {
              env = {
                api_key = "cmd:sops exec-env $SOPS_SECRETS 'echo -n $ANTHROPIC_API_KEY'",
              },
            })
          end,
          ollama = function()
            return require("codecompanion.adapters").use("ollama", {
              schema = {
                model = {
                  default = "llama3.1",
                },
              },
            })
          end,
        },
        strategies = {
          chat = { adapter = adapter },
          inline = { adapter = adapter },
          agent = { adapter = adapter },
        },
        default_prompts = {
          ["Custom Prompt"] = { opts = { mapping = "<Leader>Cp" } },
          ["Senior Developer"] = { opts = { mapping = "<Leader>Cs" } },
          ["Explain"] = { opts = { mapping = "<Leader>Ce" } },
          ["Unit Tests"] = { opts = { mapping = "<Leader>Ct" } },
          ["Fix code"] = { opts = { mapping = "<Leader>Cf" } },
          ["Buffer selection"] = { opts = { mapping = "<Leader>Cb" } },
          ["Explain LSP Diagnostics"] = { opts = { mapping = "<Leader>Cl" } },
          ["Generate a Commit Message"] = { opts = { mapping = "<Leader>Cm" } },
        },
        display = {
          chat = {
            show_settings = true,
          },
        },
      }
    end,
    keys = {
      { mode = { "n", "v" }, "<leader>Ca", "<cmd>CodeCompanionActions<cr>", desc = "Code companion actions" },
      { "<leader>Cc", "<cmd>CodeCompanion<cr>", desc = "Code companion" },
      { "<leader>CC", "<cmd>CodeCompanionChat<cr>", desc = "Code companion chat" },
      { mode = { "n", "v" }, "<leader>CT", "<cmd>CodeCompanionToggle<cr>", desc = "Code companion toggle" },
      { mode = { "v" }, "<leader>CA", "<cmd>CodeCompanionAdd<cr>", desc = "Code companion add" },
    },
  },
}
