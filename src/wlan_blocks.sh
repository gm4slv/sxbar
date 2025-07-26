#!/bin/bash
#
#
IP=`ip a | grep 255 | grep wlan | awk 'OFS=": " {print $2}'  | sed 's/\/24//'`
QUALITY=`iwconfig wlan0 | grep Quality | awk '{print $2}' | sed 's/\=/\ /' | awk '{print $2}'  | sed 's/\//\ /' `
SIGNALS=`echo $QUALITY | awk '{print $1}'`
NOISES=`echo $QUALITY | awk '{print $2}'`
SNR=$(echo "scale=3; $(($SIGNALS)) / $(($NOISES))" | bc)
SNR2=$(echo "scale=3; $SNR * 100 "| bc )
AP=`iwconfig wlan0 | grep ESSID | awk '{print $4}' | sed s/^ESSID:/\ / | sed s/\"//g`


echo $IP $AP "("${SNR2%.*}"%"")"
