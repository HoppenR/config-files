--
-- ~/.config/nvim/lua/plugins/init.lua
--

-- IDEA: Neogitorg/Neogit?
-- IDEA: Github copilot?

return {
    --[[ Plugin Manager ]]
    -- 'folke/lazy.nvim' --> ./init.lua

    --[[ File Manager ]]
    -- 'stevearc/oil.nvim' --> ./oil-nvim.lua

    --[[ Language Server Protocol ]]
    -- 'neovim/nvim-lspconfig' --> ./nvim-lspconfig.lua
    -- 'j-hui/fidget.nvim' --> ./fidget-nvim.lua

    --[[ Notifications ]]
    -- 'rcarriga/nvim-notify' --> ./nvim-notify.lua

    --[[ Completion ]]
    -- 'hrsh7th/nvim-cmp' --> ./nvim-cmp.lua
    -- 'L3MON4D3/LuaSnip' --> ./luasnip.lua
    --                    --> (Also opt for my nvim-cmp setup)

    --[[ Telescope ]]
    -- 'nvim-telescope/telescope' --> ./telescope.lua

    --[[ Treesitter ]]
    -- 'nvim-treesitter/nvim-treesitter' --> ./nvim-treesitter.lua
    --                                   --> (Also opt for neorg)
    --                                   --> (Also opt for nvim-notify)

    --[[ Neorg ]]
    -- 'nvim-neorg/neorg' --> ./neorg.lua

    --[[ Undotree ]]
    -- 'jiaoshijie/undotree' --> ./undotree.lua

    --[[ Dependencies (Extra) ]]
    --  package                         location
    -- 'nvim-lua/plenary.nvim'          ./telescope.lua
    --                                  ./neorg.lua
    --                                  ./undotree.lua
    -- 'hrsh7th/cmp-nvim-lsp'           ./nvim-cmp.lua
    --                                  ./nvim-lspconfig.lua
    -- 'hrsh7th/cmp-buffer'             ./nvim-cmp.lua
    -- 'hrsh7th/cmp-cmdline'            ./nvim-cmp.lua
    -- 'hrsh7th/cmp-path'               ./nvim-cmp.lua
    -- 'hrsh7th/cmp_luasnip'            ./nvim-cmp.lua
    -- 'nvim-tree/nvim-web-devicons'    ./oil-nvim.lua
    --                                  ./telescope.lua
}
