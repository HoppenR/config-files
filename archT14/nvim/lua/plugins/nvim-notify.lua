return {
    'rcarriga/nvim-notify',
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- Highlighting for notifications
    },
    config = function()
        vim.notify = require('notify')
    end
}
