#!/usr/bin/env bash

projects=("Common" "Services" "Tools")

for project in "${projects[@]}"; do
	az repos list --org "https://<devops url or selfhosted url>/<organization-name>" -p "$project" -o tsv --query '[].remoteUrl' >>repos.txt
done

cat repos.txt | while IFS= read -r line; do
	git clone --config credential.helper=\"store\" "$line"
done

rm repos.txt
