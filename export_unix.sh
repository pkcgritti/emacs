#!/bin/bash

echo "Exporting git config"
echo "Exporting .emacs"
cp src/init.el ~/.emacs
cp -r src/lisp ~/.emacs.d/
