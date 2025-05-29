-- lua/plugins/colorscheme.lua
return {
  -- Maybe other themes like tokyonight or catppuccin here...

  -- Add nightfox
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- You can define a comment color for a specific theme, like carbonfox:
      palettes = {
        carbonfox = {
          comment = "#cc5200", -- Replace with your desired hex color
        },
      },
      options = {
        terminal_colors = true,
      },
      styles = {
        comments = "italic",
      },
    },
    config = function(_, opts)
      require("nightfox").setup(opts)
      vim.cmd([[colorscheme carbonfox]])
    end,
  },
}
