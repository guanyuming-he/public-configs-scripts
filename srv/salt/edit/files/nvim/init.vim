" line numbering on
set number
" display tab as 4 spaces (the default is 8).
set tabstop=4 softtabstop=4
" always use tabs, not spaces. This is for inclusivity. Different people who
" prefer different widths can simply modify the setting in their editors.
set noexpandtab
" To force Python use this setting as well.
" Why this variable? Well, check /usr/share/vim/vimxx/ftplugin/python.vim
let g:python_recommended_style=0
" make < and > also move 4 spaces, consistent with a tab.
" (the default was 8)
set shiftwidth=4
" line break on the 80th character
set textwidth=79 " also tw
set formatoptions+=t " also fo

" Do not automatically insert the completion item
set completeopt+=noinsert

" The semicolon makes Vim searches upwards in all parent dirs.
set tags+=./tags;

vim.lsp.enable('clangd')
