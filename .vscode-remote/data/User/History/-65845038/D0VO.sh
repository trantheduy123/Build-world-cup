#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Insert teams data
cat teams.csv | while IFS="," read -r name; do
    $PSQL "INSERT INTO teams (name) VALUES ('$name')"
done