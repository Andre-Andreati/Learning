#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

READ_GUESS() {
  read GUESS
  while ! [[ "$GUESS" =~ ^-?[0-9]+$ ]]; do
    echo -e "That is not an integer, guess again:"
    read GUESS
  done
}

echo -e "Enter your username:"
read USERNAME

#get user from db
USER=$($PSQL "SELECT * FROM users WHERE name='$USERNAME'") #$USER = '1|John|5|30'

#if user not found
if [[ -z $USER ]]; then
  #add user to db
  ADD_USER_RESULT=$($PSQL "INSERT INTO users(name, num_games, best_game) VALUES('$USERNAME', 0, 0)")
  #print first time message
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."
else
  USER=(${USER//|/ }) #transforms USER into an array [1, 'John', 5, 30]

  NUM_GAMES=${USER[2]}
  BEST_GAME=${USER[3]}

  echo -e "Welcome back, $USERNAME! You have played $NUM_GAMES games, and your best game took $BEST_GAME guesses."
fi

echo -e "Guess the secret number between 1 and 1000:"
READ_GUESS

#generates random number between 1 and 1000
NUMBER=$(( ( RANDOM % 1000 ) + 1 ))
TRIES=1

#while guess is wrong
while [[ $GUESS -ne $NUMBER ]]; do
  TRIES=$((TRIES + 1))
  if [[ $GUESS -gt $NUMBER ]]; then
    echo -e "It's lower than that, guess again:"
  else
    echo -e "It's higher than that, guess again:"
  fi
  READ_GUESS
done

#when guess is right

#add the game to db
ADD_GAME_RESULT=$($PSQL "UPDATE users \
                          SET num_games = num_games + 1,\
                              best_game = 
                                CASE WHEN best_game = 0
                                  THEN $TRIES
                                  ELSE LEAST(best_game, $TRIES)
                                END
                          WHERE name='$USERNAME'")

#print final message
echo -e "You guessed it in $TRIES tries. The secret number was $NUMBER. Nice job!"
