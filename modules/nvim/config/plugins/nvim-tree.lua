require("nvim-tree").setup {
  filters = {
    git_ignored = false,
  },
  update_focused_file = { 
    enable = true,
  },
  view = {
    width = 40,
  },
}

vim.api.nvim_create_user_command('ScareyTreeToggle',function()
  vim.api.nvim_command("NvimTreeToggle")
  vim.cmd "wincmd p"
end,{})

vim.api.nvim_create_user_command('ScareyTreeOpen',function()
  vim.api.nvim_command("NvimTreeOpen")
  vim.cmd "wincmd p"
end,{})
