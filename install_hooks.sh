#!/usr/bin/env bash
# Installs all detected hook scripts into the local git dir.
set -o errexit
set -o pipefail

HOOK_NAMES="applypatch-msg pre-applypatch post-applypatch pre-commit prepare-commit-msg commit-msg post-commit pre-rebase post-checkout post-merge pre-receive update post-receive post-update pre-auto-gc pre-push"

GIT_ROOT="$(git rev-parse --show-toplevel)"
HOOK_DIR="${GIT_ROOT}/.git/hooks"
HOOK_WRAPPER="${GIT_ROOT}/.bin/hooks_wrapper.sh"

if [[ ! -d "${HOOK_DIR}" ]]; then
    mkdir "${HOOK_DIR}"
fi

for hook in ${HOOK_NAMES}; do
    # If the hook already exists, is executable, and is not a symlink
    if [[ ! -h "${HOOK_DIR}/${hook}" ]] &&  [[ -f "${HOOK_DIR}/${hook}" ]]; then
        mv "${HOOK_DIR}/${hook}" "${HOOK_DIR}/${hook}.local"
    fi

    # Create the symlink, overwriting the file if it exists.
    ln -s -f "${HOOK_WRAPPER}" "${HOOK_DIR}/${hook}"
done
