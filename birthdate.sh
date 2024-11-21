#!/bin/bash

read -p "Enter your birth date (yyyy.mm.dd): " birth

# This regex filters the input value. In this case, the value has to be in yyyy.mm.dd format and day and month limits have been set, meaning user can't
# enter 13th month
regex="^[0-9]{4}\\.(0[1-9]|1[0-2])\\.(0[1-9]|[12][0-9]|3[01])$"

# If date is not equal to regex string, then it returns an error and stops the program
if [[ ! $birth =~ $regex ]]; then
  echo "Invalid format. Please use yyyy.mm.dd."
  exit 1
fi

# Here, I am converting input date value to the seconds using `date` function.
# Note: I faced a problem here. I run this program on the BSD server that the university gave 
# and for linux systems, `-j -f` might not work, instead try `-d`. And `+s%` is the main command that converts 
# date to the seconds. Btw, before converting the date, we have to format it with '%Y-%m-%d'
birth_date_seconds=$(date -j -f '%Y-%m-%d' "${birth//./-}" +%s 2>/dev/null)

# This is converting current date to seconds, which is needed to calculate the age later on
current_date_seconds=$(date +%s)

# This is subtracting the birth date seconds from current date seconds
age_seconds=$((current_date_seconds - birth_date_seconds))

# This is converting age seconds to the years by dividing the seconds by 31536000 which is a year
age_years=$((age_seconds / (60 * 60 * 24 * 365)))

echo "You are $age_years years old."
