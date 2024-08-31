require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

require('mini.sessions').setup {
  autoread = true,
  hooks = {
    post = {
      read = function()
        vim.api.nvim_command("ScareyTreeOpen")
      end
    },
  },
}

require('mini.starter').setup()
