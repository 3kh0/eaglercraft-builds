#!/bin/sh
echo ""
echo "Eaglercraft 1.5.2 LAN World Relay"
echo "Note: Requires java 8 or newer!"
while true
	do
		echo ""
		java -jar EaglerSPRelay.jar --debug
		echo ""
		echo "press [CTRL+C] to cancel restart"
	sleep 5
done
