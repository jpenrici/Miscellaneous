#!/bin/bash

# Messaging Patterns
#   [*] ou [info] : Status or general process
#   [>] ou >>>    : User input or subprocess
#   [!] ou [Error]: Alert for critical failures
#   [+]           : Indication of resource creation/addition or success

# Color Definition
RED='\033[0;31m'      
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color (Reset)

# echo -e "${BLUE}[*]${NC} Starting file backup..."
# echo -e "${YELLOW}[!]${NC} Disk space below 20%."
# echo -e "${GREEN}[+]${NC} Backup completed successfully!"
# echo -e "${RED}[Error]${NC} It was not possible to send the log to the server."
# echo -ne "${BLUE}>>>${NC} Enter your name: "; read nome

# Base (Root) Directories with suffix _DIR or _HOME: ROOT_DIR, BASE_DIR, APP_HOME
# Structural Subdirectories: BIN_DIR, SRC_DIR, LIB_DIR, CONF_DIR ou CONFIG_DIR
# Data and Logs: DATA_DIR, LOG_DIR, TMP_DIR ou TEMP_DIR
# File Naming Suffixes: _FILE ou _PATH: LOG_FILE, CONFIG_FILE

# Defines the root based on the script's location.
readonly BASE_DIR=$(dirname "$(readlink -f "$0")")

# Folder structure
readonly LOG_DIR="${BASE_DIR}/logs"
readonly CONF_DIR="${BASE_DIR}/config"
readonly TMP_DIR="/tmp/myProject"

# Specific files
readonly CONFIG_FILE="${CONF_DIR}/settings.conf"
readonly LOG_FILE="${LOG_DIR}/deploy_$(date +%Y%m%d).log"

# Ensuring that the directories exist
mkdir -p "$LOG_DIR" "$TMP_DIR"

# Input arguments
arg="$@"

script=$(basename $0)
today=$(date +%Y-%m-%d)
now=$(date +%Y-%m-%d-%H:%M:%S)

