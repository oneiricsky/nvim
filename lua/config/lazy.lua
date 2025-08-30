-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
local plugins = {
  -- Load plugin configurations
  { import = 'plugins' },
}

-- Conditionally add kickstart plugins based on toggles in init.lua
local kickstart = vim.g.kickstart_plugins or {}

if kickstart.autopairs then
  table.insert(plugins, { import = 'kickstart.plugins.autopairs' })
end

if kickstart.debug then
  table.insert(plugins, { import = 'kickstart.plugins.debug' })
end

if kickstart.gitsigns then
  table.insert(plugins, { import = 'kickstart.plugins.gitsigns' })
end

if kickstart.indent_line then
  table.insert(plugins, { import = 'kickstart.plugins.indent_line' })
end

if kickstart.lint then
  table.insert(plugins, { import = 'kickstart.plugins.lint' })
end

if kickstart.neo_tree then
  table.insert(plugins, { import = 'kickstart.plugins.neo-tree' })
end

require('lazy').setup(plugins, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
