# Database Access from Vim Buffer

This is tailor plugin based on `dbext`, "forked" from the version 2600 at:
[https://www.vim.org/scripts/script.php?script_id=356](https://www.vim.org/scripts/script.php?script_id=356)
While the respository in github seams to stop update sice version 2300 at:
[https://github.com/vim-scripts/dbext.vim](https://github.com/vim-scripts/dbext.vim)

The origin dbext is a global and large plugin, supported to excute SQL from
each buffer or ex command line (via many dbms). It is not only for edting
`.sql` files, but for any program language on the project that revolves
databse operation, help to lookup table definition, preview data in table,
test SQL statements when working on the host language. 
See [readme23.md](reademe23.md) and `:help dbext`.

I rearrange some file directory structure, make it fitable to load dynamically
just when needed. And will fix some bug or feature, more or less.

Vim7 is enough to use `dbext`. In Vim8 support job to connect to databse and
execute SQL statement. When vim complied with `+perl` feature, support to keep
connection to databse with DBI (a perl module).

## Install and start to use

### Common manual instruction
At the least manual case, download the subdirectory `autoload`, and put it
under `~/.vim` or any other path in you `&rtp`. Then use the command below to
load this plugin to play with all the funny, back compatible with `dbext` :

```vim
: call dbext#plugin#load()
```

If you really want to use `dbext` in every vim session, fell free to add this
command to your `vimrc` as you like. I usually reduce this to a simpler
command `:PI dbext` with a actually simple plugin(or tricky) of mine: 
[https://github.com/lymslive/autoplug](https://github.com/lymslive/autoplug)

### Normal install routine
From vim8, the offical way to install a plugin is suggested like below:

```bash
$ make -p ~/.vim/pack/lymslive/opt
$ cd ~/.vim/pack/lymslive/opt
$ git clone https://github.com/lymslive/dbext
$ vim -u NONE  -c 'helptags doc' -cq
```

Then any time in vim, use command `:packadd dbext` to load this plugin, or
of course can add it to `vimrc`. The subdirectory name of first level under
`pack/` is arbitrary, so git clone to `pack/vim-scripts/opt` or
`pack/dfishburn/opt` are also ok. But the second level name is matters. If
clone to `pack/*/start` directory, the plugin will automatically load when vim
is starting, and no need `:packadd dbext` any more. It depends on users'
taste, but I think many large plugin is not needed in every vim session, and
prefer to `opt/`. (see `:help packadd`)

### Advanced plugin manager install
This plugin is also suitable for many other famous plugin manager. If you have
been using any such tool, just go. But it may not be simple to support dynamic
load as the builtin `:packadd`.

If you, say typically install in `~/.vim/budle` by other plugin manager, and
you donnot want to load `dbext` very time starting vim, then you can put this
command in `vimrc` :

```vim
let g:loaded_dbext = 1
```

This will suppress loading `dbext` futher, avoid to import any maps, commands
and variables from `dbext` into you vim environment. Then time comes that you
want to do some funny thing with databse, excute `:call dbext#plugin#load()` .

## Configure dbext

Before work well, `dbext` need databse connection information. It is suggested
to define (may a series of) profile with global variable
`g:_dbext_default_profile_{custome_name}` . Another important variable is
`g:dbext_map_prefix` to config map leading, which is `<Leader>s` by default.

You can simplly put such config in you `vimrc`. Or, one of the following methods.

### Dynamic dbext#config#load()

If you prefer to dynamically load `dbext`, it is best to put the relative
config in `~/.vim/autoload/dbext/config.vim` and define a `dbext#config#load()`
function(just remain empty is also fine) in that file. As example:

```vim
let g:dbext_default_profile_mysql_test = "type=MYSQL:user=?:passwd=?:dbname=?:host=192.168.?.?:extra=--default-character-set=utf8 -t"
let g:dbext_default_profile_mysql_test_DBI = 'type=DBI:user=?:passwd=?:driver=mysql:conn_parms=database=?;host=192.168.?.?'
let g:dbext_default_profile_mysql_txjg = "type=MYSQL:user=?:passwd=?:dbname=?:host=192.168.?.?:extra=--default-character-set=utf8 -t"
let g:dbext_default_profile_mysql_txjg_DBI = 'type=DBI:user=?:passwd=?:driver=mysql:conn_parms=database=?;host=192.168.?.?'
let g:dbext_default_profile = 'mysql_test'

function! dbext#config#load()
endfunction
```

Note that `dbext/config.vim` is not necessary in the same directory as the git
cloned respository. Actually it is recommended to put in the first (or very front) 
of your `&rtp` path, and so in linux `~/.vim` is a good place.

Note also that `dbext/config.vim` is designed for dynamic load behavior. If
your plan is load `dbext` with vim starting, obviously it is better to copy
the config into `vimrc` directly, or you *MUST* manually `:call
dbext#config#load()` in `vimrc`.

### Config in local project

Since only some special (may complex) project need to mix programming with
databse, you can put the config for `dbext` in the local project setting. For
example in `Sessionx.vim` file, if you `:mksession` on the project root
directory and save a `Session.vim` file. When vim load a session, it will
source another `{SessionName}x.vim` file if exsisted.

You may have other methods, or plugin tool to manage project, that is OK.

## Diff with dbext

Besides `doc/` , the origin `dbext` plugin contains mainly three vim files,
each with thousands of lines.

* plugin/dbext.vim
* autoload/dbext.vim
* autoload/dbext_dbi.vim

I add another subdirectory `autoload/dbext` and move the "main" plugin file to it.

```bash
$ mv plugin/dbext.vim autoload/dbext/dbext.vim
```

The origin `plugin/dbext.vim` is replaced a very simple one to fit dynamic
load behavior, Something like below:

```vim
call dbext#plugin#load()
```

That means there is another `autoload/dbext/plugin.vim` file.

After plugin is load successfully, no matter when starting vim or dynamically
load later, just used as before, since the plugin name is still called
`dbext`, as well as function names and command names.

## Extra features

* using special configed vim as inner $EDITOR in mysql shell (`\e`).
  See [visql.vim](vimrc/visql.vim). Only mysql tested.

## Other patch or fixes

* add support utf8 character(汉字) within `dbext_dbi`
* fix cpp/c filetype, support printf style SQL statement in such source code.
* add option `MYSQL_desc_table_full` that desc table with comment
* add option `keep_in_result_buffer` usefull to view long result
* set Result buffer as nofile and hide
