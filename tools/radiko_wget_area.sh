#!/bin/sh

jp=1

while [ "$jp" -le 47 ]
do
 area="JP$jp"
 name="$area.xml"

 echo "wget -O $name http://radiko.jp/v2/station/list/$area.xml"
 wget -O $name http://radiko.jp/v2/station/list/$area.xml

# echo "wget -O $name http://radiko.jp/v2/api/program/today?area_id=$area"
# wget -O $name http://radiko.jp/v2/api/program/today?area_id=$area

 jp=$(($jp+1))
done

exit 0