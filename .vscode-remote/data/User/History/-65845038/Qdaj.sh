#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

insert_teams() {
   cat /path/to/your/files/teams.csv | while IFS="," read -r name; do

        $PSQL "INSERT INTO teams (name) VALUES ('$name')"
    done
}

# Function to insert games data
insert_games() {
    while IFS="," read -r year round winner opponent winner_goals opponent_goals; do
        echo "Year: $year, Round: $round, Winner: $winner, Opponent: $opponent, Winner Goals: $winner_goals, Opponent Goals: $opponent_goals"
        winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
        opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
        echo "Winner ID: $winner_id, Opponent ID: $opponent_id"
        $PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($year, '$round', $winner_id, $opponent_id, $winner_goals, $opponent_goals)"
    done < games.csv
}

# Insert games data

insert_teams
insert_games