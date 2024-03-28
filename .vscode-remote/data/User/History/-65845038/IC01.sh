#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
TEAMS_CSV="/path/to/teams.csv"

# Connect to the worldcup database
PSQL="psql -X --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Function to insert unique teams into the teams table
insert_unique_teams() {
    while IFS="," read -r name; do
        # Check if the team already exists in the teams table
        existing_team=$($PSQL "SELECT EXISTS(SELECT 1 FROM teams WHERE name='$name')")
        if [[ $existing_team == "f" ]]; then
            # Insert the team into the teams table if it does not exist
            $PSQL "INSERT INTO teams (name) VALUES ('$name')"
        fi
    done < "$TEAMS_CSV"
}

# Insert unique teams into the teams table
insert_unique_teams

# Count the total number of rows in the teams table
total_teams=$($PSQL "SELECT COUNT(*) FROM teams")
echo "Total teams inserted: $total_teams"