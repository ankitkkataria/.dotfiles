vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
-- Highlight yanked text for a short time
  vim.api.nvim_exec([[
    augroup YankHighlight
      autocmd!
      autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="Search", timeout=200})
    augroup end
  ]], false)

vim.opt.smartindent = true

-- require("cyberdream").setup({
--     -- Enable transparent background
--     transparent = false,
--
--     -- Enable italics comments
--     italic_comments = false,
--
--     -- Replace all fillchars with ' ' for the ultimate clean look
--     hide_fillchars = false,
--
--     -- Modern borderless telescope theme - also applies to fzf-lua
--     borderless_telescope = true,
--
--     -- Set terminal colors used in `:terminal`
--     terminal_colors = true,
--
--     -- Use caching to improve performance - WARNING: experimental feature - expect the unexpected!
--     -- Early testing shows a 60-70% improvement in startup time. YMMV. Disables dynamic light/dark theme switching.
--     cache = false, -- generate cache with :CyberdreamBuildCache and clear with :CyberdreamClearCache
--
--     theme = {
--         variant = "default", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
--         highlights = {
--             -- Highlight groups to override, adding new groups is also possible
--             -- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values
--
--             -- Example:
--             Comment = { fg = "#696969", bg = "NONE", italic = true },
--
--             -- Complete list can be found in `lua/cyberdream/theme.lua`
--         },
--
--         -- Override a highlight group entirely using the color palette
--         overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
--             -- Example:
--             return {
--                 Comment = { fg = colors.green, bg = "NONE", italic = true },
--                 ["@property"] = { fg = colors.magenta, bold = true },
--             }
--         end,
--
--         -- Override a color entirely
--         colors = {
--             -- For a list of colors see `lua/cyberdream/colours.lua`
--             -- Example:
--             bg = "#000000",
--             green = "#00ff00",
--             magenta = "#ff00ff",
--         },
--     },
--
--     -- Disable or enable colorscheme extensions
--     extensions = {
--         telescope = true,
--         notify = true,
--         mini = true,
--         ...
--     },
-- })

