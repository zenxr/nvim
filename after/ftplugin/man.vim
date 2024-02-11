" Set file type-specific settings
setlocal filetype=man

" Define the function to open man page
if !exists('*CwordMan')
    function! CwordMan(splitType)
        " Set a temporary variable
        let word = expand('<cword>')
        " Open a new split and load the man page
        execute a:splitType . ' | Man ' . word
    endfunction
endif

nnoremap <buffer> gvd :call CwordMan('vsplit')<CR> 
nnoremap <buffer> gsd :call CwordMan('split')<CR> 
nnoremap <buffer> gd :Man expand(<cword>)<CR>
