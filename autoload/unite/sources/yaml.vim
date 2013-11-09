let s:source = {
  \ 'name' : 'yaml',
  \ 'description': 'candidates from yaml',
  \ 'action_table': {},
  \ 'max_candidates': 300,
  \ 'hooks': {},
  \ }
call unite#define_source(s:source)

function! s:source.hooks.on_init(args, context)
ruby << EOC
  require 'yaml'
  hash = YAML.load_file(VIM.evaluate('a:args').first)
  def yaml_path(parent_path, yaml_value)
    parent_path.gsub!(/$/, "\.") unless parent_path.empty?
    if yaml_value.is_a?(Hash)
      yaml_value.map do |key, value|
        yaml_path("#{parent_path}#{key}", value)
      end.flatten
    elsif yaml_value.is_a?(Array)
      yaml_value.map.with_index do |value, index|
        yaml_path("#{parent_path}#{index}", value)
      end.flatten
    else
      "#{parent_path.chop}: #{yaml_value}"
    end
  end
  VIM.command("let a:context.source__lines = #{yaml_path('', hash).to_s}")
EOC
endfunction

function! s:source.gather_candidates(args, context)
  let candidates = []
  for line in a:context.source__lines
    call add(candidates, {
          \ 'word': substitute(line, "\:.*", "", "g"),
          \ 'abbr': line,
          \ 'kind': 'word',
          \ })
  endfor
  return candidates
endfunction

unlet s:source

