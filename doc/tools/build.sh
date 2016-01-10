#!/bin/bash

#@author: Polonio Davide
#@license: GPLv3

function build() {

    #"vecchio" comando
    #pdflatex \\nonstopmode\\input main.tex && pdflatex \\nonstopmode\\input main.tex


    #questo e' piu' compatibile
    latexmk -pdflatex='pdflatex -interaction=nonstopmode' -pdf

}

build
