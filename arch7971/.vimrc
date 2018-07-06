" COLORSCHEME
colorscheme personal

" FILETYPE SPECIFIC
filetype plugin indent on
syntax on

" OPTIONS
set autochdir
set autoindent
set hlsearch
set ignorecase
set incsearch
set list
set noruler
set nowrap
set number
set relativenumber
set showcmd
set splitbelow
set splitright
set title
set wildignorecase
set wildmenu

" Persistent undo
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

" VARIABLES
set clipboard=unnamedplus
set colorcolumn=80
set foldmarker={{{,}}}
set foldmethod=marker
" always show status line
set laststatus=2
set listchars=tab:▏\ ,trail:~,eol:¬
" enable mouse for normal mode
set mouse=n
set shiftwidth=4
set statusline=%F\ %-7h%-4m%-5r%y%=%-21(L:%3l\ C:%3v\ pos:%3p%%%)
" set tab width to 4
set tabstop=4
" remove "Thanks for flying vim!" title when exiting
set titleold=
set titlestring=%f\ %-7h%-4m%-5r-\ VIM
" remove the banner from the directory browser
let g:netrw_banner = 0
" hide files whose names begin with a dot
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" set directory browser to tree style listing
let g:netrw_liststyle = 3
" update the current working directory in netrw
let g:netrw_keepdir= 0
"insert mode cursor
let &t_SI = "\e[5 q\<Esc>]12;#00FF5F\x7"
"replace mode cursor
let &t_SR = "\e[3 q\<Esc>]12;#FF4444\x7"
"reset cursor when exiting insert/replace
let &t_EI = "\e[0 q\<Esc>]12;#5FAFFF\x7"

" MAPPINGS
" curly bracket completion
inoremap {<CR> {<CR>}<Esc>O
" stop highlighting search
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
" open and close folds
nnoremap <Space> za
nnoremap J gT
nnoremap K gt
" open new empty split vertically
nnoremap <C-n> :vnew<CR>
" open a new terminal emulator split inside vim
nnoremap <silent> <C-t> :call term_start(['/bin/bash'], {'vertical':1,
			\'term_finish':'close'})<CR>
" grep files in the current directory
nnoremap <C-f> :vimgrep //./**<left><left><left><left><left>
" open quickfix window
nnoremap <silent> <C-b> :copen<CR>

" AUTOCOMMANDS
augroup Directory_browser
	autocmd!
	"deletes modified directory browser buffers
	autocmd FileType netrw setlocal bufhidden=delete
	autocmd FileType netrw call DirectoryBrowserMappings()
augroup END

augroup AutoMake
	autocmd!
	autocmd BufRead      *.{c,cpp} copen
	autocmd BufUnload    *.{c,cpp} cclose
	autocmd BufWritePost *.{c,cpp} if filereadable("./makefile")
									\| make!
								\| endif
augroup END

augroup AutoShellcheck
	autocmd!
	autocmd BufRead      * if &ft ==# 'sh'
								\| copen
								\| set makeprg=shellcheck\ -f\ gcc\ %
							\| endif
	autocmd BufUnload    * if &ft ==# 'sh'
								\| cclose
								\| set makeprg=make
							\| endif
	autocmd BufWritePost * if &ft ==# 'sh'
								\| make
							\| endif
augroup END

" FUNCTIONS
function! DirectoryBrowserMappings()
	"go to home directory
	noremap <buffer> <silent> gh :execute('Ntree' . ' /home/' . $USER)<CR>
	"show hidden files in g:netrw_list_hide
	noremap <buffer> <silent> zh :call eval(printf("<SNR>%d_NetrwHidden(1)",
				\GetScriptNumber("netrw.vim")))<CR>
endfunction

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
