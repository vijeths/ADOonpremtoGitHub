#!/bin/bash

##read -p 'Azure DevOps Username (not email): ' BB_USERNAME
##read -sp 'Azure DevOps Password: ' BB_PASSWORD

next_url="https://api.bitbucket.org/2.0/repositories?role=member"
while [ ! -z "$next_url" ]; do
    response_json=$( curl -s --user $BB_USERNAME:$BB_PASSWORD "$next_url" )
    echo "$response_json" | jq -r '.values | map([.slug, .workspace.slug, .description, .is_private] | @csv) | join("\n")'
    next_url=$( echo "$response_json" | jq -r '.next' )
done
