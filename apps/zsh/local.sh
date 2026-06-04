#!/usr/bin/env bash

# export RIBYNS_ENV_LOG_VERBOSE=false # defaults to true
# export RIBYNS_ENV_LOG_INFO=false # defaults to true
# export CODE_COMPANION_DEFAULT_ADAPTER="ollama"
# export CODE_COMPANION_OLLAMA_MODEL="qwen2.5-coder:3b"

# NOTE: Extend CDPATH with annoying to reach sub-dirs
# allows you to cd into the sub-dirs of the added dirs
# export CDPATH="$HOME/Projects:$HOME/Projects/Domain:$CDPATH"
# cd ProjectA (~/Projects/Domain/ProjectA)
# cd Domain (~/Projects/Domain)

# NOTE: example on navigating the filesystem for a specific env more easy using fzf
#
# abbr() {
# 	local cmd="$1"
#
# 	if [[ "$cmd" == "build" ]]; then
# 		shift
# 		dotnet build /p:NuGetAudit=false -v m "$@"
# 	elif [[ "$cmd" == "cd" ]]; then
# 		cd "$( (
# 			fd --max-depth 1 --type d . ~/customer
# 			fd --max-depth 1 --type d . ~/customer/other-projects
# 		) | fzf)" || exit 1
# 	elif [[ "$cmd" == "clone" ]]; then
# 		shift
# 		git clone "$@"
# 	else
# 		[[ -n "$cmd" ]] && echo "abbr: unknown command '$cmd'"
# 		echo "Available commands: build, cd, clone"
# 		return 1
# 	fi
# }
# # tab completion
# complete -W "build cd clone run" abbr
