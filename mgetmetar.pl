#! /usr/bin/env sh

getids() {
  printf '%s' "$QUERY_STRING" | sed -e 's/^cccc=//; s/^.*\(....\)$/\1/'
}

IDS="`getids`"
GET_URI="https://www.aviationweather.gov/adds/dataserver_current/httpparam?dataSource=metars&requestType=retrieve&format=xml&hoursBeforeNow=3&mostRecent=true&fields=raw_text&stationString=$IDS"
GET_URI="https://aviationweather.gov/metar/data?ids=$IDS"
GET_URI="https://aviationweather.gov/api/data/dataserver?dataSource=metars&requestType=retrieve&format=xml&hoursBeforeNow=3&mostRecent=true&fields=raw_text&stationString=$IDS"

if [[ "$REMOTE_ADDR" != ::1 && "$REMOTE_ADDR" != 127.0.0.1 ]] ;then
  echo "Location: $GET_URI"
  echo
else
  echo "Content-Type: text/html"
  echo
  USER_AGENT='mgetmetar-gateway/2023-11-09 (https://github.com/bruncsak/mgetmetar)'
  curl -s -A "$USER_AGENT" "$GET_URI" |
  sed -e 's/\r$// ; s/<raw_text>/<raw_text>\n/ ; s/<code>/<code>\n/'
  echo '<-- Magic cookie: National Weather Service -->'
fi
