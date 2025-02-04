return {
  -- UI Enhancements
  { 'folke/noice.nvim', config = function()
    require("noice").setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    }) end 
  },
  { 'rcarriga/nvim-notify', config = function()
    require('notify').setup({
      stages = 'static',
      timeout = 5000,
      background_colour = '#1e222a',
      text_colour = '#abb2bf',
      icons = {
        ERROR = ' ',
        WARN = ' ',
        INFO = ' ',
        DEBUG = ' ',
        TRACE = '✎ ',
      },
    }) end 
  },
}

