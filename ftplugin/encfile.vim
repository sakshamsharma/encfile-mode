if !exists('g:encfile_shell_cmd')
    let g:encfile_shell_cmd = "bash -c"
endif

if !exists('g:encfile_decrypt_cmd')
    let g:encfile_decrypt_cmd = 'gpg --output - --decrypt'
endif

function! EncfileDecrypt()
    silent !clear

    let b:bufname = bufname("%")

    " Create a FIFO file in RAM to store the decrypted file
    let b:pipename = "." . b:bufname . ".tmppipe"
    call system("mkfifo " . b:pipename)

    " Command to be run in shell to generate the decrypted file in the FIFO file
    let dec_cmd = g:encfile_decrypt_cmd . " " . b:bufname . " 2> /dev/null > " . b:pipename . " &"

    " Wrap the command in a shell to allow file pipes and background processes
    let dec_sys_cmd = g:encfile_shell_cmd . " '" . dec_cmd . "'"

    call system(dec_sys_cmd)

    " Enter new buffer
    enew __Encfile_Mode__

    let b:encfile_name = b:bufname

    normal! ggdG
    setlocal ft=plainencfile

    call append(0, split(system("cat " . b:pipename), '\v\n'))

    " Remove the pipe
    echom system("rm " . b:pipename)
endfunction

call EncfileDecrypt()
