#!/bin/bash

#This tool developed by Mohamed Sherif
#ODC Hackathon

if [ $# -eq 0 ]
then
        echo "How to use: ./subdomain_enum.sh <DOMAIN>"
        echo "EX: ./subdomain_enum.sh yahoo.com"
else

	echo "++++++ Scanning Subdomains ++++++"
	if [ -a subdomains.txt ]
	then
       		rm subdomains.txt
	fi
	subfinder -d $1 -o subdomains.txt

