alias ls="ls --color=auto"
alias ll="ls -Al"

# claude
alias claude="claude --dangerously-skip-permissions"

# docker
alias d=docker
alias dc="docker compose"
alias de='(){docker compose exec $1 bash}'
alias dp="docker ps --format 'table {{.Names}}\t{{.Status}}'"

