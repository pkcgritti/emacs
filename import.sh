#!/bin/bash

echo "Copying .emacs file"
mkdir -p src/
cp ~/.emacs src/

echo "Copying elisp folder"
mkdir -p src/elisp
cp -r ~/.emacs.d/elisp/* src/elisp

echo "Done"
