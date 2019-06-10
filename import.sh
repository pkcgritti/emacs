#!/bin/bash

echo "Copying .emacs file"
cp ~/.emacs src/.emacs

echo "Copying elisp folder"
cp -r ~/.emacs.d/elisp src/elisp

echo "Done"
