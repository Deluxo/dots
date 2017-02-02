#! /bin/zsh

curl -s 'http://www.arturka.lt/api/all' \
| jq -r ".[$(shuf -i 0-384 -n 1)].text" \
| sed 's/[\., \,] /.\n/g'
