return {
  'shortcuts/no-neck-pain.nvim',
  config = function()
    local np = require("no-neck-pain")
    vim.keymap.set(
      'n', '<leader>zt', np.toggle,
      { desc = "[Z]en Mode [T]oggle" }
    )
    vim.keymap.set(
      'n', '<leader>zr', function() np.toggle_side("right") end,
      { desc = "[Z]en Mode Toggle [R]ight" }
    )
    vim.keymap.set(
      'n', '<leader>zl', function() np.toggle_side("left") end,
      { desc = "[Z]en Mode Toggle [L]eft" }
    )
  end
}
