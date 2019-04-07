# List of accounts to read the last tweet from, comma separated
# The first in the list is read by the party parrot.
export TTC_BOTS='tinycarebot,selfcare_bot,magicrealismbot'
export TTC_SAY_BOX='cat'
export TTC_REPOS='/home/lukas/Documents/dev/react-native/kilo.network-app,/home/lukas/Documents/dev/docker/alws'
export TTC_REPOS_DEPTH=2
export TTC_WEATHER='Vilnius'
export TTC_CELSIUS=true
export TTC_APIKEYS=false
export TTC_UPDATE_INTERVAL=20
export TTC_TERMINAL_TITLE=false
export TTC_CONSUMER_KEY='...'
export TTC_CONSUMER_SECRET='...'
export TTC_ACCESS_TOKEN='...'
export TTC_ACCESS_TOKEN_SECRET='...'

# Note: in tiny-terminal-care < 1.0.7, the recommended variables for the Twitter
# API keys were the ones before. As of 1.0.8, they are deprecated
# (because the names are too generic), but will still be supported
# until the next major version.
export CONSUMER_KEY='...'
export CONSUMER_SECRET='...'
export ACCESS_TOKEN='...'
export ACCESS_TOKEN_SECRET='...'

# Default pomodoro is 20 minutes and default break is 5 minutes.
# You can change these defaults like this.
export TTC_POMODORO=25
export TTC_BREAK=10
