#!/bin/bash

SCRIPTS=("build_script.sh" "copy_artifacts.sh")
SCRIPTS_REPO_RAW='https://raw.githubusercontent.com/minz1/jenkins_scripts/master/'

for script in "${SCRIPTS[@]}"
do
    rm $script
    wget "$SCRIPTS_REPO_RAW$script"
done
