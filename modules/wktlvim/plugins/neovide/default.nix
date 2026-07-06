{
  extraConfigLuaPre = ''
    if vim.g.neovide then
      -- copy_to_clipboard
      vim.keymap.set('v', '<C-S-c>', '"+y', { noremap = true, silent = true })

      -- paste_from_clipboard
      vim.keymap.set('i', '<C-S-v>', '<C-r>+', { noremap = true, silent = true })
      vim.keymap.set('n', '<C-S-v>', '"+p', { noremap = true, silent = true })

      -- paste_from_clipboard in cmd model
      vim.keymap.set('c', '<C-S-v>', '<C-R>+', { noremap = true, silent = true })

      -- paste_from_clipboard in terminal model
      vim.keymap.set('t', '<C-S-v>', '<C-\\><C-n>"+pi', { noremap = true, silent = true })
    end
  '';
}
