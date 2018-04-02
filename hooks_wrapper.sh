#!/usr/bin/env bash
# Runs all executable hooks and propagates aggregated exit codes.
set -o errexit
set -o pipefail

HOOKNAME="$(basename "$0")"
GIT_ROOT="$(git rev-parse --show-toplevel)"
CUSTOM_HOOKS_DIR="${GIT_ROOT}/.bin/hooks"
NATIVE_HOOKS_DIR="${GIT_ROOT}/.git/hooks"

exitcodes=()

# Run each hook, passing through STDIN and storing the exit code.
for hook in "${CUSTOM_HOOKS_DIR}/$(basename "$0")"-*; do
  test -x "${hook}" || continue
  {
    out=$("${hook}" "$@")
    exitcodes+=($?)
  } || : # Avoid errexit
  [ ! -z "${out}" ] && echo "${out}"
done

# Check if there was a local hook that was moved previously.
if [ -f "${NATIVE_HOOKS_DIR}/${HOOKNAME}.local" ]; then
    out=$("${NATIVE_HOOKS_DIR}/${HOOKNAME}.local" "$@")
    exitcodes+=($?)
    [ ! -z "${out}" ] && echo "${out}"
fi

# If any exit code isn't 0, bail.
for i in "${exitcodes[@]}"; do
  [ "${i}" == 0 ] || exit "${i}"
done
