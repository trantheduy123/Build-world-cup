#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
insert_teams() {
    # Loop through each team in the teams.csv file
    while IFS="," read -r name; do
        # Check if the team already exists in the teams table
        team_exists=$($PSQL "SELECT EXISTS(SELECT 1 FROM teams WHERE name='$name')")
        
        # If the team does not exist, insert it into the teams table
        if [[ $team_exists == "f" ]]; then
            $PSQL "INSERT INTO teams (name) VALUES ('$name')"
        fi
    done < teams.csv
}

# Insert unique teams into the teams table
insert_teams

# Verify total rows in the teams table
total_teams=$($PSQL "SELECT COUNT(*) FROM teams")
echo "Total teams inserted: $total_teams"