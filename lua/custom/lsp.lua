local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then desc = "LSP: " .. desc end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    -- wrap the require("telescope.builtin") in an anonymus function to lazy load
    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    nmap("gd", function() require("telescope.builtin").lsp_definitions() end, "[G]oto [D]efinition")
    nmap("gr", function() require("telescope.builtin").lsp_references() end, "[G]oto [R]eferences")
    nmap("gI", function() require("telescope.builtin").lsp_implementations() end, "[G]oto [I]mplementation")
    nmap("<leader>D", function() require("telescope.builtin").lsp_type_definitions() end, "Type [D]efinition")
    nmap("<leader>ds", function() require("telescope.builtin").lsp_document_symbols() end, "[D]ocument [S]ymbols")
    nmap("<leader>ws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
        "[W]orkspace [S]ymbols")

    -- See `:help K` for why this keymap
    -- nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-h>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end


-- Enable the following language servers. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question
local servers = {
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = { disable = { "missing-fields" } },
        },
    },
}


-- Configure LSP
-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup({
    ui = {
        border = "rounded",
        icons = {
            package_installed = "[v]",
            package_pending = "[~]",
            package_uninstalled = "[x]",
        },
    },
})
require("mason-lspconfig").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

local handlers = {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
    ["phpactor"] = function()
        require("lspconfig")["phpactor"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end
}

mason_lspconfig.setup({ handlers = handlers })

require("lspconfig").dartls.setup({})
require("lspconfig").texlab.setup({})
require("lspconfig").clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
    -- init_options = {
    --     fallbackFlags = { '-std=c++17' },
    -- },
})

-- UI Customization
local lsph = vim.lsp.handlers
local lspw = vim.lsp.with
lsph["textDocument/hover"] = lspw(lsph.hover, { border = "rounded" })
lsph["textDocument/signatureHelp"] = lspw(lsph.signature_help, { border = "rounded" })
vim.diagnostic.config({ float = { border = "rounded" } })
require("lspconfig.ui.windows").default_options.border = "rounded"

-- -- Use only if you need PHP lsp
-- local Float = require "plenary.window.float"
-- local function showWindow(title, syntax, contents)
--     local out = {};
--     for match in string.gmatch(contents, "[^\n]+") do
--         table.insert(out, match);
--     end
--
--     local float = Float.percentage_range_window(0.6, 0.4, { winblend = 0 }, {
--         title = title,
--         topleft = "╭",
--         topright = "╮",
--         top = "─",
--         left = "│",
--         right = "│",
--         botleft = "╰",
--         botright = "╯",
--         bot = "─",
--     })
--
--     vim.api.nvim_buf_set_option(float.bufnr, "filetype", syntax)
--     vim.api.nvim_buf_set_lines(float.bufnr, 0, -1, false, out)
-- end
--
-- function LspPhpactorDumpConfig()
--     local results, _ = vim.lsp.buf_request_sync(0, "phpactor/debug/config", { ["return"] = true })
--     for _, res in pairs(results or {}) do
--         showWindow("Phpactor LSP Configuration", "json", res["result"])
--     end
-- end
--
-- function LspPhpactorStatus()
--     local results, _ = vim.lsp.buf_request_sync(0, "phpactor/status", { ["return"] = true })
--     for _, res in pairs(results or {}) do
--         showWindow("Phpactor Status", "markdown", res["result"])
--     end
-- end


-- Configure Linter
require("lint").linters_by_ft = {
    sh = { "shellcheck" },
}

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
    callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint()

        -- You can call `try_lint` with a linter name or a list of names to always
        -- run specific linters, independent of the `linters_by_ft` configuration
        -- require("lint").try_lint("cspell")
    end,
})

-- local util = require "formatter.util"
-- require("formatter").setup({
--     filetype = {
--         c = {
--             function ()
--                 return {
--                     exe = "clang-format",
--                     args = {
--                         "-style='{ColumnLimit: 0, AlignArrayOfStructures: Left, AlignConsecutiveAssignments: {Enabled: true, AcrossEmptyLines: true, AcrossComments: false, AlignCompound: true, PadOperators: true}, AlignConsecutiveBitFields: AcrossEmptyLinesAndComments, AlignConsecutiveDeclarations: {Enabled: true, AcrossEmptyLines: true, AcrossComments: false} , AlignConsecutiveMacros: AcrossEmptyLinesAndComments, AlignOperands: true, AlignTrailingComments: {Kind: Always, OverEmptyLines: 2}, AlignEscapedNewlines: LeftWithLastLine, SkipMacroDefinitionBody: true}'",
--                         "-assume-filename",
--                         util.escape_path(util.get_current_buffer_file_name()),
--                     },
--                     stdin = true,
--                     try_node_modules = true,
--                 }
--             end
--         },
--     }
-- })
