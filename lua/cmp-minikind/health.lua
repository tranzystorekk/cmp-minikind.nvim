local M = {}

function M.check()
  vim.health.start("Checking plugin dependencies")
  if _G.MiniIcons ~= nil then
    vim.health.ok("mini.icons enabled")
  else
    vim.health.error("mini.icons not found")
  end
end

return M
