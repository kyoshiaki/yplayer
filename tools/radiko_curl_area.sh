#!/bin/sh

jp=1

while [ "$jp" -le 47 ]
do
 area="JP$jp"
 name="$area.xml"

 echo "curl -o $name http://radiko.jp/v2/station/list/$area.xml"
 curl -o $name http://radiko.jp/v2/station/list/$area.xml

# echo "curl -o $name http://radiko.jp/v2/api/program/today?area_id=$area"
# curl -o $name http://radiko.jp/v2/api/program/today?area_id=$area

 jp=$(($jp+1))
done

exit 0