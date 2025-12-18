local util = {}

function util.set_proj_specific_regs(project_name, regs)
  local cwd = vim.fn.getcwd()
  local current_project_name = vim.fn.fnamemodify(cwd, ":t")

  if current_project_name ~= project_name then
    return false
  end

  for reg, value in pairs(regs) do
    vim.fn.setreg(reg, value)
  end
end

return util
