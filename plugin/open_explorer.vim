" Vim plugin: vim-open-explorer
" Description: Opens Windows Explorer with the current file focused
" Author: benstaniford
" License: MIT

if has('win32') || has('win64')
  function! s:ToWindowsPath(target) abort
    let l:cygpath_cmd = 'cygpath -wa ' . a:target
    let l:cygpath = system(l:cygpath_cmd)
    if v:shell_error
      let l:cygpath_cmd = '"C:/Program Files/Git/usr/bin/cygpath.exe" -wa ' . a:target
      let l:cygpath = system(l:cygpath_cmd)
    endif
    return substitute(l:cygpath, '\%x0a', '', 'g')
  endfunction

  function! OpenExplorer(...) abort
    if a:0 > 0 && !empty(a:1)
      let l:target = s:ToWindowsPath(a:1)
      echo 'Opening Explorer for: ' . l:target
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

  function! s:ExComplete(A, L, P) abort
    let l:pat = a:A
    if stridx(l:pat, '~') == 0
      let l:pat = expand(l:pat)
    endif
    let l:globres = glob(l:pat.'*', 0, 1)
    if type(l:globres) != type([])
      let l:globres = []
    endif
    if empty(l:globres)
      return []
    endif
    return map(l:globres, 'isdirectory(v:val) ? v:val."/" : v:val')
  endfunction

  command! -nargs=? -complete=customlist,s:ExComplete Ex call OpenExplorer(<f-args>)
endif
