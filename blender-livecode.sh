#!/usr/bin/env bash
if [ "$1" == "" ]
then
	echo "Usage: $0 HYLANGFILE"
	echo "Watches HYLANGFILE for changes in Blender and reloads on save, frame change:"
	echo "e.g. $0 entry.hy"
else
	blender --python entry-py-watcher.py $1
fi
