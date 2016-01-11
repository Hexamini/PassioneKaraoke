#!/bin/bash

#@author: Polonio Davide
#@license: GPLv3

function install_dependencies() {
    sudo add-apt-repository ppa:texlive-backports/ppa -y
    sudo apt-get update -y
    sudo apt-get install texlive-latex-extra -y 
    sudo apt-get install texlive-luatex -y
    sudo apt-get install texlive-fonts-extra -y
    sudo apt-get install cm-super -y
    sudo apt-get install texlive-bibtex-extra -y
    sudo apt-get install latexmk -y
    sudo apt-get install tex4ht -y
    wget http://tug.org/fonts/getnonfreefonts/install-getnonfreefonts
    sudo texlua install-getnonfreefonts
    sudo getnonfreefonts-sys garamond

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