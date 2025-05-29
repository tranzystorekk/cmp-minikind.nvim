local M = {}
local H = {}

H.icon_provider = (function()
  if _G.MiniIcons == nil then
    -- fallback to no icon and parroting highlight from cmp
    return function(_, _, hl)
      return "", hl
    end
  end

  -- we can ignore the fallback highlight and proxy MiniIcons
  return function(category, name, _)
    local icon, hl, _ = MiniIcons.get(category, name)
    return icon, hl
  end
end)()

function H.setup_config(config)
  vim.validate("config", config, "table", true)
  config = vim.tbl_deep_extend("force", vim.deepcopy(H.default_config), config or {})

  vim.validate("components", config.components, "table")
  vim.validate("separator", config.separator, "string")

  return config
end

function H.apply_config(config)
  M.config = config
end

local modifiers = {
  ["text"] = function(kind)
    return kind
  end,
  ["symbol"] = function(kind)
    local icon, _ = H.icon_provider("lsp", kind)
    return icon
  end,
}

local format = function(kind)
  local components = M.config.components
  local separator = M.config.separator
  local formatted_components = {}

  for _, component in ipairs(components) do
    local display = modifiers[component](kind)
    table.insert(formatted_components, display)
  end

  return table.concat(formatted_components, separator)
end

local hl_group = function(kind, fallback_hl)
  local _, hl = H.icon_provider("lsp", kind, fallback_hl)
  return hl
end

M.config = {
  components = { "symbol", "text" },
  separator = " ",
}

H.default_config = M.config

function M.setup(config)
  config = H.setup_config(config)
  H.apply_config(config)
end

function M.cmp_format()
  return function(entry, vim_item)
    local raw_kind = vim_item.kind
    local raw_hl = vim_item.kind_hl_group
    vim_item.kind = format(raw_kind)
    vim_item.kind_hl_group = hl_group(raw_kind, raw_hl)
    return vim_item
  end
end

return M
