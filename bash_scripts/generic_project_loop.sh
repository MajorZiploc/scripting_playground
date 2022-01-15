#!/usr/bin/env bash

. ~/.bashrc;

cd ~/projects;

projects='
./rust_data_analytics
./tab_generator
./tamper-monkey-scripts
./jetbrains-settings
./personal_notes
./powershell_scaffolder
./resume
./web-scraper-chrome-extension
./remesh_prompt
./json-test-utility
./BodyComp
./scripting_playground
./english_to_lang_notes
./pandas_data_analytics
./pandas_preprocessor
./techworld-js-docker-demo-app
./web_scraper_py
./tooling_notes
./gba_save_states
./tmux
./FslabDataAnalytics
./home-settings
./PSLogFileReporter
./python_ml_models
./web_scraper_io_scripts
./google.app.suite.scripts
./game_py
'
projects=(`echo "$projects" | xargs`);

for proj in ${projects[@]}; do
  cd "$proj";
  pwd;
  cd ..;
done;

