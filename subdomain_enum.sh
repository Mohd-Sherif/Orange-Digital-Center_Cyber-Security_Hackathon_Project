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

        echo "++++++ Checking Validation ++++++"
        if [ -a valid.txt ]
        then
                rm valid.txt
        fi
        for sub in $(cat subdomains.txt)
        do
                if [[ $(ping -c 1 $sub 2> /dev/null) ]]
                then
                        echo "$sub ++++++ Valid"
                        echo $sub >> valid.txt
                else
                        echo "$sub ------ Error"
                fi
        done

