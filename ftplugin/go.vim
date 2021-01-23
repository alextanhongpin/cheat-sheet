"Set Golang
let g:go_highlight_structs = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
let g:go_list_type = "quickfix"
"let g:go_fmt_command = "goimports"
"Faster
let g:go_fmt_command = "gofmt"
let g:go_fmt_autosave = 1

"Configure golang-jump (default: guru) for faster performance.
"let g:go_def_mode='godef'

"Use old regex engine (? faster)
"set re=1

augroup golang
	autocmd!
	autocmd FileType go nmap <leader>t <Plug>(go-test)
	autocmd FileType go nmap <Leader>i <Plug>(go-info)
	" autocmd FileType go nmap <leader>r <Plug>(go-run)
	autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
	autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
augroup END

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
