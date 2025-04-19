#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE teams, games")

#create list with teams
declare -a TEAMS

#read games.csv
while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]] #ignore the labels row
  then

    #populate 'TEAMS' list
    ROW_TEAMS=("$WINNER" "$OPPONENT")
    #for each of the teams ('WINNER' and 'OPPONENT') in the row
    for TEAM in "${ROW_TEAMS[@]}"
    do
      #check if 'TEAM' not in 'TEAMS'
      if [[ ! ${TEAMS[@]} =~ $TEAM ]]
      then
        #add 'TEAM' into 'TEAMS'
        TEAMS+=("$TEAM")
      fi
    done

  fi
done < games.csv

#create the string to use in PSQL for adding all teams on a single query
ROWS_TO_ADD_IN_TEAMS=''
for TEAM in "${TEAMS[@]}"
do
  ROWS_TO_ADD_IN_TEAMS+="('$TEAM'), "
done
ROWS_TO_ADD_IN_TEAMS=${ROWS_TO_ADD_IN_TEAMS::-2} #removes last ', '

#insert data into 'teams' table
INSERT_TEAMS=$($PSQL "INSERT INTO teams(name) VALUES$ROWS_TO_ADD_IN_TEAMS")
if [[ $INSERT_TEAMS == "INSERT 0 ${#TEAMS[@]}" ]]
then
  echo -e "Inserted into teams: ${#TEAMS[@]} teams\n"
fi

#create associative array wth all the teams and their respective id
declare -A TEAMS_ID
SELECT=$($PSQL "SELECT name, team_id FROM teams")

#replace ' ' with '_' in the teams names
SELECT=${SELECT// /_}

#populate the array
for line in $SELECT
do
  while IFS="|" read TEAM ID
  do
    TEAMS_ID[$TEAM]=$ID
  done <<< $line
done

#create the string to use in PSQL for adding all games on a single query
ROWS_TO_ADD_IN_GAMES=''

#read games.csv
while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]] #ignore the labels row
  then
    WINNER=${WINNER// /_}
    OPPONENT=${OPPONENT// /_}
    ROWS_TO_ADD_IN_GAMES+="($YEAR, '$ROUND', ${TEAMS_ID[$WINNER]}, ${TEAMS_ID[$OPPONENT]}, $WINNER_GOALS, $OPPONENT_GOALS), "
  fi
done < games.csv
ROWS_TO_ADD_IN_GAMES=${ROWS_TO_ADD_IN_GAMES::-2} #removes last ', '

#insert data into 'games' table
INSERT_GAMES=$($PSQL "INSERT INTO games(
  year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES$ROWS_TO_ADD_IN_GAMES")
if [[ $INSERT_GAMES == "INSERT 0 32" ]]
then
  echo -e "Inserted into games: 32 games\n"
fi
