-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local M = {}

function M.setup()
  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic keymaps
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- TIP: Disable arrow keys in normal mode
  -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- Toggle netrw file explorer with <leader>b
  vim.keymap.set('n', '<leader>b', function()
    -- Check for netrw buffer
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_get_option(buf, 'filetype') == 'netrw' then
        -- Close netrw if found
        vim.api.nvim_buf_delete(buf, { force = true })
        return
      end
    end
    -- Otherwise, open netrw in horizontal split
    vim.cmd 'Sex!'
  end, { desc = 'Toggle [B]rowser (netrw)' })

  -- New buffer
  vim.keymap.set('n', '<leader>n', ':enew<CR>', { desc = 'Create [N]ew buffer' })

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  -- Remap scrolling
  vim.keymap.set('n', 'J', '<C-d>', { desc = 'Down half a page', noremap = true, silent = true })
  vim.keymap.set('n', 'K', '<C-u>', { desc = 'Up half a page', noremap = true, silent = true })

  -- Preserve original behaviors on <leader>J / <leader>K
  vim.keymap.set('n', '<leader>j', 'J', { desc = '[J]oin lines', noremap = true, silent = true })
  vim.keymap.set('n', '<leader>k', 'K', { desc = 'Help under cursor', noremap = true, silent = true })
end

-- Call setup immediately for backward compatibility
M.setup()

return M
