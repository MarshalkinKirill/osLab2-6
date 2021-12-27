#!/bin/bash
> firstReport.txt
> firstMem.txt
> firstSwap.txt

while true; do
checking=$(top -b -n 1 | grep "mem.bash")
status=$(echo $checking | awk '{if ($8 == "R") print $0}')

if [[ -n "$checking" && -n "$status" ]]; then
curDate=$(date +'%X')
echo "Date: $curDate" >> firstReport.txt
echo "Info about memory:" >> firstReport.txt
data=$(top -b -n 1 | head -n 5 | tail -n 2)
echo $data >> firstReport.txt  #get the 4-th and 5-th strings in top
echo "$data" | head -n 1 | awk '{print $6}' >> firstMem.txt
echo "$data" | tail -n 1 | awk '{print $5}' >> firstSwap.txt
echo "Ingo about process mem.bash" >> firstReport.txt
echo "$checking" >> firstReport.txt
echo "Leader processes" >> firstReport.txt
top -b -n 1 | head -n 12 | tail -n 5 >> firstReport.txt
echo -e "\n" >> firstReport.txt
else
exit
fi
sleep 1
done
