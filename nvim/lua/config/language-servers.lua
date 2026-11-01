
--- @type table<string,vim.lsp.Config>
local servers = {
    "pyright",
    "lua_ls",
    "ts_ls",
    "html",
    "ccls",
    "hyprls",
    "jsonls",
    "cssls",
    qmlls = {
        cmd = {"qmlls"},
        filetypes = { "qml" },
        settings = {
            qml = {
              importPaths = { "/usr/lib/qt6/qml" }
            }
        }
    },
    nixd = {
        cmd = {"nixd"},
        filetypes = { "nix" },
        settings = {
            nixd = {
                nixpkgs = {
                    expr = "import <nixpkgs> {}",
                },
                options = {
                    nixos = {
                        expr = '(import <nixpkgs> {}).nixosSystem { modules = [ ]; }',
                        ["home-manager"] = {
                            expr = '(import <nixpkgs> {}).home-manager.lib.homeManagerConfiguration { modules = [ ]; }',
                        },
                    },
                },

                formatting = {
                    command = { "alejandra" },
                },
            },
        },
    }
}

return servers
