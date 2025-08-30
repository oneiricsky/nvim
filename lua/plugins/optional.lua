-- Optional plugins that can be enabled as needed
-- To enable any of these, change the corresponding value to 'true' in init.lua

-- These plugins are available but not loaded by default:

-- 1. autopairs (kickstart.plugins.autopairs)
--    - Automatic bracket/quote pair insertion
--    - Enable by setting: kickstart_plugins.autopairs = true

-- 2. debug (kickstart.plugins.debug)
--    - DAP debugging support with UI
--    - Primarily configured for Go but extensible
--    - Enable by setting: kickstart_plugins.debug = true

-- 3. gitsigns (kickstart.plugins.gitsigns)
--    - Extended gitsigns configuration with recommended keymaps
--    - Note: Basic gitsigns is already enabled in plugins/git.lua
--    - Enable by setting: kickstart_plugins.gitsigns = true

-- 4. indent_line (kickstart.plugins.indent_line)
--    - Visual indentation guides
--    - Enable by setting: kickstart_plugins.indent_line = true

-- 5. lint (kickstart.plugins.lint)
--    - Code linting with nvim-lint
--    - Configured for markdown by default
--    - Enable by setting: kickstart_plugins.lint = true

-- 6. neo_tree (kickstart.plugins.neo-tree)
--    - File explorer with tree view
--    - Alternative to built-in netrw
--    - Enable by setting: kickstart_plugins.neo_tree = true

-- Instructions:
-- 1. Go to init.lua
-- 2. Find the kickstart_plugins table near the top
-- 3. Change any 'false' values to 'true' for plugins you want to enable
-- 4. Restart Neovim or run :Lazy sync

return {}
