# encfile-mode

Safely manipulate encrypted files without leaving a trace

```
                     __  _  _
                    / _|(_)| |
  ___  _ __    ___ | |_  _ | |  ___
 / _ \| '_ \  / __||  _|| || | / _ \
|  __/| | | || (__ | |  | || ||  __/
 \___||_| |_| \___||_|  |_||_| \___|
```

# Introduction

Lets you create, read and save encrypted files as if they were in plaintext.
What's more, does not store the plaintext on the hard disk EVER, thus preventing anyone from recovering the contents through recovery tools.

**NOTE**: Uses FIFO pipes to store temporary data in RAM.

# Usage
## Creating an encrypted file
Creating a file is as simple as firing up Vim and running `:EncfileNew`

**Other ways**
* `:call EncfileNew()`
* `vim .plainencfile`

## Saving the file
As you would expect, simply save the file any way you want to. If you created a new file, it may prompt you for a name.

**NOTE**: If you provide the name as `test`, the final file would be stored as `test.encfile`.

# Requirements
The default settings use symmetric encryption using GnuPG. And thus, you should have a recent version of `gpg` installed.

All the commands can be customized through variables, and you can use other encryption techniques if you want to.

# Installation
This is the 21st century. I hope you use [vundle](https://github.com/VundleVim/Vundle.vim) or [vim-plug](https://github.com/junegunn/vim-plug).

```
# For Vundle users
Plugin 'sakshamsharma/encfile-mode'

# For vim-plug users
Plug 'sakshamsharma/encfile-mode'
```
