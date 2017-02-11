#!/usr/bin/env bash

function install() {
    echo "Download Mac Cleanup"
    curl -o cleanup.sh https://raw.githubusercontent.com/fwartner/mac-cleanup/master/cleanup.sh
    echo "Init Mac Cleanup"
    chmod +x cleanup.sh
    echo "Install Mac Cleanup"
    sudo mv cleanup.sh /usr/local/bin/cleanup.sh
}

function uninstall() {
    echo "Uninstall Mac Cleanup"
    sudo rm /usr/local/bin/cleanup.sh
}

case $1 in
    uninstall)
        uninstall
		exit
        ;;
    update)
        install
        exit
        ;;
    *)
		install
		exit
        ;;
esac
