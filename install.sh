#!/bin/bash
# TODO: improve the "find"
for file in $(find . -type f | grep -v git | grep -v tags | grep -v README | grep -v install.sh); do
    echo "Creating symlink from $(pwd)/$file to $HOME/$file"
    ln -s -b -f "$(pwd)/$file" "$HOME/$file"
done
