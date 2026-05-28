#!/usr/bin/env bash

# Check if the user actually passed an argument
if [ -z "$1" ]; then
	echo "❌ Error: Please provide a git command."
	echo "Usage: $0 <git-command>"
	echo "Example: $0 \"git switch dev\""
	echo "Example: $0 fetch"
	exit 1
fi

for dir in */; do
	# Strip the trailing slash for cleaner echo statements
	dir="${dir%/}"

	# Check if it's a directory and contains a .git folder
	if [ -d "$dir/.git" ]; then
		echo "Entering repository: $dir"
		cd "$dir" || exit
		"$@"
		cd ..

		echo "--------------------------------------------------"
	else
		echo "Skipping $dir (Not a Git repository)"
		continue
	fi
done
