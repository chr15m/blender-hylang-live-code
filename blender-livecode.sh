#!/usr/bin/env bash
if [ "$1" == "" ]
then
	echo "Watches HYLANGFILE for changes and reloads in Blender"
	echo "Usage: $0 HYLANGFILE"
	echo "e.g. $0 entry.hy"
else
	blender --python entry-py-watcher.py $1
fi
