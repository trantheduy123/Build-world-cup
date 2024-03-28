#!/bin/bash

# Connect to the worldcup database
PSQL="psql -X --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Query 1
echo "SELECT COUNT(*) FROM teams;"
$PSQL "SELECT COUNT(*) FROM teams;"

# Query 2
echo "SELECT AVG(winner_goals), AVG(opponent_goals) FROM games;"
$PSQL "SELECT AVG(winner_goals), AVG(opponent_goals) FROM games;"

# Query 3
echo "SELECT name FROM teams WHERE team_id IN (SELECT winner_id FROM games GROUP BY winner_id HAVING COUNT(*) > 1);"
$PSQL "SELECT name FROM teams WHERE team_id IN (SELECT winner_id FROM games GROUP BY winner_id HAVING COUNT(*) > 1);"

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"