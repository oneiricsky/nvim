-- [[ Kickstart Plugin Toggles ]]
-- Enable/disable optional kickstart plugins by setting these to true/false
-- Changes take effect after restarting Neovim or running :Lazy sync
local kickstart_plugins = {
  autopairs = false, -- Automatic bracket/quote pair insertion
  debug = false, -- DAP debugging support (primarily for Go)
  gitsigns = false, -- Extended git integration with more keymaps
  indent_line = false, -- Visual indentation guides
  lint = false, -- Code linting with nvim-lint
  neo_tree = false, -- File explorer with tree view
}

-- Make kickstart plugins globally accessible
vim.g.kickstart_plugins = kickstart_plugins
-- Load configuration modules in the proper order
require 'config.globals' -- Global settings that must be set early
require 'core.options' -- General Neovim options
require 'core.netrw'
require 'core.keymaps' -- Basic keymaps
require 'core.autocmds' -- Autocommands
require 'config.lazy' -- Plugin manager and plugin loading
-- Set up hot-reload system for development
require('config.reload').setup_reload_keymaps()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
