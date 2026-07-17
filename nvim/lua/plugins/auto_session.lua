local gh = require('util').gh

vim.pack.add({ gh('rmagatti/auto-session') })

require('auto-session').setup({
    auto_create = false
})
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,'
    .. 'winpos,terminal,localoptions'
