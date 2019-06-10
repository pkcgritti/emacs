#!/bin/bash

echo "Copying .emacs file"
cp src/.emacs ~/.emacs

echo "Copying elisp folder"
mkdir -p ~/.emacs.d/elisp
cp -r src/elisp ~/.emacs.d/elisp

echo "Done"
