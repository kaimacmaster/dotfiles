return {
  -- add monokai pro
  { "loctvl842/monokai-pro.nvim", priority = 1000 },

  -- configure lazyvim to load monokai-pro
  {
    "LazyVim/LazyVim",
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
