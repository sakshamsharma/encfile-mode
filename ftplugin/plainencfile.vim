setlocal buftype=nofile

function! EncfileUpdate()
    silent !clear

    if !exists("b:encfile_name")
        let b:encfile_name = input('File name: ') . '.encfile'
        while b:encfile_name == ".encfile"
            let b:encfile_name = input('File name: ') . '.encfile'
        endwhile
    endif

    execute 'w !cat | gpg --output ' . b:encfile_name . ' --symmetric --yes -'
endfunction

nnoremap <buffer> <Space>w :call EncfileUpdate()<cr>
