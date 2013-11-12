function! unite#sources#yaml#define()
  return s:source
endfunction

if !exists('g:unite_yaml_prefix')
  let g:unite_yaml_prefix = ""
endif

let s:source = {
  \ 'name' : 'yaml',
  \ 'description': 'candidates from yaml',
  \ 'action_table': {},
  \ 'max_candidates': 300,
  \ 'hooks': {},
  \ }
call unite#define_source(s:source)

function! s:source.hooks.on_init(args, context)
  if !has('ruby')
    echo 'unite-yaml requires ruby interface support.'
    let a:context.source__lines = []
    return
  endif
  if !filereadable(a:args[0])
    echo 'File dose not exists. [' . a:args[0] . ']'
    let a:context.source__lines = []
    return
  endif
ruby << EOC
  require 'yaml'
  require 'erb'
  erb = ERB.new(File.read(VIM.evaluate('a:args').first))
  hash = YAML.load(erb.result)
  def yaml_path(parent_path, yaml_value)
    parent_path.gsub!(/$/, "\.") unless parent_path.empty?
    if yaml_value.is_a?(Hash)
      yaml_value.map do |key, value|
        yaml_path("#{parent_path}#{key}", value)
      end.flatten
    elsif yaml_value.is_a?(Array)
      yaml_value.map do |value|
        yaml_path("#{parent_path}#{yaml_value.index(value)}", value)
      end.flatten
    else
      "#{parent_path.chop}: #{yaml_value}"
    end
  end
  VIM.command("let a:context.source__lines = ['#{yaml_path('', hash).each{|v|v.gsub!(/'/, "''")}.join("','")}']")
EOC
endfunction

function! s:source.gather_candidates(args, context)
  let candidates = []
  for line in a:context.source__lines
    call add(candidates, {
          \ 'word': g:unite_yaml_prefix . substitute(line, "\:.*", "", "g"),
          \ 'abbr': line,
          \ 'kind': 'word',
          \ })
  endfor
  return candidates
endfunction

