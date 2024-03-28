#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

insert_teams() {
    cat teams.csv | while IFS="," read -r name; do
        $PSQL "INSERT INTO teams (name) VALUES ('$name')"
    done
}

# Function to insert games data
insert_games() {
    cat games.csv | tail -n +2 | while IFS="," read -r year round winner opponent winner_goals opponent_goals; do
        winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
        opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
        $PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($year, '$round', $winner_id, $opponent_id, $winner_goals, $opponent_goals)"
    done
}

# Insert data
insert_teams
insert_games