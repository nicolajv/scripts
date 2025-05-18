#!/bin/bash

desired_labels=(
    '{"name":"bug","color":"d73a4a","description":"Fix for a bug impacting users"}'
    '{"name":"enhancement","color":"0e8a16","description":"New feature or request"}'
    '{"name":"chore","color":"910cab","description":"An updating or grunt task, ie. no user relevant code change"}'
    '{"name":"patch","color":"1d76db","description":"Backwards compatible bug fixes or transparent changes"}'
    '{"name":"minor","color":"006b75","description":"Adding new functionality in a backwards compatible manner"}'
    '{"name":"major","color":"b60205","description":"Breaking changes, ie. not backwards compatible"}'
)

labels=$(gh label list --json name --jq '.[].name')

for label in "${desired_labels[@]}"; do
    label_name=$(echo "$label" | jq -r '.name')
    mode="create"
    if echo "$labels" | grep -q "^$label_name$"; then
        mode="edit"
    fi
    gh label "$mode" "$label_name" --color "$(echo "$label" | jq -r '.color')" --description "$(echo "$label" | jq -r '.description')"
done

if [ -n "$labels" ]; then
    while IFS= read -r label; do
        if echo "${desired_labels[@]}" | grep -q "\"name\":\"$label\""; then
            continue
        fi
        gh label delete "$label" --yes
    done <<<"$labels"
fi
