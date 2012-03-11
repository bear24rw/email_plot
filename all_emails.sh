#!/bin/zsh

filename='all_emails'

echo "" > ${filename}.txt

for i in /media/other/backups/gmail/\[Gmail\].All\ Mail/cur/*; do 

    ddate=`egrep -i -m1 "^Date:" "$i" | egrep -o -m1 "[0-9]{1,2}.*?[A-Za-z]{3}.*?[0-9]{4}.*?[0-9]{2}:[0-9]{2}" | sed 's/:/ /g' | tr -s " " | awk '{print $1"-"$2"-"$3" "$4" "$5}'`

    if [[ $ddate == "" ]]; then
        ddate=`egrep -i -m1 "^Date:" "$i" | egrep -o -m1 "[0-9]{1,2}.*?[A-Za-z]{3}.*?[0-9]{2}.*?[0-9]{2}:[0-9]{2}" | sed 's/:/ /g' | tr -s " " | awk '{print $1"-"$2"-20"$3" "$4" "$5}'`
    fi
    
    if [[ $ddate != "" ]]; then
        echo $ddate >> ${filename}.txt
    else
        echo $i
    fi

done

# histogram
awk 'NF > 0 { count[$1] = count[$1] + 1; } END { for (word in count) print word,count[word]; }' ${filename}.txt > ${filename}_hist.txt
