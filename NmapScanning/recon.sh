#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./recon.sh <ip>"
  exit 1
fi
printf "\n ------Nmap ------\n\n" >results
echo "=================================================== "
figlet -f Bloody "Scanning...." | lolcat -a -d 12
echo "Nmap Scanning Open Ports...."
nmap $1 | tail -n +5 | head -n -3 >results

while read line; do
  if [[ $line == *open* ]] && [[ $line == *http* ]]; then
    echo "Running WhatWeb...."
    whatweb $1 -v >temp
  fi

done <results

if [ -e temp ]; then
  printf "\n ------------Web--------------\n\n" >>results
  cat temp >>results
  rm temp
fi
cat results
echo "Scanning With NMAP completed!"
