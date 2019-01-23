#!/bin/bash
#
# Load script configuration
#
# Dependencies: output_utils.sh

DEFAULT_ACCOUNT_SCRIPT_CONF="${HOME}/account/conf/account_script.conf.default"

# Inlcude script configuration
readonly SCRIPT_CONF="${ACCOUNT_SCRIPT_CONF:-${DEFAULT_ACCOUNT_SCRIPT_CONF}}"
[[ -n "${SCRIPT_CONF}" ]]
check_err "Script configuration is not specified"
[[ -f "${SCRIPT_CONF}" ]]
check_err "Invalid path of script configuration: ${SCRIPT_CONF}"

source "${SCRIPT_CONF}"
check_err "Failed to load script configuration: ${SCRIPT_CONF}"

# Identify script itself
readonly SCRIPT_NAME="$(basename "$0")"