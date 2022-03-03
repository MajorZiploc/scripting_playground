function just_get_project_info {
  local excluded_extensions="$1";
  local extra_exclude_patterns="$2";
  local dead_code_lines="$3";
  [[ -z "$excluded_extensions" ]] && { echo "Must specify excluded_extensions!" >&2; return 1; }
  [[ -z "$extra_exclude_patterns" ]] && { echo "Must specify extra_exclude_patterns!" >&2; return 1; }
  [[ -z "$dead_code_lines" ]] && { echo "Must specify dead_code_lines!" >&2; return 1; }
  echo "file_type,line_count";
  local extensions=(`gfind_files ".*" | egrep -vi "$excluded_extensions" | egrep -vi "$extra_exclude_patterns" | sed -E 's/.*?(\..*)/\1/;s/.*?\/(.*)/\1/g' | to_lower | egrep "^\." | sort -u`);
  for extension in ${extensions[@]}; do
    local counts=$(cat `gfind_files ".*$extension" | egrep -vi "$excluded_extensions" | egrep -vi "$extra_exclude_patterns"` | egrep -vi "$dead_code_lines" | wc -l | trim | sed -E 's,\s+,\,,g');
    echo "$extension,$counts";
  done;
}

