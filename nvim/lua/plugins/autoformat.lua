-- autoformat.lua
--
-- Use your language server to automatically format your code on save.
-- Adds additional commands as well to manage the behavior

return {
  'neovim/nvim-lspconfig',
  config = function()
    -- Switch for controlling whether you want autoformatting.
    local format_is_enabled = true
    vim.api.nvim_create_user_command('FormatToggle', function()
      format_is_enabled = not format_is_enabled
      print('Setting autoformatting to: ' .. tostring(format_is_enabled))
    end, {})

    -- Create an augroup that is used for managing our formatting autocmds.
    --      We need one augroup per client to make sure that multiple clients
    --      can attach to the same buffer without interfering with each other.
    local _augroups = {}
    local get_augroup = function(client)
      if not _augroups[client.id] then
        local group_name = 'lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach-format', { clear = true }),
      -- This is where we attach the autoformatting for reasonable clients
      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        -- Only attach to clients that support document formatting
        if not client.server_capabilities.documentFormattingProvider then
          return
        end


        vim.api.nvim_create_autocmd('BufWritePre', {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            if not format_is_enabled then
              return
            end

            vim.lsp.buf.format {
              async = false,
              filter = function(c)
                return c.id == client.id
              end,
            }
          end,
        })
      end,
    })
  end,
}
