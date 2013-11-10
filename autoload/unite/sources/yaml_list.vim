function! unite#sources#yaml_list#define()
  return s:source
endfunction

let s:source = {
  \ 'name' : 'yaml-list',
  \ 'description': 'find yaml file from this directory.',
  \ 'action_table': {},
  \ 'max_candidates': 30,
  \ 'hooks': {},
  \ }
call unite#define_source(s:source)

let s:action = {
  \ 'description': 'unite_yaml',
  \ 'is_selectable': 0,
  \ }

function! s:action.func(candidate)
  execute 'Unite' 'yaml:' . a:candidate.action__path
endfunction

call unite#custom#action('file', 'unite_yaml', s:action)

function! s:source.hooks.on_init(args, context)
  execute 'Unite' 'find:.:-name\ "*.yml"' '-default-action=unite_yaml'
endfunction

