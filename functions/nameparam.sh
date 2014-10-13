#!/bin/bash
# Serhiy Zahoriya 2014
# https://github.com/int-ua/bash-scripts

# Function for easy positional parameters naming

## Usage:
# source ~/bin/functions/nameparam.sh || exit 1
# nameparam "$1" "var_name"
# echo $var_name

function nameparam() {
	if [[ $1 == "" ]]; then
		local input=""
		read -p "${2}:" input
		eval "$2=\"$(echo $input)\""
	else
		eval "$2=\"$(echo $1)\""
	fi
}
