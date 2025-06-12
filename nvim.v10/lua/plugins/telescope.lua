-- Telescope configuration
return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-live-grep-args.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = "make"
            },
            'debugloop/telescope-undo.nvim',
            {
                'ThePrimeagen/harpoon',
                branch = 'harpoon2',
            }
        },
        config = function()
            local actions = require('telescope.actions')
            -- local utils = require('telescope.utils')
            -- local trouble = require('telescope.providers.telescope')
            local lga_actions = require('telescope-live-grep-args.actions')

            -- harpoon custom action
            local action_state = require("telescope.actions.state")

            local add_to_harpoon = function(prompt_bufnr)
                local entry = require("telescope.actions.state").get_selected_entry()
                local list = require("harpoon"):list()
                local harpoon_config = list.config
                local item = harpoon_config.create_list_item(harpoon_config, entry[1])
                vim.print("Added " .. entry[1] .. " to harpoon")
                list:add(item)
            end

            local remove_from_harpoon = function(prompt_bufnr)
                local entry = require("telescope.actions.state").get_selected_entry()
                local list = require("harpoon"):list()
                local harpoon_config = list.config
                local item = harpoon_config.create_list_item(harpoon_config, entry[1])

                -- local replacement, index = list:get_by_value("")
                -- if replacement == nil then
                --     replacement = harpoon_config.create_list_item(harpoon_config, "")
                -- end

                -- item, index = list:get_by_value(item.value)

                vim.print("Removing " .. entry[1] .. " from harpoon")
                list:remove(item)
                -- list:replace_at(index, replacement)
            end

            local compress_harpoon_list = function(prompt_bufnr)
                local items = {}
                local list = harpoon:list()
                for i = 1, list:length() do
                    local item = list:get(i)
                    if item ~= nil then
                        table.insert(items, item)
                    end
                end

                list:clear()

                for _, item in ipairs(items) do
                    list:add(item)
                end

                vim.print("Reordered harpoon entries")
            end


            require('telescope').setup({
                pickers = {
                    buffers = {
                        mappings = {
                            i = {
                                ['<C-x>'] = "delete_buffer",
                            },
                        },
                    },
                },
                defaults = {
                    sorting_strategy = "ascending",
                    mappings = {
                        i = {
                            -- ['<C-n>'] = actions.move_selection_next,
                            -- ['<C-p>'] = actions.move_selection_previous,
                            ['<C-q>'] = actions.smart_send_to_qflist,
                            -- ['<C-c>'] = actions.smart_send_to_qflist,
                            -- ['<C-a>'] = actions.smart_add_to_qflist,
                            ['<C-a>'] = add_to_harpoon,
                            ['<C-x>'] = remove_from_harpoon,
                            ['<C-s>'] = actions.file_split,
                            -- ['<C-[>'] = actions.close,
                            ['<C-c>'] = actions.close,
                            ['<C-z>'] = actions.close,
                            ['<C-o>'] = actions.cycle_history_prev,
                            ['<C-i>'] = actions.cycle_history_next,
                        },
                        n = {
                            ['<C-a>'] = add_to_harpoon,
                            ['<C-z>'] = actions.close,
                            ['<C-c>'] = actions.close,
                        },
                    },
                    layout_strategy = "flex",
                    layout_config = {
                        prompt_position = "top",
                        flex = {
                            flip_columns = 170,
                        },
                    },
                    -- layout_config = {
                    --   horizontal = {
                    --     height = 47,
                    --     prompt_position = "top",
                    --   }
                    -- }
                },
                extensions = {
                    undo = {
                        mappings = {
                            i = {
                                ["<CR>"] = require "telescope-undo.actions".restore,
                                ["<C-y>"] = require "telescope-undo.actions".yank_additions,
                                ["<C-S-y>"] = require "telescope-undo.actions".yank_deletions,
                            },
                            n = {
                                ["<CR>"] = require "telescope-undo.actions".restore,
                                ["<C-y>"] = require "telescope-undo.actions".yank_additions,
                                ["<C-S-y>"] = require "telescope-undo.actions".yank_deletions,
                            },
                        },
                    },
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                    live_grep_args = {
                        disable_devicons = true,
                        auto_quoting = true,
                        mappings = {
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                            },
                        },
                    },
                },
            })

            require('telescope').load_extension('fzf')
            require('telescope').load_extension('undo')
        end
    },

    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            local harpoon = require('harpoon')
            harpoon:setup({})

            local conf = require("telescope.config").values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for i = 1, harpoon_files._length do
                    local item = harpoon_files.items[i]
                    if item ~= nil then
                        table.insert(file_paths, item.value)
                    else
                        table.insert(file_paths, "")
                    end
                end

                -- for _, item in ipairs(harpoon_files.items) do
                --     table.insert(file_paths, item.value)
                -- end

                require("telescope.pickers").new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                }):find()
            end

            local order_harpoon_list = function(list)
                local items = {}
                for i = 1, list:length() do
                    local item = list:get(i)
                    if item ~= nil then
                        table.insert(items, item)
                    end
                end

                list:clear()

                for _, item in ipairs(items) do
                    list:add(item)
                end

                vim.print("Reordered harpoon entries")
            end

            vim.keymap.set("n", "<leader>ht", function() toggle_telescope(harpoon:list()) end,
                { desc = "Open harpoon telescope window" })
            vim.keymap.set("n", "<leader>hs", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                { desc = "Open harpoon window" })
            vim.keymap.set(
                "n", "<leader>ha",
                function()
                    local list = harpoon:list()
                    list:add()
                    vim.print("Added " .. list:get(list:length() - 1).value .. " to harpoon")
                end,
                { desc = "Add to harpoon" }
            )
            vim.keymap.set("n", "<leader>hc", function()
                    harpoon:list():clear()
                    vim.print("Cleared harpoon")
                end,
                { desc = "Clear harpoon" })
            vim.keymap.set("n", "<leader>ho", function() order_harpoon_list(harpoon:list()) end,
                { desc = "Order harpoon" })
            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, {})
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, {})
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, {})
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, {})
            vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, {})
            vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end, {})
            vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end, {})
            vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end, {})
            vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end, {})

            vim.keymap.set("n", "]h", function() harpoon:list():next() end, {})
            vim.keymap.set("n", "[h", function() harpoon:list():prev() end, {})
        end
    },
}
