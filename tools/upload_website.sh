#!/bin/bash

# Simple script for Travis-CI
# @author: Polonio Davide poloniodavide@gmail.com
# @license: GPLv3

function load_lib() {
    
    #Lib da tools
    source doc/tools/lib.sh || {error "Can't found doc/tools/lib.sh. Exiting"; exit 1}

    #lib_config da tools
    source doc/tools/lib_config.sh || {error "Can't found doc/tools/lib_config.sh. Exiting"; exit 1}

    #file di config anche per questo script?
}

function launch_syncronization() {

    #TODO -> rsync via ssh
}
