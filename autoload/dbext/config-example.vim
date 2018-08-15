" let g:dbext_map_prefix = '\s'
" let g:dbext_map_prefix = 's'
" let g:dbext_map_prefix = 'S'

if 0
    let g:dbext_default_type   = 'mysql'
    let g:dbext_default_user   = 'testor'
    let g:dbext_default_passwd = 'testor'
    let g:dbext_default_dbname = 'vimer'
    let g:dbext_default_extra = '--default-character-set=utf8'
endif

let g:dbext_default_profile_mysql_test = "type=MYSQL:user=testor:passwd=testor:dbname=vimer:host=192.168.1.11:extra=--default-character-set=utf8 -t"
let g:dbext_default_profile_mysql_test_DBI = 'type=DBI:user=testor:passwd=testor:driver=mysql:conn_parms=database=vimer;host=192.168.1.11'
let g:dbext_default_profile_mysql_prod = "type=MYSQL:user=devor:passwd=devor:dbname=vimer:host=192.168.1.12:extra=--default-character-set=utf8 -t"
let g:dbext_default_profile_mysql_prod_DBI = 'type=DBI:user=devor:passwd=devor:driver=mysql:conn_parms=database=vimer;host=192.168.1.12'
let g:dbext_default_profile = 'mysql_test'

" load: 
function! dbext#config#load() abort "{{{
    return 0
endfunction "}}}
