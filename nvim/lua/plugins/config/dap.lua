M = function()
    local dap, dapui = require("dap"), require("dapui")
    require("dapui").setup({
        layouts = {
            {
                elements = {
                    { id = "scopes", size = 0.1 },
                },
                size = 7,
                position = "bottom",
            },
        },
        controls = {
            enabled = false
        }
    })
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
    end

    dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode", -- adjust as needed
        name = "lldb",
    }

    dap.adapters.delve = {
        type = 'server',
        port = '${port}',
        executable = {
            command = 'dlv',
            args = { 'dap', '-l', '127.0.0.1:${port}' },
        }
    }

    dap.configurations.rust = {
        {
            name = 'Launch',
            type = 'lldb',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},
        }
    }
    dap.configurations.c = dap.configurations.rust
    dap.configurations.cpp = dap.configurations.rust

    dap.configurations.go = {
        {
            type = "delve",
            name = "Debug",
            request = "launch",
            program = "${file}"
        },
        {
            type = "delve",
            name = "Debug test", -- configuration for debugging test files
            request = "launch",
            mode = "test",
            program = "${file}"
        },
    }
    require("nvim-dap-virtual-text").setup({
        show_stop_reason = false,
    })
end

return M
