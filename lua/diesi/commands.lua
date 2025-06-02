vim.api.nvim_create_user_command('AICommit', function()
    vim.cmd('terminal bash ~/ntg/scripts/generate_commit_message.sh')
end, {})

vim.api.nvim_create_user_command('AICommitAuto', function()
    vim.cmd('terminal ntg -ac')
end, {})

