local telescope = require("telescope")
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'live_grep_args')

-- See `:help telescope.builtin`
local function leader_nmap(keys, func, desc)
  vim.keymap.set('n', '<leader>' .. keys, func, { desc = desc })
end

local t_builtin = require("telescope.builtin")
leader_nmap('?', t_builtin.oldfiles, '[?] Find recently opened files')
leader_nmap('<space>', t_builtin.buffers, '[ ] Find existing buffers')
leader_nmap('/', function()
  t_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, '[/] Fuzzily search in current buffer')

leader_nmap('gf', t_builtin.git_files, 'Search [G]it [F]iles')
leader_nmap('sf', t_builtin.find_files, '[S]earch [F]iles')
leader_nmap('sh', t_builtin.help_tags, '[S]earch [H]elp')
leader_nmap('sw', t_builtin.grep_string, '[S]earch current [W]ord')
leader_nmap('sg', telescope.extensions.live_grep_args.live_grep_args, '[S]earch by [G]rep')
leader_nmap('sd', t_builtin.diagnostics, '[S]earch [D]iagnostics')
leader_nmap('tr', t_builtin.resume, '[T]elescope [R]esume')
