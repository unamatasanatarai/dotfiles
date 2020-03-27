PATH="${PATH}:${HOME}/bin"
export VISUAL=vim
export EDITOR="$VISUAL"

mconvert() {
  local finput="$1"
  local foutput="x-"${finput// /_}

  #ffmpeg -i "$finput" -vcodec libx264 -crf 20 -acodec aac $foutput; say "Your video is DONE"
  ffmpeg -i "$finput" -vcodec libx264 -acodec aac $foutput; say "Your video is DONE"
}
alias gic='git add --all && git commit -m '
alias ginah="git reset --hard && git clean -df"
alias gip='git push origin $(parse_git_branch)'
alias gis='git status'
alias gul='git pull origin $(parse_git_branch)'
alias brewupdate='brew update && brew upgrade && brew cleanup'

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
wrap_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ <\1>/'
}
export PS1="${debian_chroot:+($debian_chroot)}\$(if [ \$? == 0 ]; then echo 😀; else echo 😱; fi)\[\033[01;34m\] \u@\h \[\033[32m\]\w\[\033[33m\]\$(wrap_git_branch)\[\033[00m\] $ "

take() {
 mkdir -p "$1"
 cd "$1"
}

gicp() {
 git add --all
 if [ -z "$1" ]; then
  git commit -m "wip"
 else
  git commit -m "$1"
 fi
 gip
}

# cleanup
find ~/{Documents,dev,Downloads,Google\ Drive} -name ".DS_Store" -delete

# direnv for python
function cd() {
  builtin cd "$@"

  if [[ -f ./venv/bin/activate ]] ; then
    if [[ -n "$VIRTUAL_ENV" ]]; then
      deactivate
    fi
    source ./venv/bin/activate
    echo "remember to deactivate!"
  fi
}

eval "$(direnv hook bash)"
