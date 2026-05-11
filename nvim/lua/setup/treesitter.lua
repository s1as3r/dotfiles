local ts = require('nvim-treesitter')
local tsc = require('nvim-treesitter.config')

local ensure_installed = {
  'c', 'cpp', 'rust',
  'python', 'bash', 'lua',
  'haskell', 'go', 'latex',
  'julia', 'vimdoc'
}
local already_installed = tsc.get_installed()
local to_install = vim.iter(ensure_installed)
    :filter(function(parser)
      return not vim.tbl_contains(already_installed,
        parser)
    end)
    :totable()
ts.install(to_install)

local function treesitter_try_attach(buf, language)
  if not vim.treesitter.language.add(language) then return end
  vim.treesitter.start(buf, language)

  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.wo.foldmethod = 'expr'
  vim.wo.foldenable = false

  local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
  if has_indent_query then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

local available_parsers = require('nvim-treesitter').get_available()
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end

    local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

    if vim.tbl_contains(installed_parsers, language) then
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      ts.install(language):await(
        function() treesitter_try_attach(buf, language) end
      )
    else
      treesitter_try_attach(buf, language)
    end
  end,
})
