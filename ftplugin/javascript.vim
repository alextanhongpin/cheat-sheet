
" Universal-ctags is required
let g:js_file_import_no_mappings = 0
let g:js_file_import_omit_semicolon = 0
let g:js_file_import_use_fzf = 1
let g:js_file_import_sort_after_insert = 1
set wildignore+=*node_modules/**
set wildignore+=*dist/**
set wildignore+=*build/**

" nmap <C-i> <Plug>(JsFileImport)
" nmap <C-u> <Plug>(PromptJsFileImport)

" Plugin alvan/vim-closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.tsx,*.js,*.vue,*.erb,*.svelte"
let g:closetag_xhtml_filetypes = 'xhtml,js,jsx,tsx'


" Enable folding
set foldmethod=syntax
set foldcolumn=1
let javaScript_fold = 1 "activates fold by JS syntax
set foldlevelstart=99 "start file with all folds opened

" Set space for JavaScript
setlocal ts=2 sw=2 sts=0 expandtab
