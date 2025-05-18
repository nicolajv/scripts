#!/bin/bash

labels=$(gh label list --json name --jq '.[].name')

if [ ! -z "$labels" ]; then
    while IFS= read -r label; do
        gh label delete "$label" --yes
    done <<<"$labels"
fi

gh label create "bug" --color "d73a4a" --description "Fix for a bug impacting users"
gh label create "enhancement" --color "0e8a16" --description "New feature or request"
gh label create "chore" --color "910cab" --description "An updating or grunt task, ie. no user relevant code change"
gh label create "patch" --color "1d76db" --description "Backwards compatible bug fixes or transparent changes"
gh label create "minor" --color "006b75" --description "Adding new functionality in a backwards compatible manner"
gh label create "major" --color "b60205" --description "Breaking changes, ie. not backwards compatible"
