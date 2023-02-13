syn clear gitcommitSummary
syn match   gitcommitSummary    "^.\{0,80\}" contained containedin=gitcommitFirstLine nextgroup=gitcommitOverflow contains=@Spell
