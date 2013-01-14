#!/bin/bash


if [ $# -ne 1 ]; then
        echo Usage: $(basename $0) city
        exit 1
fi

DZEN_OPTS="-p -l 6 -sa c -fn -*-*-*-*-*-*-14-*-*-*-*-*-iso8859-* \
-x 156 -y 1 -tw 26 -w 300 -bg #252525 \
-e onstart=collapse;entertitle=uncollapse;leavetitle=collapse"
#-e onstart=collapse;button1=uncollapse;button4=uncollapse;button5=collapse;button3=exit" 

IFS=$'\n' # changing the ifs variable to make it accept the spaces in
			# the array
GWEATHER=( 'Sunny' 'Clear' 'Mostly Sunny' 'Partly Sunny' \
'Chance of Rain' 'Mostly Cloudy' 'Cloudy' 'Foggy' 'Rain' \
'Showers' 'Snow' )
unset IFS

ICONDIR="$HOME/.icons/weather/"
CITY=$1
FILE=`mktemp`
links -dump "http://www.google.com/search?hl=en&q=${CITY}+weather" > $FILE

# the "Weather for $CITY" string
TITLE=`grep "^Weather" $FILE`
# the temperature
TEMP=`grep "^[0-9][0-9]*°C" $FILE`
# the wind
WIND=`grep "^Wind" $FILE | awk '{print $2,$3,$4,$5}'`
# the humidity
HUM=`grep "^Humidity" $FILE | awk '{print $2}'`
# the current state
STATE=`grep "^Current" $FILE | awk -F: '{print $2}'`
# tomorrow's state
STATE_TOMORROW=`grep -A 3 "^Humidity" $FILE | sed -n "3 p" | sed 's/^[ \t]*//;s/[ \t]*$//' `
# tomorrow's temperatures
TEMP_TOMORROW=`grep -A 3 "^Humidity" $FILE | sed -n "4 p" | sed 's/^[ \t]*//;s/[ \t]*$//'`

ICONSTATE="$ICONDIR/${STATE}.xpm"
ICONTOMORROW="$ICONDIR/${STATE_TOMORROW}.xpm"


(
echo "^i(${ICONSTATE})"
echo "^fg(#ffffff) $TITLE"
echo "$TEMP $STATE"
echo "$WIND $HUM hum"
echo "^fg(#ffffff)Tomorrow"
echo "$STATE_TOMORROW"
echo "$TEMP_TOMORROW"
) | dzen2 $DZEN_OPTS

