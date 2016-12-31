""
" Sets the current buffer as a plain-mode encfile buffer.
" Executing this would hijack the write-file hook to instead save
" the file in encrypted form.
function! EncfileNew()
    enew __Encfile_mode__
    setlocal ft=plainencfile
    file encfile_tmp
endfunction

""
" Sets the current buffer as a plain-mode encfile buffer.
" Executing this would hijack the write-file hook to instead save
" the file in encrypted form.
command EncfileNew call EncfileNew()
