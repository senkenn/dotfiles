#!/usr/bin/env zsh

_pnpm_run_scripts() {
  local -a scripts
  if [[ -f package.json ]]; then
    scripts=("${(@f)$(jq -r '.scripts | keys[]?' package.json 2>/dev/null)}")
    _wanted scripts expl 'pnpm scripts' compadd -a scripts
  else
    _message 'No package.json found'
  fi
}

_pnpm_exec_bins() {
  local -a bins
  if [[ -d node_modules/.bin ]]; then
    bins=("${(@f)$(command ls -1 node_modules/.bin 2>/dev/null)}")
    _wanted bins expl 'executables in node_modules/.bin' compadd -a bins
  else
    _message 'No node_modules/.bin found'
  fi
}

_pnpm_main_completion() {
  local -a subcommands options
  
  subcommands=(
    'add:Add dependencies'
    'install:Install dependencies'
    'update:Update dependencies'
    'remove:Remove dependencies'
    'run:Run a defined script'
    'exec:Execute a binary'
    'list:List installed packages'
    'outdated:Check for outdated packages'
    'audit:Run a security audit'
    'link:Symlink a package folder'
    'publish:Publish a package'
    'pack:Create a tarball'
    'rebuild:Rebuild packages'
    'install-test:Install and test'
    'root:Show root path'
    'store:Manage pnpm store'
    'env:Print environment info'
  )
  
  options=(
    '--help[Show help]'
    '--version[Show version]'
    '--filter=[Filter workspace packages]'
    '--workspace-root[Operate from workspace root]'
    '--recursive[Run command recursively]'
    '--global[Install globally]'
    '--silent[No output]'
  )
  
  _arguments -s '1:subcommand:->subcmds' '*::options:->opts'
  
  case $state in
    subcmds)
      _describe 'pnpm commands' subcommands ;;
    opts)
      _describe 'pnpm options' options ;;
  esac
}

_pnpm_dispatcher() {
  local cmd="${words[2]}"
  case "$cmd" in
    run)
      _pnpm_run_scripts ;;
    exec)
      _pnpm_exec_bins ;;
    *)
      _pnpm_main_completion ;;
  esac
}

compdef _pnpm_dispatcher pnpm
