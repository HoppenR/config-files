" vim: set tabstop=4 :

hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "personal"

highlight ColorColumn		ctermfg=none	ctermbg=8		cterm=none
highlight Comment			ctermfg=39		ctermbg=none	cterm=none
highlight Constant			ctermfg=12		ctermbg=none	cterm=none
highlight CursorlineNr		ctermfg=11		ctermbg=none	cterm=inverse
highlight DiffAdd			ctermfg=15		ctermbg=2		cterm=none
highlight DiffChange		ctermfg=15		ctermbg=5		cterm=none
highlight DiffDelete		ctermfg=15		ctermbg=1		cterm=none
highlight DiffText			ctermfg=15		ctermbg=4		cterm=none
highlight Error				ctermfg=15		ctermbg=1		cterm=none
highlight Folded			ctermfg=243		ctermbg=8		cterm=none
highlight Identifier		ctermfg=14		ctermbg=none	cterm=none
highlight Incsearch			ctermfg=none	ctermbg=none	cterm=inverse,italic
highlight LineNr			ctermfg=11		ctermbg=none	cterm=none
highlight MatchParen		ctermfg=15		ctermbg=5		cterm=none
highlight Normal			ctermfg=15		ctermbg=none	cterm=none
highlight PreProc			ctermfg=9		ctermbg=none	cterm=none
highlight Search			ctermfg=none	ctermbg=none	cterm=inverse,italic
highlight Special			ctermfg=10		ctermbg=none	cterm=none
highlight SpecialKey		ctermfg=4		ctermbg=none	cterm=none
highlight Statement			ctermfg=14		ctermbg=none	cterm=none
highlight StatusLine		ctermfg=15		ctermbg=4		cterm=none
highlight StatusLineNC		ctermfg=243		ctermbg=8		cterm=none
highlight StatusLineTerm	ctermfg=0		ctermbg=10		cterm=bold
highlight StatusLineTermNC	ctermfg=243		ctermbg=8		cterm=none
highlight TabLine			ctermfg=15		ctermbg=8		cterm=none
highlight TabLineFill		ctermfg=15		ctermbg=8		cterm=none
highlight TabLineSel		ctermfg=15		ctermbg=4		cterm=none
highlight Todo				ctermfg=11		ctermbg=8		cterm=bold
highlight Type				ctermfg=2		ctermbg=none	cterm=none
highlight VertSplit			ctermfg=4		ctermbg=8		cterm=none
highlight WarningMsg		ctermfg=15		ctermbg=1		cterm=none
highlight WildMenu			ctermfg=8		ctermbg=4		cterm=none
" netrw colors
highlight Directory			ctermfg=12		ctermbg=none	cterm=bold
highlight netrwCompress		ctermfg=9		ctermbg=none	cterm=bold
highlight netrwDoc			ctermfg=11		ctermbg=none	cterm=bold
highlight netrwHdr			ctermfg=11		ctermbg=none	cterm=bold
highlight netrwLib			ctermfg=11		ctermbg=none	cterm=bold
highlight netrwSymLink		ctermfg=14		ctermbg=none	cterm=bold
highlight netrwTags			ctermfg=12		ctermbg=1		cterm=none
highlight netrwTilde		ctermfg=12		ctermbg=none	cterm=none
highlight netrwTmp			ctermfg=4		ctermbg=none	cterm=none
" special colors
highlight gitcommitOverflow	ctermfg=1		ctermbg=none	cterm=none
