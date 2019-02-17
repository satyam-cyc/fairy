#!/usr/bin/env bash
#
# Output utilities

echo_bold_blue() {
  printf "\033[1m\033[34m$@\033[0m\n"
}

info() {
  printf "[\033[1m\033[34mINFO\033[0m] $@\n" >&1  # to stdout
}

info_bold_green() {
  info "\033[1m\033[32m$@\033[0m"
}
info_bold_blue() {
  info "\033[1m\033[34m$@\033[0m"
}

warn() {
  printf "[" >&2
  printf "\033[1m\033[33m" >&1
  printf "WARNING" >&2
  printf "\033[0m" >&1
  printf "] $@\n" >&2
}

err() {
  printf "[" >&2
  printf "\033[1m\033[31m" >&1
  printf "ERROR" >&2
  printf "\033[0m" >&1
  printf "] $@\n" >&2
}

check_err() {
  local -r EXIT_CODE="$?"
  if [[ "${EXIT_CODE}" -ne 0 ]]; then
    err "$@ [EXIT:${EXIT_CODE}]"
    exit "${EXIT_CODE}"
  fi
}

failed() {
  printf "\033[31m" >&1  # set to red font for stdout
  printf "$@" >&2  # to stderr
  printf "\033[0m\n" >&1  # reset color for stdout
}

check_failed() {
  local -r EXIT_CODE="$?"
  if [[ "${EXIT_CODE}" -ne 0 ]]; then
    failed "$@ [EXIT:${EXIT_CODE}]"
    exit "${EXIT_CODE}"
  fi
}
