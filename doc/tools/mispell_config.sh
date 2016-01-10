#!/bin/bash

#CONFIGURATION FILE FOR check_mispell.sh

ASPELL_PERSONAL="../../tools/dictionary/personal.txt"
ASPELL_REPL="../../tools/dictionary/replacements.txt"
ASPELL_PARAM="--lang it --mode tex --encoding utf-8 --personal \"$ASPELL_PERSONAL\" --repl \"$ASPELL_REPL\" -a"
TEX_SOURCE="../res/chapter/"


#verbose?
VERBOSE=1

#debug?
DEBUG=1
