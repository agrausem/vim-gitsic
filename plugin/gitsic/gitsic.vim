"
" Gitsic plugin
"
"   * functions to manage buffers
"   * command to launch a git status in a buffer that enables some great
"     functionnalities (see ftplugin/gitic.vim)
"


function! GetOrCreateBuffer(buffer, filetype, split)
    " Get or create a new buffer
    "
    " buffer :
    "   the name you want to set for the buffer to open
    " filetype :
    "   the type of the file contained in the future buffer
    " split :
    "   if you want a new vertical splitted window or not

    if bufexists(a:buffer)
        if !a:split
            execute 'buffer' a:buffer
            %delete
        else
            execute 'bdelete!' a:buffer
            vsplit
            call NewBuffer(a:buffer, a:filetype)
        endif
    else
        if a:split
            vsplit
        endif
        call NewBuffer(a:buffer, a:filetype)
    endif
endfunction


function! NewBuffer(buffer, filetype)
    " Create a new buffer
    "
    " buffer :
    "   the name you want to set for the buffer to open
    " filetype :
    "   the type of the file contained in the future buffer
    
    enew
    execute 'file' a:buffer
    execute 'setfiletype' a:filetype
endfunction


command GitStatus call GetOrCreateBuffer('gitstatus', 'gitsic', 0)
                \| %! git status -s | grep -v '\.swp$'

nnoremap gs :GitStatus<CR>
