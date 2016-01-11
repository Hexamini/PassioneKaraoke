#!/bin/bash

#@author: Polonio Davide
#@license: GPLv3

function install_dependencies() {
    add-apt-repository ppa:texlive-backports/ppa -y
    apt-get update -y
    apt-get install texlive-latex-extra -y 
    apt-get install texlive-luatex -y
    apt-get install texlive-fonts-extra -y
    apt-get install cm-super -y
    apt-get install texlive-bibtex-extra -y
    apt-get install latexmk -y
    apt-get install tex4ht -y
    wget http://tug.org/fonts/getnonfreefonts/install-getnonfreefonts
    texlua install-getnonfreefonts
    getnonfreefonts-sys garamond

}

function build() {

    #"vecchio" comando
    #pdflatex \\nonstopmode\\input main.tex && pdflatex \\nonstopmode\\input main.tex


    #questo e' piu' compatibile
    latexmk -pdflatex='pdflatex -interaction=nonstopmode' -pdf

}

function main() {

     build
     install_dependencies
	
}

#call main
main
