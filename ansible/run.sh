#!/usr/bin/env bash
cd "$(dirname "$0")"

function run_playbook() {
  echo "Configure $opt"
  ansible-playbook ${opt}.yml -i ./inventory.yml
}

PS3='Which host to configure? '
options=("host-a" "host-b" "quit")
select opt in "${options[@]}"
do
    case $opt in
        "host-a" | "host-b" )
            run_playbook
            break
            ;;
        "quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done