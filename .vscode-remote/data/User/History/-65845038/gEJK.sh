#!/bin/bash

create_database() {
    local database_name="worldcup"
    local psql_command="psql --username=postgres --dbname=postgres --no-align --tuples-only -c"
    local database_exists=$($psql_command "SELECT 1 FROM pg_database WHERE datname='$database_name'")

    if [[ -z $database_exists ]]; then
        $psql_command "CREATE DATABASE $database_name"
    fi
}

if [[ $1 == "test" ]]; then
    PSQL="psql --username=postgres --dbname=worldcuptest --no-align --tuples-only -c"
else
    PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"
fi

insert_teams() {
    cat teams.csv | while IFS="," read -r name; do
        $PSQL "INSERT INTO teams (name) VALUES ('$name')"
    done
}

insert_games() {
    while IFS="," read -r year round winner opponent winner_goals opponent_goals; do
        winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
        opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
        $PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($year, '$round', $winner_id, $opponent_id, $winner_goals, $opponent_goals)"
    done < games.csv
}

# Create worldcup database if it doesn't exist
create_database

# Insert teams data
insert_teams

# Insert games data
insert_games
