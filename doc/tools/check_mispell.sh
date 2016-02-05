#!/bin/bash

function load_components() {

    source mispell_config.sh
    local isLibLoaded=$?

    if [ $isLibLoaded -eq 1 ]
    then
	echo "Couldn't load successfully mispell_config.sh. Exiting"
	exit 1
    fi

    
    source lib.sh
    local isLibLoaded=$?

    if [ $isLibLoaded -eq 1 ]
    then
	echo "Couldn't load successfully lib.sh. Exiting"
	exit 1
    fi

    source lib_config.sh
    local isLibLoaded=$?

    if [ $isLibLoaded -eq 1 ]
    then
	msg e "Couldn't load successfully lib_config.sh. Exiting"
	exit 1
    fi
    
}

function check() {

    cd $TEX_SOURCE

    local result=$?
    if [ $result -eq 1 ]
    then
	msg e "Cannot cd in $TEX_SOURCE, exiting"
	exit 1
    fi

    
    for i in *.tex
    do

	local check=`cat $i | aspell $ASPELL_PARAM | tail -n +2 | grep -e"#" -e"&"`

        result=$?
	if [ $result -eq 0 ]
	then
	    msg e "Sono stati trovati degli errori in $i."
	    msg v "Nota: i mispelling sono segnalati con la &, gli errori con la #.
$check"
	    exit 1
	else
	    msg v "Tutto ok, nessun errore trovato"
	fi
    done
	
}

function main() {

    load_components
    check
    
    exit 0
}


#call main
main
