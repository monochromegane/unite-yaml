let s:source = {
  \ 'name' : 'yaml',
  \ 'description': 'candidates from yaml',
  \ 'action_table': {},
  \ 'max_candidates': 300,
  \ 'hooks': {},
  \ }
call unite#define_source(s:source)

unlet s:source

