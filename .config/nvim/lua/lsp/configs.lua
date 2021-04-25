local nvim_lsp = require('lspconfig')
local saga = require('lspsaga')

saga.init_lsp_saga({
    dianostic_header_icon = "   ",
    code_action_icon = " ",
    finder_definition_icon = "  ",
    finder_reference_icon = "  ",
    definition_preview_icon = "  ",
    border_style = 'single',
    rename_prompt_prefix = "❱❱",
    })

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'K', '<Cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
    buf_set_keymap('n', '<C-f>', '<Cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', opts)
    buf_set_keymap('n', '<C-d>', '<Cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', opts)
    buf_set_keymap('n', 'ga', '<CMD>lua require("lspsaga.codeaction").code_action()<CR>', opts)
    buf_set_keymap('v', 'ga', "<CMD>'<, '>lua require('lspsaga.codeaction').code_action()<CR>", opts)
    buf_set_keymap('n', 'gs', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
    buf_set_keymap('n', 'gh', '<CMD>lua require("lspsaga.provider").lsp_finder()<CR>', opts)
    buf_set_keymap("n", "gd", '<CMD>lua require("lspsaga.provider").preview_definition()<CR>', opts)
    buf_set_keymap('n', '[d', '<CMD>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<CMD>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=#4c566a
        hi LspReferenceText cterm=bold ctermbg=red guibg=#4c566a
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=#4c566a
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end
end

-- sumneko lua
local sumneko_root_path = "/home/kasf/github/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
nvim_lsp.sumneko_lua.setup {
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";")
            },
            diagnostics = {
                globals = {
                    "vim",
                    "use"
                }
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
            telemetry = {
                enable = false
            },
        }
    }
}

-- python
nvim_lsp.jedi_language_server.setup {
    on_attach = on_attach,
    init_options = {
        completion = {
            disableSnippets = false
        },
        diagnostics = {
            enable = true,
            didOpen = true,
            didChange = true,
            didSave = true
        },
        jediSettings = {
            caseInsensitiveCompletion = true
        },
        markupKindPreferred = "markdown",
        workspace = {
            symbols = {
                ignoreFolders = {".nox", ".tox", ".venv", "__pycache__", "venv"},
                maxSymbols = 20
            }
        }
    }
}

-- gopls
nvim_lsp.gopls.setup {
    on_attach = on_attach
}

-- efm
local python_flake8 = {
    lintCommand = "flake8 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"}
}

local python_pylint = {
    lintCommand = "pylint ${INPUT}",
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %m" }
}

nvim_lsp.efm.setup {
    filetypes = { "python" },
    init_options = { documentFormatting = true },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            python = { python_flake8, python_pylint }
        }
    }
}
