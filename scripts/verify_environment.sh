#!/usr/bin/env bash

set -euo pipefail

required_commands=(bash git g++ make python3 curl vim)

for command_name in "${required_commands[@]}"; do
    command -v "${command_name}" >/dev/null
    printf 'found: %s\n' "${command_name}"
done

test "$(basename "${SHELL:-}")" = "bash"

temporary_binary="$(mktemp)"
temporary_output="$(mktemp)"
server_log="$(mktemp)"
server_pid=""

cleanup() {
    if [[ -n "${server_pid}" ]]; then
        kill "${server_pid}" 2>/dev/null || true
        wait "${server_pid}" 2>/dev/null || true
    fi
    rm -f "${temporary_binary}" "${temporary_output}" "${server_log}"
}

trap cleanup EXIT

g++ add.cpp -o "${temporary_binary}"
printf '12 30\n' | "${temporary_binary}" >"${temporary_output}"
grep -q 'Sum: 42' "${temporary_output}"
printf 'passed: C++ compile and standard input\n'

python3 -c 'import fastapi, uvicorn'
printf 'passed: Python dependencies\n'

uvicorn app.main:app --host 127.0.0.1 --port 8000 >"${server_log}" 2>&1 &
server_pid="$!"

for _ in {1..30}; do
    if curl --fail --silent http://127.0.0.1:8000/health | grep -q '"status":"ok"'; then
        printf 'passed: FastAPI health check\n'
        printf 'POC verification passed.\n'
        exit 0
    fi
    sleep 1
done

printf 'FastAPI did not become ready. Server log:\n' >&2
sed -n '1,120p' "${server_log}" >&2
exit 1
