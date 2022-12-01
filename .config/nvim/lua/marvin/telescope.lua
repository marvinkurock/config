require('telescope').setup {
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        layout_strategy = "vertical",
        layout_config = {
            vertical = { width = 0.9 }
        },
        -- Default configuration for telescope goes here:
        -- config_key = value,
        file_ignore_patterns = {
            "node_modules",
            ".git/"
        },
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key",
                ["<C-q>"] = require("telescope.actions").send_selected_to_qflist,
            },
            n = {
                ["<C-q>"] = require("telescope.actions").send_selected_to_qflist,
            }
        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
        find_files = {
            hidden = true
        },
        live_grep = {
            additional_args = function(opts)
                return { "--hidden" }
            end
        }
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    }
}
require('telescope').load_extension('dap')
