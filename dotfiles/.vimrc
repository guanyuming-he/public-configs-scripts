source $VIMRUNTIME/defaults.vim

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

" ------------------------- Plugins (With VimPlug) ------------------------
call plug#begin()

Plug 'lervag/vimtex'
Plug 'whonore/Coqtail'
Plug 'xavierd/clang_complete'

call plug#end()

" ------------------------- Clang complete config ------------------------
let g:clang_library_path='/usr/lib/llvm-19/lib/libclang-19.so.1'
let g:clang_use_library=1
let g:clang_auto_user_options='compile_commands.json'

" ------------------------- Coq editing ------------------------
" Use a color scheme that doesn't mess up the highlighting.
hi def CoqtailChecked ctermbg=30
hi def CoqtailSent    ctermbg=31

" Replace all beautiful characters in Software Foundation
" with the Coq ASCII characters.
function! CoqReplaceChars()
	silent! execute '%s/∀/forall/g'
	silent! execute '%s/∃/exists/g'
	silent! execute '%s/→/->/g'
	silent! execute '%s/↔/<->/g'
	silent! execute '%s/∨/\\\//g'
	silent! execute '%s/∧/\/\\/g'
	silent! execute '%s/⇒/=>/g'
	silent! execute '%s/¬/\~/g'
	silent! execute '%s/×/*/g'
	silent! execute '%s/≥/>=/g'
	silent! execute '%s/≤/<=/g'
	silent! execute '%s/≠/<>/g'
	silent! execute '%s/⊢>/|->/g'
endfunction

