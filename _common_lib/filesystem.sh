#!/bin/bash
#
# Utilities for file and directory manipulation.
#
# Dependencies: output_utils.sh

delete_file() {
  rm -f "$1"
  [[ ! -f "$1" ]]
  check_err "failed to delete file '$1'"
}

delete_dir() {
  rm -rf "$1"
  [[ ! -d "$1" ]]
  check_err "failed to delete directory '$1'"
}

find_and_link_files_by_ext() {
  [[ "$#" -eq 3 ]]
  check_err "wrong number of parameters to 'find_and_link_files_by_ext()'"
  
  local -r ext="$1"
  
  local -r from_dir="$2"
  [[ -d "${from_dir}" ]]
  check_err "invalid path of directory '${from_dir}'"
  
  local -r to_dir="$3"
  mkdir -p "${to_dir}"
  
  find "${from_dir}" -maxdepth 1 -type f -iname "*.${ext}" |
  td="${to_dir}" xargs -n 1 sh -c '[[ -f "$0" ]] && ln -s "$0" ${td}'
}

find_and_link_files_by_regex() {
  [[ "$#" -eq 3 ]]
  check_err "wrong number of parameters to 'find_and_link_files_by_regex()'"
  
  local regex="$1"
  [[ "$(os_type)" != "Mac" ]] &&
  regex="$(echo "${regex//|/\\|}" | sed 's/(/\\(/g' | sed 's/)/\\)/g')"
  
  local -r from_dir="$2"
  [[ -d "${from_dir}" ]]
  check_err "invalid path of directory '${from_dir}'"
  
  local -r to_dir="$3"
  mkdir -p "${to_dir}"
  
  find $(arg_find_e) "${from_dir}" -maxdepth 1 -type f -iregex "${regex}" |
  td="${to_dir}" xargs -n 1 sh -c '[[ -f "$0" ]] && ln -s "$0" ${td}'
}

find_and_link_subdirs() {
  [[ "$#" -eq 2 ]]
  check_err "wrong number of parameters to 'find_and_link_subdirs()'"
  
  local -r from_dir="$1"
  [[ -d "${from_dir}" ]]
  check_err "invalid path of directory '${from_dir}'"
  
  local -r to_dir="$2"
  mkdir -p "${to_dir}"
  
  find "${from_dir}/." -maxdepth 1 -type d -exec basename {} \; |
  fd="${from_dir}" td="${to_dir}" xargs -n 1 \
  sh -c '[[ "$0" != "." ]] && ln -s "${fd}/$0" "${td}"'
}

check_file_exists() {
  [[ "$#" -eq 1 ]]
  check_err "wrong number of parameters to 'check_file_exists()'"
  
  [[ -f "$1" ]]
  check_err "invalid path of file '$1'"
}

check_dir_exists() {
  [[ "$#" -eq 1 ]]
  check_err "wrong number of parameters to 'check_dir_exists()'"
  
  [[ -d "$1" ]]
  check_err "invalid path of directory '$1'"
}

file_size_bytes() {
  [[ "$#" -eq 1 ]]
  check_err "wrong number of parameters to 'get_file_size_bytes()'"
  
  check_file_exists "$1"
  
  ls -l "$1" | awk '{ print $5 }'
}