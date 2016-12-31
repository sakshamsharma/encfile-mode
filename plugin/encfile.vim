function! EncfileNew()
    setlocal ft=plainencfile
    autocmd BufWriteCmd * :call EncfileBufWriter()
endfunction
