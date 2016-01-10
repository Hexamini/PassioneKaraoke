#!/bin/bash

# Simple script that upload PassioneKaraoke on server after Travis-CI checks only
# if this isn't a pull request.
# @author: Polonio Davide poloniodavide@gmail.com
# @license: GPLv3

VERSION=0.0.1

function load_lib() {

    #lib_config from tools
    source ../doc/tools/lib_config.sh || exit 1

    
    #Lib from tools
    source ../doc/tools/lib.sh || exit 1
    
}

function launch_syncronization() {

    #rsync via ssh

    ssh $USERNAME@$FIRST_URL -i id_rsa "git clone --branch=test https://github.com/Hexamini/PassioneKaraoke.git tmpTravis && rsync -avz -e ssh $USERNAME@$WEBSERVER_URL:/home/2/2013/dpolonio/tecweb ~/tmpTravis/ && rm -rf ~/tmpTravis/"

}

function check_if_allowed_brach() {

    #last condition is only for dev purpose
    if [ "$TRAVIS_BRANCH" == "test" ] || [ "$TRAVIS_BRANCH" == "master" ] || [ "$TRAVIS_BRANCH" == "davide/feat/ToolIntegration" ]
    then
	msg v "I'm uploading $TRAVIS_BRANCH on the web server"
    else
	msg v "I only upload test or master branch on the web server. Terminating"
	exit 0
    fi
}

function check_if_pull_request() {

    if [ "$TRAVIS_PULL_REQUEST" == "false" ]
    then
	msg d "This is not a pull request. Continuing"
    else
	msg v "This is a pull request. Pull request aren't pulled in the web server"
	exit 0
    fi
}


function main() {

    load_lib
    msg v "Version: $VERSION"

    check_if_pull_request
    check_if_allowed_brach

    launch_syncronization

    exit 0
}

#main
main
