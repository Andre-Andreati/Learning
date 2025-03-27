#!/bin/bash
# Script to insert data from galaxies.csv, stars.csv, planets.csv, moons.csv and species.csv into universe database
# universe db is composed of 7 tables: galaxy, star, planet, moon, species, species_planets and species_moons
# the last two links the species with the planets and moons where they are found

PSQL="psql -X --username=freecodecamp --dbname=universe --no-align --tuples-only -c"
echo $($PSQL "TRUNCATE galaxy, star, planet, moon, species, species_planets, species_moons")

#populate galaxy table
cat galaxies.csv | while IFS="," read NAME SIZE SHAPE AGE
do
  if [[ $NAME != name ]]
  then
    #get galaxy_id
    GALAXY_ID=$($PSQL "SELECT galaxy_id FROM galaxy WHERE name='$NAME'")

    #if not found
    if [[ -z $GALAXY_ID ]]
    then
      #insert galaxy
      INSERT_GALAXY_RESULT=$($PSQL "INSERT INTO galaxy(name, size_in_meters, shape, age) VALUES('$NAME', $SIZE, '$SHAPE', $AGE)")
      if [[ $INSERT_GALAXY_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into galaxy, $NAME
      fi
    fi
  fi
done

#populate star table
cat stars.csv | while IFS="," read NAME GALAXY TYPE COLOR MASS
do
  if [[ $NAME != name ]]
  then
    #get star_id
    STAR_ID=$($PSQL "SELECT star_id FROM star WHERE name='$NAME'")

    #if not found
    if [[ -z $STAR_ID ]]
    then
      #get galaxy_id
      GALAXY_ID=$($PSQL "SELECT galaxy_id FROM galaxy WHERE name='$GALAXY'")
      #insert star
      INSERT_STAR_RESULT=$($PSQL "INSERT INTO star(name, type, color, mass, galaxy_id) VALUES('$NAME', '$TYPE', '$COLOR', $MASS, $GALAXY_ID)")
      if [[ $INSERT_STAR_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into star, $NAME
      fi
    fi
  fi
done

#populate planet table
cat planets.csv | while IFS="," read NAME STAR TYPE ECOSSYSTEM INHABITABLE_INT YEAR_DURATION DAY_DURATION
do
  if [[ $NAME != name ]]
  then
    #get planet_id
    PLANET_ID=$($PSQL "SELECT planet_id FROM planet WHERE name='$NAME'")

    #if not found
    if [[ -z $PLANET_ID ]]
    then
      #convert INHABITABLE int to bool
      if [[ $INHABITABLE_INT = 1 ]]
      then
        INHABITABLE_BOOL=True
      else
        INHABITABLE_BOOL=False
      fi
      #get star_id
      STAR_ID=$($PSQL "SELECT star_id FROM star WHERE name='$STAR'")
      #insert planet
      INSERT_PLANET_RESULT=$($PSQL "INSERT INTO planet(
        name, type, ecossystem, inhabitable, year_duration, day_duration, star_id) VALUES(
        '$NAME', '$TYPE', '$ECOSSYSTEM', $INHABITABLE_BOOL, $YEAR_DURATION, $DAY_DURATION, $STAR_ID)")
      if [[ $INSERT_PLANET_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into planet, $NAME
      fi
    fi
  fi
done

#populate moon table
cat moons.csv | while IFS="," read NAME PLANET INHABITABLE_INT ECOSSYSTEM SIZE
do
  if [[ $NAME != name ]]
  then
    #get moon_id
    MOON_ID=$($PSQL "SELECT moon_id FROM moon WHERE name='$NAME'")

    #if not found
    if [[ -z $MOON_ID ]]
    then
      #convert INHABITABLE int to bool
      if [[ $INHABITABLE_INT = 1 ]]
      then
        INHABITABLE_BOOL=True
      else
        INHABITABLE_BOOL=False
      fi

      #get planet_id
      PLANET_ID=$($PSQL "SELECT planet_id FROM planet WHERE name='$PLANET'")

      #insert moon
      INSERT_MOON_RESULT=$($PSQL "INSERT INTO moon(
        name, size, ecossystem, inhabitable, planet_id) VALUES(
        '$NAME', $SIZE, '$ECOSSYSTEM', $INHABITABLE_BOOL, $PLANET_ID)")
      if [[ $INSERT_MOON_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into moon, $NAME
      fi
    fi
  fi
done

#populate species, species_planets and species_moons tables
cat species.csv | while IFS="," read NAME SENTIENT_INT FOUND_ON HEIGHT WEIGHT
do
  if [[ $NAME != name ]]
  then
    #get specie_id
    SPECIES_ID=$($PSQL "SELECT species_id FROM species WHERE name='$NAME'")

    #if not found
    if [[ -z $SPECIES_ID ]]
    then
      #convert SENTIENT int to bool
      if [[ $SENTIENT_INT = 1 ]]
      then
        SENTIENT_BOOL=True
      else
        SENTIENT_BOOL=False
      fi

      #insert species
      INSERT_SPECIES_RESULT=$($PSQL "INSERT INTO species(
        name, height, weight, sentient) VALUES(
        '$NAME', $HEIGHT, $WEIGHT, $SENTIENT_BOOL)")
      if [[ $INSERT_SPECIES_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into species, $NAME
      fi

    #get specie_id
    SPECIES_ID=$($PSQL "SELECT species_id FROM species WHERE name='$NAME'")

    #for each planet/moon on FOUND_ON
    for PLACE in $FOUND_ON
    do
      #try to find the 'PLACE' on 'planet'
      PLANET_ID=$($PSQL "SELECT planet_id FROM planet WHERE name='$PLACE'")

      #if 'PLACE' found on 'planet'
      if [[ $PLANET_ID ]]
      then
        #insert on species_planets
        INSERT_RESULT=$($PSQL "INSERT INTO species_planets(
          species_id, planet_id) VALUES(
          $SPECIES_ID, $PLANET_ID)")
        if [[ $INSERT_RESULT == "INSERT 0 1" ]]
        then
          echo Inserted into species_planets, $NAME $PLACE
        fi
      
      #if 'PLACE' not found on 'planet'
      else
        #try to find the 'PLACE' on 'moon'
        MOON_ID=$($PSQL "SELECT moon_id FROM moon WHERE name='$PLACE'")

        #if 'PLACE' found on 'moon'
        if [[ $MOON_ID ]]
        then
          #insert on species_moons
          INSERT_RESULT=$($PSQL "INSERT INTO species_moons(
            species_id, moon_id) VALUES(
            $SPECIES_ID, $MOON_ID)")
          if [[ $INSERT_RESULT == "INSERT 0 1" ]]
          then
            echo Inserted into species_moons, $NAME $PLACE
          fi
        fi
      fi
    done
    fi
  fi
done