" This file is loaded whenever this plugin loads up.
" It stores the globally available functions and commands of this plugin.


""
" @section Introduction, intro
" encfile-mode is intended for storing important information in encrypted form
" on your machine. It solves two problems:
" 1. Repeatedely having to encrypt and decrypt for editing/viewing purposes.
" 2. Decrypting to hard disk, which leaves traces.
"
" encfile-mode wraps this functionality in a single plugin, which handles
" encrypted files as if they were plain text. Opening .encfile format files
" and saving works as you would expect for plaintext files.

""
" Sets the current buffer as a plain-mode encfile buffer.
" Executing this would hijack the write-file hook to instead save
" the file in encrypted form.
function! EncfileNew()
    enew
    setlocal ft=plainencfile
    file encfile_tmp
endfunction

""
" @section Commands, commands
" There is a single command, @command(EncfileNew), to let you create an
" encrypted file.

""
" Sets the current buffer as a plain-mode encfile buffer.
" Executing this would hijack the write-file hook to instead save
" the file in encrypted form.
command EncfileNew call EncfileNew()
