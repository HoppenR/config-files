"
" ~/.vim/colors/personal.vim
"
" Vim: set tabstop=4 :

hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "personal"

highlight ColorColumn		ctermfg=none	ctermbg=8		cterm=none
highlight Comment			ctermfg=41		ctermbg=none	cterm=none
highlight Constant			ctermfg=4		ctermbg=none	cterm=none
highlight Cursorline		ctermfg=none	ctermbg=none	cterm=none
highlight CursorlineNr		ctermfg=11		ctermbg=none	cterm=inverse
highlight DiffAdd			ctermfg=15		ctermbg=12		cterm=none
highlight DiffChange		ctermfg=15		ctermbg=127		cterm=none
highlight DiffDelete		ctermfg=15		ctermbg=1		cterm=none
highlight DiffText			ctermfg=15		ctermbg=6		cterm=none
highlight Error				ctermfg=15		ctermbg=1		cterm=none
highlight Folded			ctermfg=243		ctermbg=8		cterm=none
highlight Function			ctermfg=14		ctermbg=none	cterm=bold
highlight Identifier		ctermfg=14		ctermbg=none	cterm=none
highlight Incsearch			ctermfg=none	ctermbg=none	cterm=inverse,underline
highlight LineNr			ctermfg=11		ctermbg=none	cterm=none
highlight MatchParen		ctermfg=15		ctermbg=6		cterm=none
highlight NonText			ctermfg=243		ctermbg=none	cterm=none
highlight Normal			ctermfg=15		ctermbg=none	cterm=none
highlight Pmenu				ctermfg=243		ctermbg=8		cterm=none
highlight PmenuSbar			ctermfg=none	ctermbg=8		cterm=none
highlight PmenuSel			ctermfg=0		ctermbg=10		cterm=none
highlight PmenuThumb		ctermfg=none	ctermbg=11		cterm=none
highlight PreProc			ctermfg=9		ctermbg=none	cterm=none
highlight Search			ctermfg=none	ctermbg=none	cterm=underline
highlight SignColumn		ctermfg=none	ctermbg=none	cterm=none
highlight Special			ctermfg=6		ctermbg=none	cterm=none
highlight SpecialKey		ctermfg=243		ctermbg=none	cterm=none
highlight Statement			ctermfg=10		ctermbg=none	cterm=none
highlight StatusLine		ctermfg=8		ctermbg=12		cterm=none
highlight StatusLineNC		ctermfg=243		ctermbg=8		cterm=none
highlight StatusLineTerm	ctermfg=0		ctermbg=10		cterm=bold
highlight StatusLineTermNC	ctermfg=243		ctermbg=8		cterm=none
highlight TabLine			ctermfg=15		ctermbg=8		cterm=none
highlight TabLineFill		ctermfg=15		ctermbg=8		cterm=none
highlight TabLineSel		ctermfg=15		ctermbg=4		cterm=none
highlight Todo				ctermfg=8		ctermbg=12		cterm=bold
highlight Type				ctermfg=12		ctermbg=none	cterm=none
highlight VertSplit			ctermfg=4		ctermbg=8		cterm=none
highlight WarningMsg		ctermfg=15		ctermbg=1		cterm=none
highlight WildMenu			ctermfg=15		ctermbg=12		cterm=none
" netrw / NERDTree colors
highlight Directory			ctermfg=12		ctermbg=none	cterm=bold
highlight NERDTreeCFile		ctermfg=2
" special colors
highlight YcmErrorSection	ctermfg=none	ctermbg=none	cterm=none
highlight YcmErrorSign		ctermfg=1		ctermbg=none	cterm=bold
highlight YcmWarningSection	ctermfg=none	ctermbg=none	cterm=none
highlight YcmWarningSign	ctermfg=11		ctermbg=none	cterm=bold
highlight gitcommitOverflow	ctermfg=1		ctermbg=none	cterm=none
