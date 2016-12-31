if !exists("g:encfile_encrypt_cmd_start")
    let g:encfile_encrypt_cmd_start = 'gpg --output'
endif

if !exists("g:encfile_encrypt_cmd_end")
    let g:encfile_encrypt_cmd_end = '--symmetric --yes -'
endif

" Writes the contents to the encrypted file
function! EncfileUpdate()
    silent !clear

    " If this is a new file being created
    if !exists("b:encfile_name")
        let b:encfile_name = input('File name: ') . '.encfile'
        while b:encfile_name == ".encfile"
            let b:encfile_name = input('File name: ') . '.encfile'
        endwhile
    endif

    " Output the buffer contents on STDIN to the decryption program
    execute 'w !cat | ' . g:encfile_encrypt_cmd_start . ' ' . b:encfile_name . ' ' . g:encfile_encrypt_cmd_end
endfunction

" Wrapped to handle vim states for the buffer on write
function! EncfileBufWriter()
    call EncfileUpdate()
    setlocal nomodified
endfunction

nnoremap <buffer> <Space>w :call EncfileBufWriter()<cr>
autocmd BufWriteCmd * :call EncfileBufWriter()
