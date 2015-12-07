
command GitDiff .yank 
             \| call GetOrCreateBuffer('gitdiff', 'diff', 1)
             \| 0put
             \| 0s/\v\s?[AMDU?]{1,2}\s/git diff /g
             \| 0!bash


function! Gitadd(count)
    let actualLine=line('.')
    let lines=getline(actualLine,actualLine + a:count - 1)
    let pattern='\v[ ?][M?]\s(.*)'
    let s:filestoadd=''
    for line in lines
        if line =~ pattern
            let s:filestoadd = s:filestoadd.' '.substitute(line, pattern, ' \1', '')
    endfor
    '!git add'.s:filestoadd
endfunction


command -count=1 GitAdd call Gitadd(<count>)


command GitReset 0s/\v\s?[AMDU?]{1,2}\s/git reset HEAD /g
              \| 0!bash 


nnoremap gd :GitDiff<CR>
nnoremap ga :GitAdd<CR>:GitStatus<CR>
nnoremap gr :GitReset<CR>:GitStatus<CR>
