-- Hot-reload utility for development
-- Provides functions to reload configuration modules without restarting Neovim

local M = {}

-- Track loaded modules for cleanup
M.loaded_modules = {}

-- Clear module from package.loaded and our tracking
local function unload_module(module_name)
  package.loaded[module_name] = nil
  M.loaded_modules[module_name] = nil
end

-- Clear all tracked modules
local function clear_loaded_modules()
  for module_name, _ in pairs(M.loaded_modules) do
    package.loaded[module_name] = nil
  end
  M.loaded_modules = {}
end

-- Safe require with error handling
local function safe_require(module_name)
  local ok, result = pcall(require, module_name)
  if not ok then
    vim.notify('Error loading ' .. module_name .. ': ' .. result, vim.log.levels.ERROR)
    return nil
  end
  M.loaded_modules[module_name] = true
  return result
end

-- Reload a specific module
function M.reload_module(module_name)
  unload_module(module_name)
  local module = safe_require(module_name)
  if module and module.setup then
    module.setup()
  end
  vim.notify('Reloaded: ' .. module_name, vim.log.levels.INFO)
end

-- Reload all core modules
function M.reload_core()
  vim.notify('Reloading core modules...', vim.log.levels.INFO)
  
  -- Clear existing keymaps (core ones only)
  local core_keymaps = {
    { 'n', '<Esc>' },
    { 'n', '<leader>q' },
    { 't', '<Esc><Esc>' },
    { 'n', '<C-h>' },
    { 'n', '<C-l>' },
    { 'n', '<C-j>' },
    { 'n', '<C-k>' },
    { 'n', '<leader>b' },
    { 'n', '<leader>n' },
  }
  
  for _, keymap in ipairs(core_keymaps) do
    pcall(vim.keymap.del, keymap[1], keymap[2])
  end
  
  -- Clear autocommand groups
  pcall(vim.api.nvim_del_augroup_by_name, 'kickstart-highlight-yank')
  pcall(vim.api.nvim_del_augroup_by_name, 'kickstart-netrw')
  
  -- Reload core modules
  M.reload_module('core.options')
  M.reload_module('core.keymaps')
  M.reload_module('core.autocmds')
  M.reload_module('core.netrw')
  
  vim.notify('Core modules reloaded!', vim.log.levels.INFO)
end

-- Reload plugins (clears plugin module cache)
function M.reload_plugins()
  vim.notify('Clearing plugin configuration cache...', vim.log.levels.INFO)
  
  -- Clear plugin modules from package cache
  local cleared_count = 0
  for name, _ in pairs(package.loaded) do
    if name:match('^plugins%.') or name:match('^kickstart%.plugins%.') then
      package.loaded[name] = nil
      cleared_count = cleared_count + 1
    end
  end
  
  vim.notify(string.format('Cleared %d plugin modules from cache. Use :Lazy sync to apply changes.', cleared_count), vim.log.levels.INFO)
end

-- Full configuration reload
function M.reload_all()
  vim.notify('Full configuration reload...', vim.log.levels.INFO)
  
  -- Clear all our tracked modules
  clear_loaded_modules()
  
  -- Reload configuration
  M.reload_core()
  M.reload_plugins()
  
  vim.notify('Full reload complete!', vim.log.levels.INFO)
end

-- Set up reload keymaps
function M.setup_reload_keymaps()
  vim.keymap.set('n', '<leader>rr', M.reload_all, { desc = '[R]eload [R]eload All Config' })
  vim.keymap.set('n', '<leader>rc', M.reload_core, { desc = '[R]eload [C]ore Modules' })
  vim.keymap.set('n', '<leader>rp', M.reload_plugins, { desc = '[R]eload [P]lugins (clear cache)' })
  vim.keymap.set('n', '<leader>rl', '<cmd>Lazy<cr>', { desc = '[R]eload [L]azy UI' })
  vim.keymap.set('n', '<leader>rs', '<cmd>Lazy sync<cr>', { desc = '[R]eload [S]ync plugins' })
  vim.keymap.set('n', '<leader>ro', function() M.reload_module('core.options') end, { desc = '[R]eload [O]ptions' })
  vim.keymap.set('n', '<leader>rk', function() M.reload_module('core.keymaps') end, { desc = '[R]eload [K]eymaps' })
  vim.keymap.set('n', '<leader>ra', function() M.reload_module('core.autocmds') end, { desc = '[R]eload [A]utocmds' })
  vim.keymap.set('n', '<leader>rn', function() M.reload_module('core.netrw') end, { desc = '[R]eload [N]etrw' })
end

return M
