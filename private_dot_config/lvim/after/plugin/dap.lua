lvim.builtin.dap.on_config_done = function(dap)
    dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = { os.getenv("HOME") .. '/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js' }
        -- args = { '~/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js' }
    }
    dap.configurations.php = {
        {
            type = 'php',
            request = 'launch',
            name = 'Listen for Xdebug',
            port = 9003,
            pathMappings = {
                ["/var/www/client/admin/tool/dataflows"] = "${workspaceFolder}",
                -- ["/var/www/${workspaceFolderBasename}"] = "${workspaceFolder}",
            }
        }
    }
end
