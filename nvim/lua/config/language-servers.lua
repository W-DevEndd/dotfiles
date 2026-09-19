
--- @type table<string,vim.lsp.Config>
local servers = {
    "pyright",
    "lua_ls",
    "ts_ls",
    "html",
    "clangd",
    "hyprls",
    "jsonls",
    "cssls",
    qmlls = {
        cmd = {"qmlls6"},
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
                formatting = {
                    command = { "alejandra" },
                },
                options = {
                    nixos = {
                        expr = "(import <nixpkgs/nixos> { configuration = {}; }).options",
                    },
                },
            },
        },
    }
}

return servers
