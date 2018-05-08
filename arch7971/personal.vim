" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file

hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "personal"

highlight ColorColumn					ctermbg=8		cterm=none
highlight Comment		ctermfg=39						cterm=none
highlight Constant		ctermfg=12						cterm=none
highlight CursorlineNr									cterm=inverse
highlight DiffAdd		ctermfg=15		ctermbg=2		cterm=none
highlight DiffChange	ctermfg=15		ctermbg=5		cterm=none
highlight DiffDelete	ctermfg=15		ctermbg=1		cterm=none
highlight DiffText		ctermfg=15		ctermbg=4		cterm=none
highlight Error			ctermfg=15		ctermbg=1		cterm=none
highlight Folded		ctermfg=243		ctermbg=8		cterm=none
highlight Identifier	ctermfg=14						cterm=none
highlight Incsearch										cterm=inverse,italic
highlight LineNr		ctermfg=11						cterm=none
highlight MatchParen	ctermfg=15		ctermbg=5		cterm=none
highlight Normal		ctermfg=15						cterm=none
highlight PreProc		ctermfg=9						cterm=none
highlight Search		ctermfg=none	ctermbg=none	cterm=inverse,italic
highlight Special		ctermfg=10						cterm=none
highlight SpecialKey	ctermfg=4						cterm=none
highlight Statement		ctermfg=14						cterm=none
highlight StatusLine	ctermfg=15		ctermbg=4		cterm=none
highlight StatusLineNC	ctermfg=243		ctermbg=8		cterm=none
highlight TabLine		ctermfg=15		ctermbg=8		cterm=none
highlight TabLineFill	ctermfg=15		ctermbg=8		cterm=none
highlight TabLineSel	ctermfg=15		ctermbg=4		cterm=none
highlight Todo			ctermfg=11		ctermbg=8		cterm=bold
highlight Type			ctermfg=2						cterm=none
highlight VertSplit		ctermfg=4		ctermbg=8		cterm=none
highlight WarningMsg	ctermfg=15		ctermbg=1		cterm=none
highlight WildMenu		ctermfg=8		ctermbg=4		cterm=none
" netrw colors
highlight Directory		ctermfg=12						cterm=bold
highlight netrwCompress	ctermfg=9						cterm=bold
highlight netrwDoc		ctermfg=11						cterm=bold
highlight netrwHdr		ctermfg=11						cterm=bold
highlight netrwLib		ctermfg=11						cterm=bold
highlight netrwSymLink	ctermfg=14						cterm=bold
highlight netrwTags		ctermfg=12		ctermbg=1		cterm=none
highlight netrwTilde	ctermfg=12						cterm=none
highlight netrwTmp		ctermfg=4						cterm=none
