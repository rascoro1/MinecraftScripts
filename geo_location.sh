#!/bin/bash
# Will read minecraft server log as input
# Print you the geographic location of each player logged in
# Print Duplicates
 
if [ $# -ne 1 ];then
  echo "ERROR: usage: $0 filename"
  exit 1
fi
cat $1 | grep logged | awk -F: '{print $4}' | awk '{print $1}' | sed "s/\[\//:/">mciplog
 
echo "########################################################"
cat mciplog | while read file;do
  ip=`echo $file | awk -F: '{print $2}'`
  info=`curl -s "freegeoip.net/xml/$ip" | awk '{print $1}' | grep "<" | sed "s/<//" | sed "s/>/ /" | awk -F\< '{print $1}' | sed "s/ /: /" > temp`
  sudo sed -i '1d' temp
  sudo sed -i '1d' temp
  sudo sed -i '$d' temp
  username=`echo $file | awk -F: '{print $1}'`
  echo "Username: $username"
  cat temp
  echo "#######################################################"
done
 
sudo rm mciplog
sudo rm temp
exit 0
