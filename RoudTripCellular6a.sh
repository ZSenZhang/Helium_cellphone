index="FirstRound"
WEBHOOK_URL="https://hooks.slack.com/services/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"

if [ ! -d "$1" ]; then
	mkdir $1
fi

timestamp=`date -u +"%Y-%m-%d_%H-%M-%S"`
timemin=`date +"%M"`
# echo $timemin

cellid=`dumpsys telephony.registry | grep notifyServiceStateForSubscriber | sed -n '$p' | sed 's/\&//g'`
battpct=`dumpsys battery | grep level | cut -c 10-`" percent"
temp=$((`dumpsys battery | grep temp | cut -c 15-`/10))
OUTPUT="Pixel 6a NYC generated a UDP Packet.\n Timestamp: $timestamp\n Battery: $battpct.\n Temp: $temp C.\n Accelerator: $4 . \n CellInfo: $cellid.\n"
mLac=`echo $cellid | sed 's/.*m*ac=\([0-9]*\).*/\1/'`
mCid=`echo $cellid | sed 's/.*mCi*=\([0-9]*\).*/\1/'`
mMcc=`echo $cellid | sed 's/.*mMcc=\([0-9]*\).*/\1/'`
mMnc=`echo $cellid | sed 's/.*mMnc=\([0-9]*\).*/\1/'`
/data/local/tmp/UDPclient_input.o $mLac $mCid $mMcc $mMnc $2 $3 >> $1/${index}.log
echo $OUTPUT >> $1/${index}.log
if [ $timemin -eq 10 ]
then
	timeout 15 /data/local/tmp/curl --cacert /data/local/tmp/cacert.pem -X POST -H 'Content-type: application/json' --data '{"text":"'"$OUTPUT"'"}' "$WEBHOOK_URL"
fi
