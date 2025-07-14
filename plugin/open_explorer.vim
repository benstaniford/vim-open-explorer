" Vim plugin: vim-open-explorer
" Description: Opens Windows Explorer with the current file focused
" Author: benstaniford
" License: MIT

if has('win32') || has('win64')
  function! OpenExplorer(...) abort
    if a:0 > 0 && !empty(a:1)
      let l:target = a:1
      if isdirectory(l:target)
        let l:cmd = 'explorer "' . substitute(fnamemodify(l:target, ':p'), '/', '\\', 'g') . '"'
        silent execute '!'.l:cmd
        return
      endif
    endif
    let l:filepath = expand('%:p')
    if filereadable(l:filepath)
      let l:cmd = 'explorer /select,"' . substitute(l:filepath, '/', '\\', 'g') . '"'
      silent execute '!'.l:cmd
    else
      echoerr 'No file to open in Explorer.'
    endif
  endfunction
  command! -nargs=? Explorer call OpenExplorer(<f-args>)
else
  function! OpenExplorer(...) abort
    " Do nothing on non-Windows
  endfunction
  command! -nargs=? Explorer call OpenExplorer(<f-args>)
endif
