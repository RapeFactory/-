alias gsa='git status '
alias gs='git status -sb '
alias go='git checkout '
alias ga='git add '
alias gap='git add -p '
alias gai='git add -i '
alias gc='git commit '
alias gcm='git commit --amend '
alias gca='git commit -a '
alias gcf='git commit --fixup '
alias gh='git hist '
alias gha='git hist --all '
alias gd='git diff '
alias gdh='git diff @ '
alias gds='git diff --staged '
alias gdc='git diff --cached '
alias gdt='git difftool '
alias gb='git branch '
alias gm='git merge '
alias gmf='git merge --ff-only '
alias gfa='git fetch --all '
alias grb='git rebase '
alias gri='git rebase -i '
alias gp='git push '
alias gpf='git push -f '
alias gr='git reset '
alias grs='git reset --soft '
alias grh='git reset --hard '
alias gk='gitk --all& '
alias gx='gitx --all '
alias gcount='git shortlog -s -n '

env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env
