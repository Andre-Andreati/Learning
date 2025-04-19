#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "~~~~~ Salon ~~~~~"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  else
    echo -e "\nWelcome to the best salon in the world!\n"
  fi

  echo -e "What service would you like?\n"

  #get available services
  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")

  #print available services
  echo "$SERVICES" | while read ID BAR NAME
  do
    echo "$ID) $NAME"
  done

  #read desired service
  read SERVICE_ID_SELECTED
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")

  #if service is not valid
  if [[ -z $SERVICE_NAME ]]
  then
    #send to main menu
    MAIN_MENU "Please select a valid service number."
  
  #if service is valid
  else

    #ask phone number
    echo -e "\nEnter your phone number.\n"
    read CUSTOMER_PHONE

    #query for customer with phone in customers table
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

    #if phone number not in customers table
    if [[ -z $CUSTOMER_NAME ]]
    then
      #ask customer name
      echo -e "\nWhat's your name?"
      read CUSTOMER_NAME

      #add customer to customers table
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
    fi

    #get customer_id
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

    #ask desired service hour
    echo -e "\nWhat time would you like your $(echo "$SERVICE_NAME" | xargs), $(echo "$CUSTOMER_NAME" | xargs)?\n"
    read SERVICE_TIME

    #add appointment to appointments table
    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
    echo -e "\nI have put you down for a $(echo "$SERVICE_NAME" | xargs) at $(echo "$SERVICE_TIME" | xargs), $(echo "$CUSTOMER_NAME" | xargs)."
    exit
  fi
}

MAIN_MENU
exit