#!/usr/bin/env bash

. ~/.bashrc;

function f {
  for proj in `find . -mindepth 1 -maxdepth 1 -type d`; do
    cd "$proj";
    local files=`find_files ".*\.gitignore" "" "3"`;
    local num_of_files=`echo "$files" | wc -l`;
    [[ $num_of_files -gt 1 ]];
    local should_update_git=$?;
    [[ $should_update_git -eq 0 ]] && {
      echo "PROJECT: `pwd`";
      echo "git prep";
      git stash push --message "storing changes before merging gitignores";
      git checkout develop;
      git pull;
      echo "$files";
      echo "$num_of_files";
      touch .gitignore;
      local content="";
      for file in ${files[@]}; do
        content="$content
        `cat "$file"`
        "
        rm "$file";
        git add "$file";
      done;
      content=`echo "$content" | trim | keep_first`;
      echo "$content" > .gitignore;
      git add .gitignore;
      git --no-pager status;
      git commit -m "Merges .gitignores into 1 file";
      git push;
      echo "git push done";
    }
    cd ..;
  done;
}

f

