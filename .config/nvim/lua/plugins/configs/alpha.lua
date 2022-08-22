local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
-- dashboard.section.header.val = {
--     [[ $$\   $$\                                         $$\ $$\                  ]], 
--     [[ $$ | $$  |                                        \__|$$ |                 ]],
--     [[ $$ |$$  /  $$$$$$\   $$$$$$\   $$$$$$\   $$$$$$$\ $$\ $$ |  $$\  $$$$$$\   ]],
--     [[ $$$$$  /   \____$$\ $$  __$$\  \____$$\ $$  _____|$$ |$$ | $$  |$$  __$$\  ]],
--     [[ $$  $$<    $$$$$$$ |$$ |  \__| $$$$$$$ |\$$$$$$\  $$ |$$$$$$  / $$ /  $$ | ]],
--     [[ $$ |\$$\  $$  __$$ |$$ |      $$  __$$ | \____$$\ $$ |$$  _$$<  $$ |  $$ | ]],
--     [[ $$ | \$$\ \$$$$$$$ |$$ |      \$$$$$$$ |$$$$$$$  |$$ |$$ | \$$\ \$$$$$$$ | ]],
--     [[ \__|  \__| \_______|\__|       \_______|\_______/ \__|\__|  \__| \____$$ | ]],
--     [[                                                                       $$ | ]],
--     [[                                                                       $$ | ]],
--     [[                                                                       \__| ]],
-- }


dashboard.section.header.val = {
    [[   .-'~~~-.       $$\   $$\                                         $$\ $$\                  ]],
    [[ .' ~ oOOOo`.     $$ | $$  |                                        \__|$$ |                 ]],
    [[:~   .oOo   o`.   $$ |$$  /  $$$$$$\   $$$$$$\   $$$$$$\   $$$$$$$\ $$\ $$ |  $$\  $$$$$$\   ]],
    [[ `. \ ~-.  oOOo.  $$$$$  /   \____$$\ $$  __$$\  \____$$\ $$  _____|$$ |$$ | $$  |$$  __$$\  ]],
    [[   `.; / ~.  OO:  $$  $$<    $$$$$$$ |$$ |  \__| $$$$$$$ |\$$$$$$\  $$ |$$$$$$  / $$ /  $$ | ]],
    [[   .'  ;-- `.o.'  $$ |\$$\  $$  __$$ |$$ |      $$  __$$ | \____$$\ $$ |$$  _$$<  $$ |  $$ | ]],
    [[  ,'  ; ~~--'~    $$ | \$$\ \$$$$$$$ |$$ |      \$$$$$$$ |$$$$$$$  |$$ |$$ | \$$\ \$$$$$$$ | ]],
    [[\\;_\\//___\|/__  \__|  \__| \_______|\__|       \_______|\_______/ \__|\__|  \__| \____$$ | ]],
    [[                                                                                        $$ | ]],
    [[                                                                                        $$ | ]],
    [[                                                                                        \__| ]],
}

dashboard.section.footer.val = {
  "                                                        ",
  "                                                        ",
  " The only true wisdom is in knowing you know nothing 🐥 ",
  "                                                        ",   
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e", "📜 > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "🔭 > Find file", ":Telescope find_files<CR>"),
    dashboard.button( "r", "⏳ > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "t", "🌿 > Tree"   , ":CHADopen<CR>"),
    dashboard.button( "s", "🔧 > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button( "q", "🚬 > Quit", ":qa<CR>"),
}

-- Set footer
--   NOTE: This is currently a feature in my fork of alpha-nvim (opened PR #21, will update snippet if added to main)
--   To see test this yourself, add the function as a dependecy in packer and uncomment the footer lines
--   ```init.lua
--   return require('packer').startup(function()
--       use 'wbthomason/packer.nvim'
--       use {
--           'goolord/alpha-nvim', branch = 'feature/startify-fortune',
--           requires = {'BlakeJC94/alpha-nvim-fortune'},
--           config = function() require("config.alpha") end
--       }
--   end)
--   ```
-- local fortune = require("alpha.fortune") 
-- dashboard.section.footer.val = fortune()

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
