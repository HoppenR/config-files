"
" ~/.vimrc
"
" Vim: set tabstop=4 :

""""""""""""""""""""""""""""""""""" COMMANDS """""""""""""""""""""""""""""""""""
colorscheme personal
filetype plugin indent on
syntax on

""""""""""""""""""""""""""""""""""" OPTIONS """""""""""""""""""""""""""""""""""
set   autochdir
set   autoindent
set   hlsearch       "highlight search"
set   ignorecase     "ignore case while searching"
set   incsearch      "show search results while typing"
set   list           "show non-printable characters"
set noruler          "disable ruler (because we have ourown statusline"
set nowrap           "disable line wrapping"
set   number         "show line numbers"
set   showcmd        "show partial commands on the bottom right of the screen"
set   smartcase      "override ignorecase when pattern includes capital letters
set   splitbelow     "windows that would open above should open below"
set   splitright     "windows that would open left should open right"
set   title          "enable setting window title"
set   undofile       "store undo/redo buffers in non-volatile memory"
set   fileignorecase "ignore case for files
set   wildmenu       "show all options in command line completion in a menu"

"""""""""""""""""""""""""""""""" STRING OPTIONS """"""""""""""""""""""""""""""""
set encoding=utf-8
set cinoptions=:0,g0,(0
set clipboard=unnamed     "use system primary"
set colorcolumn=120        "print a line marking the 120th column"
set completeopt=
set foldmarker={{{,}}}    "use mark folds between {{{ and  }}}"
set foldmethod=marker     "fold between foldmarkers"
set laststatus=2          "always show status line"
"replace unprintable characters with the printable characters following them"
set listchars=tab:│\ ,trail:~,eol:¬
set makeprg=""            "unset make program (set for each filetype by autocmd)"
set shiftwidth=4          "number of spaces for autoindenting"
set signcolumn=yes
"set statusline to show relevant information using printf style % item syntax"
set statusline=%F\ %-7h%-4m%-5r%y%=%-18(L:%3l\ C:%3v\ pos:%{LineNoIndicator()}%)
set tabstop=4             "width of each tab"
set titleold=""           "disable title when exiting vim"
set textwidth=120
"set window title to show relevant information using printf style % item syntax"
set titlestring=%f\ %-7h%-4m%-5r-\ VIM
"set directory containing non-volatile undo history files"
set undodir=$HOME/.vim/undo
set undolevels=1000       "maximum changes that can be undone"
set undoreload=10000      "number of lines to save for undo"

"""""""""""""""""""""""""""""""""" VARIABLES """"""""""""""""""""""""""""""""""
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_key_list_select_completion = []
let g:ycm_log_level = "critical"
let g:netrw_banner=0      "remove the banner from the directory browser"
"hide files whose name matches this pattern"
let g:netrw_list_hide="\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"
let g:netrw_keepdir=0     "update the current working directory in netrw"
let g:netrw_liststyle = 3 "show netrw files in tree mode
let g:clang_format#style_options = {
			\ "AccessModifierOffset" : -4,
			\ "AlignAfterOpenBracket" : "Align",
			\ "AllowShortFunctionsOnASingleLine" : "Empty",
			\ "AllowShortIfStatementsOnASingleLine" : "false",
			\ "AllowShortLoopsOnASingleLine" : "false",
			\ "AlwaysBreakTemplateDeclarations" : "Yes",
			\ "BasedOnStyle" : "llvm",
			\ "BreakBeforeBraces" : "Attach",
			\ "ColumnLimit" : 120,
			\ "Cpp11BracedListStyle" : "false",
			\ "IndentCaseLabels" : "false",
			\ "IndentWidth" : 4,
			\ "SpaceBeforeParens" : "Always",
			\ "Standard" : "Auto",
			\ "TabWidth" : 4,
			\ "UseTab": "Always"}

let &t_SI="\e[5 q\<Esc>]12;#00FF5F\x7" "insert mode cursor"
let &t_SR="\e[3 q\<Esc>]12;#CC372C\x7" "replace mode cursor"
let &t_EI="\e[0 q\<Esc>]12;#16A085\x7" "reset cursor when exiting insert/replace"

""""""""""""""""""""""""""""""""""" MAPPINGS """""""""""""""""""""""""""""""""""
"curly bracket completion"
inoremap {<CR> {<CR>}<Esc>O
"stop highlighting search"
nnoremap <silent> <Tab> :nohlsearch<CR>
"open and close folds"
nnoremap <Space> za
"open new buffer vertically"
nnoremap <C-n> :vnew<CR>
"open a new terminal emulator split inside vim"
nnoremap <silent> <C-t> :call term_start(["/bin/bash"],
	\{"vertical":1, "term_finish":"close"})<CR>

""""""""""""""""""""""""""""""""" AUTOCOMMANDS """""""""""""""""""""""""""""""""
augroup Directory_browser
	autocmd!
	autocmd FileType		netrw		setlocal bufhidden=delete
	autocmd FileType		netrw		call DirectoryBrowserMappings()
augroup END

augroup AutoChdir
	" temporary... I think
	autocmd BufLeave 		$VIMRUNTIME/doc/*.txt	silent! cd $HOME
augroup END

augroup AutoMake
	autocmd!
	autocmd BufEnter		*.{c,cpp}	setlocal makeprg=make
	autocmd BufLeave		*.{c,cpp}	setlocal makeprg=
	autocmd BufWritePost	*.{c,cpp}	if filereadable("./makefile")
		\|									make!
		\|									cwindow
	\|									endif
augroup END

augroup AutoShellcheck
	autocmd!
	autocmd BufEnter		*			if (&filetype ==# "sh") && (! &diff)
		\|									setlocal makeprg=shellcheck\ -f\ gcc\ %
	\|									endif
	autocmd BufLeave		*			if (&filetype ==# "sh") && (! &diff)
		\|									setlocal makeprg=
	\|									endif
	autocmd BufWritePost	*			if (&filetype ==# "sh") && (! &diff)
		\|									make!
		\|									cwindow
	\|									endif
augroup END

augroup QuickFixClose "quit if the last window is nr 1 and a quickfix window"
	autocmd!
	autocmd WinEnter		*				if (winnr("$") ==# 1) &&
		\(getbufvar(winbufnr(winnr()), "&buftype") == "quickfix")
		\|										quit
	\|										endif
augroup END

"augroup ClipboardSave
"	autocmd!
"	autocmd VimLeave		*			call system("xsel -ib", getreg('+'))
"augroup END

"""""""""""""""""""""""""""""""""" FUNCTIONS """"""""""""""""""""""""""""""""""
function! DirectoryBrowserMappings()
	"go to home directory"
	noremap <buffer> <silent> gh :execute("Ntree" . " /home/" . $USER)<CR>
	"show hidden files in g:netrw_list_hide"
	noremap <buffer> <silent> zh :call eval(printf("<SNR>%d_NetrwHidden(1)",
		\GetScriptNumber("netrw.vim")))<CR>
endfunction

"get the script number for a script name"
function! GetScriptNumber(script_name)
	redir => scriptnamelines
	silent! scriptnames
	redir END
	for scriptline in split(l:scriptnamelines, "\n")
		if l:scriptline =~ a:script_name
			return str2nr(split(l:scriptline, ":")[0])
		endif
	endfor
	return -1
endfunction

" vim-line-no-indicator {{{1
" Author: Sheldon Johnson
" Version: 0.3
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
" }}}1
