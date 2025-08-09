#!/bin/bash


export DIALOGRC=./dialogrc

dialog --colors --title "UNISEC" --msgbox "$(cat ./about-unisec.txt)" 100 100 --ok-label "Next"
