" Vim syntax file
" Language: tks
" Maintainer:   Kevin Pham <kevinpham@catalyst-au.net>
" Last Change:  2023 July 31

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn match tksWR "^\s*\S\+" nextgroup=tksTime skipwhite
syn match tksTime "\s[0-9.:-]\+\s" nextgroup=tksDescription skipwhite contained
syn region tksDescription start="\S" end="$" skipwhite contained keepend contains=tksReviewTag

" Extra highlights in a tks description
syn match tksClient "\S\+:\s" containedin=tksDescription
syn match tksReviewTag "\[review\]" containedin=tksDescription
syn match tksLearnTag "\[learn\]" containedin=tksDescription
syn match tksExpenseTag "\[expense\]" containedin=tksDescription

" Keywords
syn keyword tksTags MR PR LEARN REVIEW TEST IMPLEMENT DOCUMENT LESSON containedin=tksDescription

syn region comment    start="#" end="$"
syn keyword commentTags TODO containedin=comment

syn match date "^\d\d\d\d-\d\d-\d\d"
syn match date "^\d\+/\d\+/\d\d\(\d\d\)\?"

" Highlight links?
syn match matchURL /http[s]\?:\/\/[[:alnum:]%\/_#.-]*/ containedin=tksDescription
hi def link matchURL Underline

hi def link date @attribute
hi def link comment Comment
hi def link tksWR Error
hi def link tksTime Text
hi def link tksDescription String
hi def link tksClient Exception
hi def link tksTags Todo
hi def link commentTags Todo
hi def link tksReviewTag Statement
hi def link tksLearnTag Todo
hi def link tksExpenseTag Todo

let b:current_syntax = "tks"
