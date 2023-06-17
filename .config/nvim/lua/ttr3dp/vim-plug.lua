local function add(input)
  local plugins = {}

  for _, spec in ipairs(input) do
    local plugin
    local spec_t = type(spec)

    if spec_t == 'string' then
      plugin = "'"..spec.."'"
    elseif spec_t == 'table' then
      local name = spec[1]
      local opts = spec[2]
      plugin = "'"..name.."', "

      if type(opts) == 'string' then
       plugin = plugin .. opts
      else

        plugin = plugin .. [[{ ]]

        for key, value in pairs(opts) do
          plugin = plugin .. string.format([['%s': '%s',]], key, value)
        end

        plugin = plugin .. [[ }]]
      end
    else
      print("Wrong plugin type! Can be only string or table!")
    end

    table.insert(plugins, plugin)
  end

  vim.cmd([[call plug#begin()]])
  for _, args in ipairs(plugins) do
    local cmd = "Plug " .. args
    -- print(cmd)
    vim.cmd(cmd)
  end
  vim.cmd([[call plug#end()]])
end

return { add = add }
