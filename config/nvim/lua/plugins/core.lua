return {
  -- add monokai pro
  { "loctvl842/monokai-pro.nvim", priority = 1000 },

  -- configure lazyvim to load monokai-pro
  {
    "lazyvim/lazyvim",
    opts = {
      colorscheme = "monokai-pro",
    },
  },

  -- configure snacks to hide the header
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            --{ icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            --{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = [[
                                                         
            |   _. o ._ _   _.  _ ._ _   _.  _ _|_  _  ._ 
            |< (_| | | | | (_| (_ | | | (_| _>  |_ (/_ |  
                                                          

            01001011 01100001 01101001
            
            Kai Macmaster, nvim enthusiast, software developer, all that jazz.

            Neovim frikin' rocks! 🤘
          ]],
        },
      },
    },
  },
}
