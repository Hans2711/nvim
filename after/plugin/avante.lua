local avante = require('avante')
avante.setup({
    ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
    provider = "openai",
    auto_suggestions_provider = "openai",
    cursor_applying_provider = nil,

    providers = {
        openai = {
            endpoint = "https://api.openai.com/v1",
            model = "gpt-4o-mini-2024-07-18",
            timeout = 30000,
            extra_request_body = {
                temperature = 0,
                max_completion_tokens = 16384,
                reasoning_effort = "medium",
            },
        },
    },

    dual_boost = {
        enabled = false,
        first_provider = "openai",
        second_provider = "copilot",
        prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
        timeout = 60000,
    },

    behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true,
        enable_token_counting = true,
        enable_cursor_planning_mode = false,
    },

    mappings = {
        diff = {
            ours = "co",
            theirs = "ct",
            all_theirs = "ca",
            both = "cb",
            cursor = "cc",
            next = "]x",
            prev = "[x",
        },
        suggestion = {
            accept = "<M-l>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
        },
        jump = {
            next = "]]",
            prev = "[[",
        },
        submit = {
            normal = "<CR>",
            insert = "<C-s>",
        },
        sidebar = {
            apply_all = "A",
            apply_cursor = "a",
            retry_user_request = "r",
            edit_user_request = "e",
            switch_windows = "<Tab>",
            reverse_switch_windows = "<S-Tab>",
            remove_file = "d",
            add_file = "@",
            close = { "<Esc>", "q" },
            close_from_input = nil,
        },
    },

    hints = { enabled = true },

    windows = {
        position = "right",
        wrap = true,
        width = 30,
        sidebar_header = {
            enabled = true,
            align = "center",
            rounded = true,
        },
        input = {
            prefix = "> ",
            height = 8,
        },
        edit = {
            border = "rounded",
            start_insert = true,
        },
        ask = {
            floating = false,
            start_insert = true,
            border = "rounded",
            focus_on_apply = "ours",
        },
    },

    highlights = {
        diff = {
            current = "DiffText",
            incoming = "DiffAdd",
        },
    },

    diff = {
        autojump = true,
        list_opener = "copen",
        override_timeoutlen = 500,
    },

    suggestion = {
        debounce = 600,
        throttle = 600,
    },
})
