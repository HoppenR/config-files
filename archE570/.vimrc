"
" ~/.vimrc"
"
" Vim: set tabstop=4 :"

""""""""""""""""""""""""""""""""""" COMMANDS """""""""""""""""""""""""""""""""""
colorscheme personal
filetype plugin indent on
syntax on

""""""""""""""""""""""""""""""""""" OPTIONS """""""""""""""""""""""""""""""""""
set   autochdir
set   autoindent
set   cursorline     "highlight the line where the cursor is"
set   esckeys        "enable escaped keys (i.e f5) in insert mode"
set   fileignorecase "ignore case for files"
set   foldenable     "use folds"
set   hidden         "hide unloaded buffers instead of abandoning it"
set   hlsearch       "highlight search"
set   ignorecase     "ignore case while searching"
set   incsearch      "show search results while typing"
set   list           "show non-printable characters"
set noruler          "disable ruler (because we have our own statusline"
set nowrap           "disable line wrapping"
set   number         "show line numbers"
set   showcmd        "show partial commands on the bottom right of the screen"
set   smartcase      "override ignorecase when pattern includes capital letters"
set   splitbelow     "windows that would open above should open below"
set   splitright     "windows that would open left should open right"
set   title          "enable setting window title"
set   timeout        "time out key mappings"
set   undofile       "store undo/redo buffers in non-volatile memory"
set   wildmenu       "show all options in command line completion in a menu"

"""""""""""""""""""""""""""""""" STRING OPTIONS """"""""""""""""""""""""""""""""
set cinoptions=:0,g0,(0,W4,l1
set clipboard=unnamed     "use system primary"
set colorcolumn=80         "print a line marking the 80th column"
set encoding=utf-8
set foldmarker={{{,}}}    "use mark folds between {{{ and  }}}"
set foldmethod=marker     "fold between foldmarkers"
set laststatus=2          "always show status line"
"replace unprintable characters with the printable characters following them"
set listchars=tab:│\ ,trail:~,eol:¬
set makeprg=""            "unset make program (set for each filetype by autocmd)"
set shiftwidth=4          "number of spaces for autoindenting"
set signcolumn=yes        "always show signcolumn that YCM uses to display errors"
"set statusline to show relevant information using printf style % item syntax"
set statusline=%F\ %-7h%-4m%-5r%y%=%-18(L:%3l\ C:%3v\ pos:%{LineNoIndicator()}%)
set timeoutlen=500        "Time out key mappings after 0.5s"
set ttimeoutlen=50         "set very low waiting time for escape sequences"
set tabstop=4             "width of each tab"
set textwidth=80          "set max text width to 80"
set titleold=""           "disable title when exiting vim"
"set window title to show relevant information using printf style % item syntax"
set titlestring=%f\ %-7h%-4m%-5r-\ VIM
"set directory containing non-volatile undo history files"
set undodir=$HOME/.vim/undo
set undolevels=1000       "maximum changes that can be undone"
set undoreload=10000      "number of lines to save for undo"
""""""""""""""""""""""""""""""""""" DIGRAPHS """""""""""""""""""""""""""""""""""
digr =\| 8739
digr !\| 8740

"""""""""""""""""""""""""""""""""" VARIABLES """"""""""""""""""""""""""""""""""
"Don't confirm extra YCM configuration"
let g:ycm_confirm_extra_conf = 0
"Dont map TAB to next completion"
let g:ycm_key_list_select_completion = []
"Don't automatically show popup with YCM"
let g:ycm_auto_hover = ''
"Close NERDTree after opening a file"
let g:NERDTreeQuitOnOpen = 1
"NERDTree open keybind"
let g:NERDTreeMapActivateNode = "l"
"Settings for vim-go"
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_variable_declarations = 1
"Settings for vim-tex"
let g:Tex_ViewRule_dvi='okular'

let &t_SI="\e[5 q\<Esc>]12;#00FF5F\x7" "insert mode cursor"
let &t_SR="\e[3 q\<Esc>]12;#CC372C\x7" "replace mode cursor"
let &t_EI="\e[0 q\<Esc>]12;#16A085\x7" "reset cursor when exiting insert/replace"

""""""""""""""""""""""""""""""""""" MAPPINGS """""""""""""""""""""""""""""""""""
"curly bracket completion"
inoremap {<CR> {<CR>}<Esc>O
nnoremap <silent> <C-w>n :call Scratch()<CR>
nnoremap <silent> <C-w><C-n> :call Scratch()<CR>
"open a new terminal emulator split inside vim"
nnoremap <silent> <C-t> :call term_start(["/bin/bash"], {"vertical":1, "term_finish":"close"})<CR>
"rename symbol under cursor"
nnoremap <F2> :YcmCompleter RefactorRename<Space>
"format the entire file"
nnoremap <silent> <F3> :YcmCompleter Format<CR>
"open and close folds"
nnoremap <Space> za
"toggle NERDTree"
nnoremap <silent> § :NERDTreeToggle<CR>
"stop highlighting search"
nnoremap <silent> ½ :nohlsearch<CR>
"switch to next buffer"
nnoremap <silent> <C-p> :bnext<CR>
tnoremap <silent> <C-p> <C-w>:bnext<CR>
"switch to previous buffer"
nnoremap <silent> <C-n> :bprevious<CR>
tnoremap <silent> <C-n> <C-w>:bprevious<CR>
"delete current buffer"
nnoremap <silent> <C-c> :bdelete<CR>

"hide YCM popup"
nnoremap <silent> <TAB> <plug>(YCMHover)

""""""""""""""""""""""""""""""""" AUTOCOMMANDS """""""""""""""""""""""""""""""""
augroup AutoMake
	autocmd!
	autocmd BufEnter *.{c,cpp,go,adb}
				\ setlocal makeprg=make
	autocmd BufWritePost	*.{c,cpp,go,adb}
				\ if filereadable("./makefile")
					\|make!
					\|cwindow
				\|endif
augroup END

augroup AutoShellcheck
	autocmd!
	autocmd BufEnter *
				\ if (&filetype ==# "sh") && (! &diff) && match(expand('%:p'), '/tmp/') != 0
					\|setlocal makeprg=shellcheck\ -f\ gcc\ %
				\|endif
	autocmd BufWritePost *
				\ if (&filetype ==# "sh") && (! &diff) && match(expand('%:p'), '/tmp/') != 0
					\|make!
					\|cwindow
				\|endif
augroup END

augroup NERDTreeColors
	autocmd!
	autocmd filetype nerdtree syntax match NERDTreeCFile '^\s\+.*\.[ch]\(pp\)\?$'
augroup END

"""""""""""""""""""""""""""""""""" FUNCTIONS """"""""""""""""""""""""""""""""""
" Scratch {{{1
function Scratch()
    execute 'vnew'
	setlocal bufhidden=wipe
	setlocal nobuflisted
    setlocal buftype=nofile
    setlocal noswapfile
endfunction
" }}}1
" vim-line-no-indicator {{{1"
" Author: Sheldon Johnson"
" Version: 0.3"
if !exists('g:line_no_indicator_chars')
  let g:line_no_indicator_chars = [ '█' ,'▇' ,'▆' ,'▅' ,'▄' ,'▃' ,'▂' ,'▁' ,' ' ]
end
function! LineNoIndicator() abort
  " Zero index line number so 1/3 = 0, 2/3 = 0.5, and 3/3 = 1
  let l:current_line = line('.') - 1
  let l:total_lines = line('$') - 1

  if l:current_line == 0
    let l:index = 0
  elseif l:current_line == l:total_lines
    let l:index = -1
  else
    let l:line_no_fraction = floor(l:current_line) / floor(l:total_lines)
    let l:index = float2nr(l:line_no_fraction * len(g:line_no_indicator_chars))
  endif

  return g:line_no_indicator_chars[l:index]
endfunction
" }}}1"
