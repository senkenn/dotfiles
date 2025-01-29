alias ls="ls --color=auto"
alias ll="ls -Al"
alias d=docker
alias dc="docker compose"
alias de='(){docker compose exec $1 bash}'
alias dp="docker ps --format 'table {{.Names}}\t{{.Status}}'"
