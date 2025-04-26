#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#if no argument is provided
if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
  exit
fi

INPUT=$1

if [[ $INPUT =~ ^[0-9]+$ ]]; then
  #get element's 'atomic_number', 'symbol' and 'name' from 'elements' table using 'atomic_number'
  ELEM=$($PSQL "SELECT * FROM elements WHERE atomic_number=$INPUT") #ELEM='1|H|Hidrogen'

#if input have up to 2 chars
elif [[ ${#INPUT} -le 2 ]]; then
  #get element's 'atomic_number', 'symbol' and 'name' from 'elements' table using 'symbol'
  ELEM=$($PSQL "SELECT * FROM elements WHERE symbol='$INPUT'") #ELEM='1|H|Hidrogen'

#if input is not a number and have more than 2 chars
else
  #get element's 'atomic_number', 'symbol' and 'name' from 'elements' table using 'name'
  ELEM=$($PSQL "SELECT * FROM elements WHERE name='$INPUT'") #ELEM='1|H|Hidrogen'
fi

#if not find
if [[ -z $ELEM ]]; then
  #print 'not find' message and end program
  echo "I could not find that element in the database."
  exit
fi

ELEM=(${ELEM//|/ }) #transforms ELEM into an array [1, 'H', 'Hidrogen']
    
ATOMIC=${ELEM[0]}
SYMBOL=${ELEM[1]}
NAME=${ELEM[2]}

#get properties from 'properties' table using 'atomic_number'
PROPERTIES=$($PSQL "SELECT * \
                    FROM properties \
                    JOIN types \
                    ON properties.type_id = types.type_id \
                    WHERE atomic_number=$ATOMIC") #ELEM='1|1.008|-259.1|-252.9|1|1|nonmetal'
PROPERTIES=(${PROPERTIES//|/ }) #transforms PROPERTIES into an array

MASS=${PROPERTIES[1]}
MELTING=${PROPERTIES[2]}
BOILING=${PROPERTIES[3]}
TYPE=${PROPERTIES[6]}

#print the answer message
echo -e "The element with atomic number $ATOMIC is $NAME \
($SYMBOL). It's a $TYPE, with a mass of $MASS amu. \
$NAME has a melting point of $MELTING celsius and a \
boiling point of $BOILING celsius."
