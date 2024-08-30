--------------------------------------------------------------------------------
--- Theme
--------------------------------------------------------------------------------
vim.cmd.colorscheme "catppuccin-mocha"


--------------------------------------------------------------------------------
--- Options
--------------------------------------------------------------------------------
vim.opt.mouse = "a"
vim.opt.mousemoveevent = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true


--------------------------------------------------------------------------------
--- Keymaps
--------------------------------------------------------------------------------
vim.keymap.set('n', '<LEFT>', function() vim.api.nvim_command('BufferLineCyclePrev') end)
vim.keymap.set('n', '<RIGHT>', function() vim.api.nvim_command('BufferLineCycleNext') end)
vim.keymap.set('n', '<leader><LEFT>', function() vim.api.nvim_command('BufferLineMovePrev') end)
vim.keymap.set('n', '<leader><RIGHT>', function() vim.api.nvim_command('BufferLineMoveNext') end)

-- Close file
vim.keymap.set('n', '<leader>q', function()
  -- Exit if file has unsaved changes
  if (vim.bo.modified) then
    print("There are unsaved changes")
    return
  end

  local target_buffer = vim.api.nvim_get_current_buf()
  vim.api.nvim_command('bprev')
  vim.api.nvim_command('bd ' .. target_buffer)
end)

-- NvimTree
vim.keymap.set('n', "<leader><TAB>", function() vim.api.nvim_command("NvimTreeToggle") end)
vim.keymap.set('n', "<leader>h", function() require("nvim-tree.api").tree.toggle_gitignore_filter() end)

-- Telescope
vim.keymap.set('n', "<leader>t", function() vim.api.nvim_command("Telescope") end)
vim.keymap.set('n', "<leader>f", function() vim.api.nvim_command("Telescope live_grep") end)
vim.keymap.set('n', "<leader>s", function() vim.api.nvim_command("Telescope git_status") end)
vim.keymap.set('n', "<leader>l", function() vim.api.nvim_command("Telescope git_commits") end)

-- Dap
vim.keymap.set('n', "<leader>b", function() vim.api.nvim_command("DapToggleBreakpoint") end)
vim.keymap.set('n', "<leader>d", function() vim.api.nvim_command("DapUiToggle") end)


--------------------------------------------------------------------------------
--- Autocmds
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("VimEnter", {
  command = "silent !kitty @ set-spacing padding=0"
})

vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    -- Only when exiting to kitty
    if (os.getenv("TERM") == "xterm-kitty") then
      vim.api.nvim_command("silent !kitty @ set-spacing padding=10 padding-top=0")
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    -- Language specific options
    if (vim.bo.filetype == "dart") then
      vim.opt.shiftwidth = 2
      vim.opt.softtabstop = 2
    end
    if (vim.bo.filetype == "nix") then
      vim.opt.shiftwidth = 2
      vim.opt.softtabstop = 2
    end
  end,
})
