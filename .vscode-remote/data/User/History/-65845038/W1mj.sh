#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.


# Insert teams data
cat teams.csv | while IFS="," read -r name; do
    $PSQL "INSERT INTO teams (name) VALUES ('$name')"
done

# Count the total number of rows in the teams table
