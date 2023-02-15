# Shell commands
alias mkdir="mkdir -m 755 -pv"
alias free="free -mthw"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias cat="batcat"

function ls() {
  if [[ $@ == "-l" ]]; then
    command ls -l --color=always --group-directories-first --almost-all -g --no-group --human-readable --si --literal | awk 'NR>1'
  else 
    command ls "$@" --color=always --group-directories-first
  fi
}