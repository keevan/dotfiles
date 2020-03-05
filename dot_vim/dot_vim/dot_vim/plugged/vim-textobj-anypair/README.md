# vim-textobj-anypair
Note: Still a work in progress, and realistically, will be tailored for my personal usage (and that of VMP's userbase) initially

(Will be a) Modified superset of "many pair text-objs"

`vim-textobj-anypair` is a quick shortcut for having to reach for the specific, heavily inspired by VMP (t9md's) idea of putting all the pair textobjs in to one.

This includes objects for:

`""`, `''`, ` `` `, `{}`, `<>`, `[]`,  or `()`.

['DoubleQuote', 'SingleQuote', 'BackTick', 'CurlyBracket', 'AngleBracket', 'SquareBracket', 'Parenthesis']

(Note: list pulled directly from VMP)

Default keymap will be removed such that the user will be able to define their own keymapping. I've seen forks where the only change made was the keymap and really this should be customizable such that, well, it needn't be forked for such a small change.

Example: If the keymapping was set to `s`, then  `is` and `as` text objects will select the innermost of either of the supported pairing characters.

Requires [vim-textobj-user](https://github.com/kana/vim-textobj-user)

Inspired by [t9md's vim-mode-plus](https://github.com/t9md/atom-vim-mode-plus/)

Thanks to those who have made changes from the main branch to extend it further. I appreciate it. It should make adding additional pairs easier to add if required


## TODO

- Add support for:
  - Single quote
  - Double quote
  - Back Tick
  - Angle Bracket
- Learn how to test vim plugins
- Add all test cases for all types of matching 'pairs'

