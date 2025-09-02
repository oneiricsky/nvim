-- Global settings that need to be set early
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- Reload a Lua module (or multiple modules) safely
function _G.ReloadConfig(module_name)
  -- If no module name, reload all top-level modules under 'lua/'
  if not module_name then
    for name, _ in pairs(package.loaded) do
      -- Only reload your config files, not built-ins
      if name:match '^user' or name:match '^netrw' then
        package.loaded[name] = nil
        require(name)
      end
    end
  else
    -- Reload a specific module
    package.loaded[module_name] = nil
    require(module_name)
  end
end
