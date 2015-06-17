#!/usr/bin/env bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# pip install --ignore-installed --install-option="--prefix=$DIR/modules" hy
# --prefix/--install-data/--install-scripts
# pip install --ignore-installed --install-option="--install-purelib=$DIR/modules" --install-option="--install-scripts=$DIR/bin" hy
# PYTHONUSERBASE=$DIR/modules pip install --ignore-installed --user hy

pip install --ignore-installed --install-option="--prefix=$DIR/modules"  --install-option="--install-purelib=$DIR/modules" hy
