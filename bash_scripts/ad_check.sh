#!/usr/bin/env bash

. ~/.bashrc;

echo "project,found_in,search_command"
for proj in `find . -mindepth 1 -maxdepth 1 -type d`; do
  cd "$proj";
  searches='
gfind_files ".*\...proj" "Novell.*Ldap" "15"
gfind_files ".*" "[^[:blank:]]{3,6}ldap.acadian.amb" "15"
gfind_files ".*\.(vb|cs|fs)" "ldap" "15"'
  IFS=$'\n'
  for search in ${searches}; do
    search_results=`bash -c ". ~/.bashrc;$search" | uniq | trim | tr ",\n" "; " | trim`;
    [[ $search_results = *[![:space:]]* ]] && {
      echo "`basename $(pwd)`,`$search_results | tr ",\"" ";'"`,\"$search\"";
    }
  done;
  unset IFS
  cd ..;
done;

