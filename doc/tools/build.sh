#!/bin/bash

#@author: Polonio Davide
#@license: GPLv3

function install_dependencies() {
    su -c "add-apt-repository ppa:texlive-backports/ppa -y"
    su -c "apt-get update -y"
    su -c "apt-get install texlive-latex-extra -y "
    su -c "apt-get install texlive-luatex -y"
    su -c "apt-get install texlive-fonts-extra -y"
    su -c "apt-get install cm-super -y"
    su -c "apt-get install texlive-bibtex-extra -y"
    su -c "apt-get install latexmk -y"
    su -c "apt-get install tex4ht -y"
    su -c "wget http://tug.org/fonts/getnonfreefonts/install-getnonfreefonts"
    su -c "texlua install-getnonfreefonts"
    su -c "getnonfreefonts-sys garamond"

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
