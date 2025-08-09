#!/bin/bash


export DIALOGRC=./dialogrc
dialog --colors --title "UNISEC" --msgbox "$(cat ./about-unisec.txt)" 100 100 --ok-label "Next"

exec 3>&1

FORM_DATA=$(dialog --title "UNISEC: User Details" --form "Enter User Details" 15 50 0 \
"Name: "  1 1 "" 1 10 20 0 \
"Email: " 2 1 "" 2 10 20 0 \
2>&1 1>&3)

exec 3>&-

EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
  echo "User cancelled (Exit Code: $EXIT_CODE). Exiting."
  exit 1
fi

TSV_LINE=$(echo "$FORM_DATA" | paste -sd '\t' -)

echo "$TSV_LINE" >> signup.tsv
