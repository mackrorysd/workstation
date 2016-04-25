
if exists("foldenable")
    set foldenable
    set foldmethod=manual
endif
function FoldBraceAndComment()
        if line('.')!=line('$')
                normal ^
                let current = line('.')
                let found_brace = search("{","W")
                let brace_start = found_brace == 0 ? line('$') : line('.')
                call setpos('.',[0,current,1,0])
                let found_javadoc = search("\\/\\*","W")
                let javadoc_start = found_javadoc == 0 ? line('$') : line('.')
                call setpos('.',[0,current,1,0])
                let next_start = brace_start < javadoc_start ? brace_start : javadoc_start
                call setpos('.',[0,next_start,1,0])
                if foldlevel('.') == 0
                        let x = line('.')
                        if brace_start < javadoc_start
                                normal $
                                normal %
                        else
                                call search("\\*\\/","W")
                        endif
                        let y = line('.')
                        if x < y
                                execute x . "," . y . " fold"
                                normal j
                        elseif x == y
                                normal j
                        endif
                else
                        normal zd
                endif
        endif
endfunction

function ClearFold()
        while foldlevel('.') == 0 && line('.')!=line('$')
                normal j
        endwhile
        if foldlevel('.') != 0
                normal zd
        endif
endfunction

map <C-I> :call FoldBraceAndComment()<CR>
map <C-O> :call ClearFold()<CR>
map <C-L> :TlistToggle<CR>
map <C-P> <F12>
map <C-B> :shell<CR>

au BufRead *.as,*.asc set filetype=actionscript
au BufRead *.mxml set filetype=xml
au BufRead *.erb, *.pp set filetype=ruby
au BufRead *.mako set filetype=html
"au BufRead rules set filetype=sh

vnoremap > >gv
vnoremap < <gv

set hidden
set nobackup
set nowritebackup
set noswapfile
set autoindent
syntax on
set nu!
set wrap!
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set wildmenu
set guifont=DejaVu\ Sans\ Mono\ 8
set guioptions-=T
set guioptions-=r
set guioptions-=L
set shortmess+=I
set incsearch
set hls
set ic
hi normal guibg=lightgray

source $VIMRUNTIME/mswin.vim
behave mswin

"let g:netrw_liststyle=3
"let g:netrw_browse_split=0
let g:proj_flags="imstgv"
let g:proj_window_width=32
map! <F12> <Esc>:update<CR><F12>

set list
set listchars=tab:__,trail:_,extends:>,precedes:<

if has('gui_running')
	" Always show file types in menu
	let do_syntax_sel_menu=1
	runtime! synmenu.vim
	colorscheme solarized
	set background=dark
	let g:solarized_contrast="high"
	winpos 0 0
	set columns=160
	set lines=50
endif

