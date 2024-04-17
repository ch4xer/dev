return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text'
        },
        config = function()
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

            -- dap.adapters.delve = {
            --     type = 'server',
            --     port = '${port}',
            --     executable = {
            --         command = 'dlv',
            --         args = { 'dap', '-l', '127.0.0.1:${port}' },
            --     }
            -- }

            -- dlv debug -l 127.0.0.1:65510 --headless . -- param1 param2 param3 ...
            dap.adapters.delve = {
                type = "server",
                host = "127.0.0.1",
                port = 65510,
            }


            dap.adapters.python = function(cb, config)
                if config.request == 'attach' then
                    local port = (config.connect or config).port
                    local host = '127.0.0.1'
                    cb({
                        type = 'server',
                        port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                        host = host,
                        options = {
                            source_filetype = 'python',
                        },
                    })
                else
                    cb({
                        type = 'executable',
                        command = os.getenv("VIRTUAL_ENV") .. "/bin/python",
                        args = { '-m', 'debugpy.adapter' },
                        options = {
                            source_filetype = 'python',
                        },
                    })
                end
            end

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

            dap.configurations.go = {
                {
                    type = "delve",
                    name = "Debug",
                    request = "launch",
                    program = "${file}"
                },
                {
                    type = "delve",
                    name = "Debug test",
                    request = "launch",
                    mode = "test",
                    program = "${file}"
                },
                {
                    type = "delve",
                    name = "Attach remote",
                    mode = "remote",
                    request = "attach",
                },
            }

            -- pip install debugpy under VIRTUAL_ENV
            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = "Launch file",

                    program = "${file}",
                    pythonPath = function()
                        local cwd = vim.fn.getcwd()
                        if vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                            return cwd .. '/.venv/bin/python'
                        else
                            return '/usr/bin/python'
                        end
                    end,
                },
            }
            vim.api.nvim_set_hl(0, 'DapStopLine', {fg="#000000",bg='#e0af68'})
            vim.fn.sign_define('DapBreakpoint', {text='', texthl='ErrorMsg'})
            vim.fn.sign_define('DapStopped', {text='', texthl='WarningMsg', linehl='DapStopLine'})
            require("nvim-dap-virtual-text").setup({
                show_stop_reason = false,
            })
        end
    },
}
