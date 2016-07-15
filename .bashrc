is_available_command() {
    if command -v $1 >/dev/null 2>&1
    then
        return 0
    else
        return 1
    fi
}

# PATH for brewed softwares
if is_available_command "brew"
then
    PATH=/usr/local/bin:/usr/local/sbin:$PATH
fi
# PATH for home-build softwares
bindirs=($HOME/bin $HOME/scripts)
for d in ${bindirs[@]}
do
    if [ -d "$d" ]
    then
        PATH=$d:$PATH
    fi
done
# Settings for pyenv
if is_available_command "pyenv"
then
export PATH="/Users/demmys/.pyenv/shims:${PATH}"
export PYENV_SHELL=sh
command pyenv rehash 2>/dev/null
pyenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  activate|deactivate|rehash|shell)
    eval "$(pyenv "sh-$command" "$@")";;
  *)
    command pyenv "$command" "$@";;
  esac
}
fi
# Settings for rbenv
if is_available_command "rbenv"
then
export PATH="/Users/demmys/.rbenv/shims:${PATH}"
export RBENV_SHELL=sh
command rbenv rehash 2>/dev/null
rbenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}
fi
# Settings for direnv
if is_available_command "direnv"
then

_direnv_hook() {
  local previous_exit_status=$?;
  eval "$(direnv export bash)";
  return $previous_exit_status;
};
if ! [[ "$PROMPT_COMMAND" =~ _direnv_hook ]]; then
  PROMPT_COMMAND="_direnv_hook;$PROMPT_COMMAND";
fi

fi
