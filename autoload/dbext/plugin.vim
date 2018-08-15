" do not load extra config in vim starting phase
" suppose already configed in vimrc
if v:vim_did_enter
    call dbext#config#load()
endif

" load the origin plugin/dbext.vim
" mainly define UI: maps, commands and menus.
execute 'source ' expand('<sfile>:p:h') . '/dbext.vim'
