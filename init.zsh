0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"


if (( $+commands[starship] )); then
  starship_path="${commands[starship]}"
else
  zstyle -a ':plugin:starship' path starship_path
fi
test -z "${starship_path}" && return 1

cache_file="${TMPDIR:-/tmp}/starship-cache.$UID.zsh"
if [[ ! -s "$cache_file"  ]]; then
  # Cache init code.
  "${starship_path}" init zsh --print-full-init >| "${cache_file}" 2>/dev/null
  zcompile "$cache_file" >/dev/null 2>&1
fi

source "${cache_file}"
unset cache_file starship_path
