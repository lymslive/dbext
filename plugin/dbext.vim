if !exists('g:loaded_dbext')
    " call dbext#plugin#load()
    execute 'source ' expand('<sfile>:p:h:h') . '/autoload/dbext/plugin.vim'
    " echo expand('<sfile>:p:h:h') . '/autoload/dbext/plugin.vim'
endif
