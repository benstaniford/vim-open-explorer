" Vim plugin: vim-open-explorer
" Description: Opens Windows Explorer with the current file focused
" Author: benstaniford
" License: MIT

if has('win32') || has('win64')
  function! OpenExplorer(...) abort
    if a:0 > 0 && !empty(a:1)
      let l:target = a:1
      let l:cygpath_cmd = 'cygpath -wa ' . l:target
      let l:cygpath = system(l:cygpath_cmd)
      if v:shell_error
        let l:cygpath_cmd = '"C:/Program Files/Git/usr/bin/cygpath.exe" -wa ' . l:target
        let l:cygpath = system(l:cygpath_cmd)
      endif
      let l:target = substitute(l:cygpath, '\%x0a', '', 'g')
      echo 'Opening Explorer for: ' . l:target
      sleep 1000m
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
