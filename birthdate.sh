#!/bin/bash

read -p "Enter your birth date (yyyy.mm.dd): " birth
regex="^[0-9]{4}\\.(0[1-9]|1[0-2])\\.(0[1-9]|[12][0-9]|3[01])$"

if [[ ! $birth =~ $regex ]]; then
  echo "Invalid format. Please use yyyy.mm.dd."
  exit 1
fi

birth_date_seconds=$(date -j -f '%Y-%m-%d' "${birth//./-}" +%s 2>/dev/null)
current_date_seconds=$(date +%s)

age_seconds=$((current_date_seconds - birth_date_seconds))
age_years=$((age_seconds / (60 * 60 * 24 * 365)))

echo "You are $age_years years old."
