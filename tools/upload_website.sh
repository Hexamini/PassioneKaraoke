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

function fix_permissions() {

    msg d "Fixing Permissions"
    
    chmod 400 id_rsa
}

function launch_syncronization() {

    #rsync via ssh

    ssh $USERNAME@$FIRST_URL -i id_rsa "git clone --branch=$TRAVIS_BRANCH https://github.com/Hexamini/PassioneKaraoke.git tmpTravis && rsync -avz -e ssh  ~/tmpTravis/ $USERNAME@$WEBSERVER_URL:/home/2/2013/dpolonio/tecweb && rm -rf ~/tmpTravis/"

}

function check_if_allowed_branch() {

    if [ "$TRAVIS_BRANCH" == "test" ] || [ "$TRAVIS_BRANCH" == "master" ]
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
    check_if_allowed_branch

    fix_permissions
    
    launch_syncronization

    exit 0
}

#main
main
