if !exists('g:encfile_shell_cmd')
    let g:encfile_shell_cmd = "bash -c"
endif

if !exists('g:encfile_decrypt_cmd')
    let g:encfile_decrypt_cmd = 'gpg --output - --decrypt'
endif

""
" Decrypts the current buffer using the defined commands.
" Defaults to gpg --output - --decrypt
" Displays the output in a new Vim buffer
function! EncfileDecrypt()
    silent !clear

    let b:bufname = bufname("%")

    " Command to be run in shell to generate the decrypted contents
    let dec_cmd = g:encfile_decrypt_cmd . " " . b:bufname . " 2> /dev/null"

    " Wrap the command in a shell
    let dec_sys_cmd = g:encfile_shell_cmd . " '" . dec_cmd . "'"

    " Enter new buffer
    edit
    setlocal ft=plainencfile

    let b:encfile_name = b:bufname
    let g:encfile_overwrite = ' --yes '

    normal! ggdG

    call append(0, split(system(dec_sys_cmd), '\v\n'))
endfunction

call EncfileDecrypt()
