#!/bin/sh

ACTION="$1"

test -z "$BASHRC" && BASHRC="$HOME/.bashrc"
test -z "$BASHRCBAK" && BASHRCBAK="$PWD/.bashrc.bak"
test -z "$BASHRCGIT" && BASHRCGIT="$PWD/.bashrc"
test -z "$SPLITTER" && SPLITTER="#-----------------------------------------------------------------------------#"

track_files() {
	local action="$1"
	"$action" "$PWD/.inputrc" "$HOME/.inputrc"
	"$action" "$PWD/init.vim" "$HOME/.config/nvim/init.vim"
}

backup_single() {
	echo "- backup \"$(basename "$2")\""
	cp "$2" "$1"
}

restore_single() {
	echo "- restore \"$(basename "$2")\""
	cp "$1" "$2"
}

get_custom_section_start_line() {
	grep "$1" -xnFe "$SPLITTER" | head -1 | sed 's/^\([[:digit:]]\+\).*$/\1/'
}

patch_bashrc() {
	echo "- patch \"$(basename "$BASHRC")\""
	cp "$BASHRC" "$BASHRCBAK"
	local custom_start=`get_custom_section_start_line "$BASHRCBAK"`
	if test -z "$custom_start"
	then
		echo "$SPLITTER" >>"$BASHRC"
	else
		head -n "$custom_start" "$BASHRCBAK" >"$BASHRC"
	fi
	cat "./.bashrc" >>"$BASHRC"
}

extract_bashrc() {
	echo "- extract \"$(basename "$BASHRC")\""
	local custom_start=`get_custom_section_start_line "$BASHRC"`
	if test -z "$custom_start"
	then
		cp "$BASHRC" "$BASHRCGIT"
	else
		sed "1,${custom_start}d" "$BASHRC" >"$BASHRCGIT"
	fi
}

backup() {
	extract_bashrc
	track_files backup_single
}

restore() {
	patch_bashrc
	track_files restore_single
}

case "$ACTION" in
backup|restore)
	echo
	echo "\tperform ${ACTION}..."
	echo
	"$ACTION"
	;;
*)
	echo "usage: $0 (backup|restore)"
	;;
esac

