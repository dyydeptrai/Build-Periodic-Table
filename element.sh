
INPUT=$1
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ ! $INPUT =~ ^[1-9]+$ ]]
  then
    #if input <=2
    LENGTH=$(echo -n "$INPUT" | wc -m)
    if [[ $LENGTH -gt 2 ]]
    then
      #get data by full name
      DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$INPUT'")
      if [[ -z $DATA ]]
      then 
        echo "I could not find that element in the database."
      else
        echo "$DATA" | while IFS="|" read TYPE_ID NUMBER SYMBOL NAME WEIGHT MELTING BOILING TYPE
        do
          echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
        done
      fi
    else
      #get data by symbol
      DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$INPUT'")
      if [[ -z $DATA ]]
      then 
        echo "I could not find that element in the database."

      else
        echo "$DATA" | while IFS="|" read TYPE_ID NUMBER SYMBOL NAME WEIGHT MELTING BOILING TYPE
        do
          echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
        done
      fi
    fi 
  else
    #get data by number
    DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$INPUT")

    if [[ -z $DATA ]]
    then 
      echo "I could not find that element in the database."

    else
      echo "$DATA" | while IFS="|" read TYPE_ID NUMBER SYMBOL NAME WEIGHT MELTING BOILING TYPE
      do
        echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  fi
fi







