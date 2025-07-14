" Vim plugin: vim-open-explorer
" Description: Opens Windows Explorer with the current file focused
" Author: benstaniford
" License: MIT

if has('win32') || has('win64')
  function! OpenExplorer()
    let l:filepath = expand('%:p')
    if filereadable(l:filepath)
      let l:cmd = 'explorer /select,"' . substitute(l:filepath, '/', '\\', 'g') . '"'
      silent execute '!'.l:cmd
    else
      echoerr 'No file to open in Explorer.'
    endif
  endfunction
  command! Explorer call OpenExplorer()
else
  function! OpenExplorer()
    " Do nothing on non-Windows
  endfunction
  command! Explorer call OpenExplorer()
endif
