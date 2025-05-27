#!/bin/bash

#pc=`ps aux | grep -v grep | grep  speed | wc -l `

#if [ $pc  -eq 0 ]
#then



while read line
do

web=`echo $line|cut -d ":" -f 1`
url=`echo $line|cut -d ":" -f 2`

curl -I --connect-timeout 1000 -w "%{time_total}\n" "$web""://""$url"  2>/dev/null  1>/tmp/curlurl-response"$url"
Flag=$?

if [ $Flag -eq 0 ]
then
        code=$Flag
        time=`tail -n1 /tmp/curlurl-response"$url"`
        echo "code:$code" > /tmp/FDI-curlurl-response-"$url"
        echo "time:$time" >> /tmp/FDI-curlurl-response-"$url"

else

        echo "code:$Flag" > /tmp/FDI-curlurl-response-"$url"
        echo "time:0" >> /tmp/FDI-curlurl-response-"$url"

fi

done < /home/pi/FDI-http-s-url-list
