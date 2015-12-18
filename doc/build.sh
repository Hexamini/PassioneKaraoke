#!/bin/bash

#@author: Polonio Davide
#@license: GPLv3

function build() {

    pdflatex \\nonstopmode\\input main.tex && pdflatex \\nonstopmode\\input main.tex

    #2 volte per aggiornare l'indice

}

build
