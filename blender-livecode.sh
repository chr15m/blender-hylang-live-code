#!/usr/bin/env bash
if [ "$1" == "" ]
then
	echo "Usage: $0 HYLANGFILE [BLENDFILE.blend]"
	echo "Watches HYLANGFILE for changes in Blender and reloads on save, frame change:"
	echo "e.g. $0 entry.hy"
else
	if [ "$2" == "" ]
	then
		bf="blank.blend"
	else
		bf="$2"
	fi
	HY_ENTRY_FILE="$1" blender  "$bf" --python entry-py-watcher.py
fi
