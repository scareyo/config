require("just").setup({
    fidget_message_limit = 32, -- limit for length of fidget progress message 
    play_sound = false, -- plays sound when task is finished or failed
    open_qf_on_error = true, -- opens quickfix when task fails
    open_qf_on_run = true, -- opens quickfix when running `run` task (`:JustRun`)
    telescope_borders = { -- borders for telescope window
        prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
    }
})
