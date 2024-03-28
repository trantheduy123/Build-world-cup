#!/bin/bash

# Connect to the worldcup database
PSQL="psql -X --username=your_username --dbname=worldcup --no-align --tuples-only -c"

# Insert teams data
cat teams.csv | while IFS="," read -r name; do
    $PSQL "INSERT INTO teams (name) VALUES ('$name')"
done

# Insert games data
cat games.csv | tail -n +2 | while IFS="," read -r year round winner opponent winner_goals opponent_goals; do
    winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
    opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
    $PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($year, '$round', $winner_id, $opponent_id, $winner_goals, $opponent_goals)"
done
