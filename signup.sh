#!/bin/bash


export DIALOGRC=./dialogrc
while true; do
  dialog --colors --title "UNISEC" --msgbox "$(cat ./about-unisec.txt)" 100 100 --ok-label "Next"

  while true; do
    FORM_DATA=$(dialog --stdout --title "UNISEC: User Details" \
      --form "Enter User Details" 15 50 0 \
      "Name: "  1 1 ""  1 10 20 0 \
      "Email: " 2 1 ""  2 10 20 0 \
      "Year: " 3 1 "" 3 10 20 0 \
      "What days of week/times work best for you?" 4 1 "" 5 0 50 0)

    if [ $? -ne 0 ]; then
      break
    fi

    NAME=$(echo "$FORM_DATA" | sed -n 1p)
    EMAIL=$(echo "$FORM_DATA" | sed -n 2p)
    YEAR=$(echo "$FORM_DATA" | sed -n 3p)
    TIME=$(echo "$FORM_DATA" | sed -n 4p)

    if [ -z "$NAME" ] || [ -z "$EMAIL" ] || [ -z "$YEAR" ] || [ -z "$TIME" ]; then
      dialog --title "Error" --msgbox "All fields are required. Please fill them in." 6 50
      continue
    fi

    break
  done


  EXIT_CODE=$?
  if [ $EXIT_CODE -ne 0 ]; then
    echo "User cancelled (Exit Code: $EXIT_CODE). Exiting."
    exit 1
  fi

  TSV_LINE=$(echo "$FORM_DATA" | paste -sd '\t' -)

  echo "$TSV_LINE" >> signup.tsv
done
