-- require('dap-go').setup()

require("dapui").setup {}
require("nvim-dap-virtual-text").setup()
require('dap.ext.vscode').load_launchjs()

-- language configurations
require("marvin.debug.node")
require("marvin.debug.go")

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

function _G.dapRunConfigWithArgs()
  local dap = require('dap')
  local ft = vim.bo.filetype
  if ft == "" then
    print("Filetype option is required to determine which dap configs are available")
    return
  end
  local configs = dap.configurations[ft]
  if configs == nil then
    print("Filetype \"" .. ft .. "\" has no dap configs")
    return
  end
  local mConfig = nil
  vim.ui.select(
    configs,
    {
      prompt = "Select config to run: ",
      format_item = function(config)
        return config.name
      end
    },
    function(config)
      mConfig = config
    end
  )

  -- redraw to make ui selector disappear
  vim.api.nvim_command("redraw")

  if mConfig == nil then
    return
  end
  vim.ui.input(
    {
      prompt = mConfig.name .. " - with args: ",
    },
    function(input)
      if input == nil then
        return
      end
      local args = vim.split(input, ' ', true)
      mConfig.args = args
      dap.run(mConfig)
    end
  )
end

