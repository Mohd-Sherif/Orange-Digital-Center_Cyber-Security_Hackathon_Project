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

	echo "++++++ Taking Screenshots ++++++"
	if [ -d ./screenshots ]
	then
		rm -rf ./screenshots
	fi
	mkdir screenshots
	for valid_sub in $(cat valid.txt)
	do
		cd screenshots
		capture-website https://$valid_sub --output=$valid_sub.png
		echo "$valid_sub ++++ Done"
		cd ..
	done

        echo "++++++ Grepping IPs ++++++"
        echo "****** May take some time ******"
        if [ -a IPs.txt ]
        then
                rm IPs.txt
        fi
        for ip in $(cat valid.txt)
        do
                host $ip | grep "has address" | cut -d " " -f 4 >> IPs.txt
        done
        cat IPs.txt

