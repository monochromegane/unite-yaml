unite-yaml
==========

unite-yaml is a unite.vim's source which provides candidates for yaml.

It supports to input long yaml key, like a `Settings.db_const.table.column.key`.

## Install

add to .vimrc `Bundle "monochromegane/unite-yaml"`
and `:BundleInstall` in vim.

## Usage

### 1. Find yaml file from current directory.

`:Unite yaml-list` in vim.
and choose a yaml file. (supports an ERB enabled YAML, too)

```console
>
  config/database.yml
  config/locales/en.yml
  config/settings/development.yml
  config/settings/production.yml
  config/settings/test.yml
  config/settings.local.yml
  config/settings.yml
```

### 2. Choose a yaml key 

choose a yaml key, and `Enter` in unite.
so, the key was inserted at cursor position.

```console
>
  github.client_id: 00000000000000000000
  github.client_secret: 0000000000000000000000000000000000000000
```

## Keybind

add to .vimrc the following.

```
" yaml
let g:unite_yaml_prefix = "Settings."
nnoremap <silent> ,y  :<C-u>Unite yaml-list<CR>
nnoremap <silent> ,Y  :<C-u>UniteResume yaml-buffer<CR>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

