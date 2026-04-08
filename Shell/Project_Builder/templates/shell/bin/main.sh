#!/usr/bin/env bash

set -euo pipefail

# -----------------------------------------------------------------------------
# {{PROJECT_NAME}}
# -----------------------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
    echo "Running {{PROJECT_NAME}}..."
}

main "$@"
