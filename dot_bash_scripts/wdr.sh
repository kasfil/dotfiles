#!/bin/sh

wdr() {
  local repo=$1
  local num=$2

  if [ -z "$repo" ] || [ -z "$num" ]; then
    echo "Usage: wdr <repo> <num>"
    return 1
  fi

  local build=""
  local status=""

  while true; do
    local output=$(drone build info $repo $num)
    local new_status=$(echo "$output" | rg -oP 'Status: \K\w+')
    local new_build=$(echo "$output" | rg -oP '(Build|Number)[: #]? \K\d+')

    if [ "$new_status" != "$status" ] || [ "$new_build" != "$build" ]; then
      status="$new_status"
      build="$new_build"
      echo -ne "\rBuild: #$build, Status: $status"
    fi

    if [ "$status" = "success" ] || [ "$status" = "failed" ]; then
      echo ""  # Move to a new line after the loop completes
      return 0
    fi

    sleep 2
  done
}
