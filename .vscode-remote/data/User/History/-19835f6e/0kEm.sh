
#! /bin/bash
# create variable PSQL to allow us to query database
PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Investigating the data 
# to run script: ./insert_data.sh

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"