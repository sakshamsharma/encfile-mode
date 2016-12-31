if !exists("g:encfile_encrypt_cmd_start")
    let g:encfile_encrypt_cmd_start = 'gpg --output'
endif

if !exists("g:encfile_encrypt_cmd_end")
    let g:encfile_encrypt_cmd_end = '--symmetric -'
endif

if !exists("g:encfile_overwrite")
    let g:encfile_overwrite = ''
endif

if !exists("g:encfile_format")
    let g:encfile_format = '.gpg'
endif

""
" Writes the contents to the encrypted file back to HDD
" Encrypts by default using gpg --output <file> --symmetric --yes -
" Is called by default on any write action in this buffer.
function! EncfileUpdate()
    silent !clear

    " If this is a new file being created
    if !exists("b:encfile_name")
        let b:encfile_name = input('File name: ') . g:encfile_format
        while b:encfile_name == g:encfile_format
            let b:encfile_name = input('File name: ') . g:encfile_format
        endwhile
    endif

    " Output the buffer contents on STDIN to the decryption program
    execute 'w !cat | ' . g:encfile_encrypt_cmd_start . ' ' . b:encfile_name . ' ' . g:encfile_overwrite . g:encfile_encrypt_cmd_end

    let g:encfile_overwrite = ' --yes '
endfunction

""
" Wrapper to handle vim states for the buffer on write
" Used as the default BufWriteCmd handler in Vim for such files.
function! EncfileBufWriter()
    call EncfileUpdate()
    setlocal nomodified
endfunction

autocmd BufWriteCmd * :call EncfileBufWriter()
