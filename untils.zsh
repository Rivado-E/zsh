################################################################
# GO prompt
prompt_go_version() {
  if (( _POWERLEVEL9K_GO_VERSION_PROJECT_ONLY )); then
    local p=$GOPATH
    if [[ -z $p ]]; then
      if [[ -d $HOME/go ]]; then
        p=$HOME/go
      else
        p="$(go env GOPATH 2>/dev/null)" && [[ -n $p ]] || return
      fi
    fi
    if [[ $_p9k__cwd/ != $p/* && $_p9k__cwd_a/ != $p/* ]]; then
      _p9k_upglob go.mod -. && return
    fi
  fi
  _p9k_prompt_segment "$0" "green" "grey93" "GO_ICON" 0 '' "${v//\%/%%}"
}

_p9k_prompt_go_version_init() {
  typeset -g "_p9k__segment_cond_${_p9k__prompt_side}[_p9k__segment_index]"='$commands[go]'
}

