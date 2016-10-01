let g:go_list_type = "quickfix"
let g:go_jump_to_error = 1
let g:go_fmt_autosave = 0

au FileType go map <F9> :GoFmt<CR>
