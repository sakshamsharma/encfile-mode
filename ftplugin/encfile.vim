function! EncfileDecrypt()
    silent !clear

    let sname = bufname("%")
    
    echom system("mkfifo ." . sname . ".tmpfile")
    
    let decrypto = "bash -c 'gpg --output - --decrypt " . sname . " 2> /dev/null > ." . sname . ".tmpfile &'"
    echom system(decrypto)

    enew __Encfile_Mode__

    let b:encfile_name = sname

    normal! ggdG
    setlocal buftype=nofile
    setlocal ft=plainencfile

    call append(0, split(system("cat ." . sname . ".tmpfile"), '\v\n'))

    echom system("rm ." . sname . ".tmpfile")
endfunction

nnoremap <buffer> <Space>c :call EncfileDecrypt()<cr>

call EncfileDecrypt()
