#!/bin/bash
echo "start" >> ~/stst.txt
term=$(pgrep -f "st -n __scratchpad")
echo ">$term<"
echo "start $term" >> ~/stst.txt
if [[ "$term" == "" ]];then
  echo "start new one"
  echo "start new one" >> ~/stst.txt
  /usr/local/bin/st -n __scratchpad &
  echo "start new one done" >> ~/stst.txt
  sleep 0.5
fi
echo " call i3 " >> ~/stst.txt
i3-msg [instance="__scratchpad"] scratchpad show, resize set 1300 850, move position center
echo " call i3 done " >> ~/stst.txt
