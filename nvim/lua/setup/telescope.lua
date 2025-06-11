require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
local function leader_nmap(keys, func, desc)
  vim.keymap.set('n', '<leader>' .. keys, func, { desc = desc })
end

leader_nmap('?', require('telescope.builtin').oldfiles, '[?] Find recently opened files')
leader_nmap('<space>', require('telescope.builtin').buffers, '[ ] Find existing buffers')
leader_nmap('/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, '[/] Fuzzily search in current buffer')

leader_nmap('gf', require('telescope.builtin').git_files, 'Search [G]it [F]iles')
leader_nmap('sf', require('telescope.builtin').find_files, '[S]earch [F]iles')
leader_nmap('sh', require('telescope.builtin').help_tags, '[S]earch [H]elp')
leader_nmap('sw', require('telescope.builtin').grep_string, '[S]earch current [W]ord')
leader_nmap('sg', require('telescope.builtin').live_grep, '[S]earch by [G]rep')
leader_nmap('sd', require('telescope.builtin').diagnostics, '[S]earch [D]iagnostics')
leader_nmap('tr', require('telescope.builtin').resume, '[T]elescope [R]esume')
