#!/usr/bin/env bash
# Derived from lodar/awesome-self-hosted-agents/check.sh (CC0-1.0).
# Read public default-branch commit feeds and repository archive banners.
set -uo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd) || exit 2
for tool in curl grep sed date sort head cat; do
  command -v "$tool" >/dev/null || { echo "ERROR missing $tool" >&2; exit 2; }
done
readme="${1:-$script_dir/README.md}"
max_days="${2:-90}"
[[ "$max_days" =~ ^[1-9][0-9]*$ ]] || { echo "ERROR age threshold must be positive integer days" >&2; exit 2; }
[[ -r "$readme" ]] || { echo "ERROR unreadable README: $readme" >&2; exit 2; }
work=$(mktemp -d) || exit 2
trap 'rm -rf -- "$work"' EXIT
mapfile -t repos < <(grep -Eo 'https://github.com/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' "$readme" | sed -E 's/\.git$//' | sort -u)
[[ ${#repos[@]} -gt 0 ]] || { echo 'ERROR no repository entries'; exit 2; }
now=$(date -u +%s)
check_repo() {
  local repo="$1" output="$2" feed="$3" page="$4" stamp epoch age state=OK archived=no
  if ! curl --fail --silent --show-error --location --retry 1 --connect-timeout 10 --max-time 35 "$repo/commits.atom" > "$feed"; then
    printf '%s\tUNKNOWN\tFLAG feed-fetch\n' "$repo" > "$output"; return
  fi
  stamp=$(sed -nE 's@.*<updated>([^<]+)</updated>.*@\1@p' "$feed" | head -n 1)
  if [[ -z "$stamp" ]] || ! epoch=$(date -u -d "$stamp" +%s 2>/dev/null); then
    printf '%s\tUNKNOWN\tFLAG invalid-feed-date\n' "$repo" > "$output"; return
  fi
  age=$(( (now - epoch) / 86400 ))
  if (( now - epoch > max_days * 86400 )); then state="FLAG over-${max_days}-days"; fi
  if (( epoch > now + 86400 )); then state='FLAG future-date'; fi
  if ! curl --fail --silent --show-error --location --retry 1 --connect-timeout 10 --max-time 35 "$repo" > "$page"; then
    state+='; FLAG archive-check-fetch'; archived=unknown
  elif grep -qiE 'This repository (was|has been) archived|This repository is archived' "$page"; then
    state+='; FLAG archived'; archived=yes
  elif ! grep -qE 'repository|Repository' "$page"; then
    state+='; FLAG invalid-repository-page'; archived=unknown
  fi
  printf '%s\t%s\t%s days\t%s\t%s\n' "$repo" "$stamp" "$age" "$archived" "$state" > "$output"
}
printf 'repository\tlast_commit\tage\tarchived\tstatus\n'
# At most four public fetch workers; collect each repository's output once.
for ((i=0; i<${#repos[@]}; i++)); do
  check_repo "${repos[i]}" "$work/$i.out" "$work/$i.atom" "$work/$i.html" &
  if (( (i+1) % 4 == 0 )); then wait; fi
done
wait
status=0
for ((i=0; i<${#repos[@]}; i++)); do
  if [[ ! -s "$work/$i.out" ]]; then
    printf '%s\tUNKNOWN\tFLAG worker-missing\n' "${repos[i]}"; status=1
  else
    cat "$work/$i.out"
    if grep -q 'FLAG' "$work/$i.out"; then status=1; fi
  fi
done
printf 'Checked %s repositories; exit %s\n' "${#repos[@]}" "$status"
exit "$status"
