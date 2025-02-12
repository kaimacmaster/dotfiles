return {
  'loctvl842/monokai-pro.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    -- Setup for Monokai Pro
    require("monokai-pro").setup({
      transparent_background = true,
      terminal_colors = true,
    })
    vim.cmd([[colorscheme monokai-pro]])

    -- Toggle background transparency
    local bg_transparent = true

    local toggle_transparency = function()
      bg_transparent = not bg_transparent
      -- Update the transparent background setting
      require("monokai-pro").setup({
        transparent_background = bg_transparent,
        terminal_colors = true,  -- Keep terminal colors enabled
      })
      vim.cmd([[colorscheme monokai-pro]])  -- Reload colorscheme to apply changes
    end

    -- Keybinding to toggle background transparency
    vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
  end,
}
