vim.loader.enable()
package.path = package.path .. "./lua/?/init.lua"

require('base')
require('plugins')
require('autocommand')
require('keymap')
