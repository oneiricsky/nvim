-- Set options for netrw
local M = {}

function M.setup()
  vim.g.netrw_banner = 0 -- Disable the banner at the top
  vim.g.netrw_browse_split = 4 -- Open in a new tab by default
  vim.g.netrw_altv = 0 -- Open splits to the right
  vim.g.netrw_liststyle = 3 -- Tree-style view
  vim.g.netrw_winsize = 25 -- Default window size

  -- Optional: key mappings for netrw
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'netrw',
    group = vim.api.nvim_create_augroup('kickstart-netrw', { clear = true }),
    callback = function()
      local opts = { noremap = true, silent = true }
      -- Close netrw with q
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':bd<CR>', opts)
      -- Refresh netrw
      vim.api.nvim_buf_set_keymap(0, 'n', 'R', ':Rexplore<CR>', opts)
    end,
  })
end

-- Call setup immediately for backward compatibility
M.setup()

return M
