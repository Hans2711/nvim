vim.api.nvim_create_user_command('AICommit', function()
    vim.cmd('terminal bash ~/ntgd/scripts/generate_commit_message.sh')
end, {})

vim.api.nvim_create_user_command('AICommitAuto', function()
    vim.cmd('terminal ntgd -ac')
end, {})

