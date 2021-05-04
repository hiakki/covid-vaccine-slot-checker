#!/bin/bash

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] || [ -z $4 ]
then
  echo "Usage: $0 <DISTRICT ID> <MIN AGE> <DATE> <O/P to file: Y/y/N/n>"
  echo "Date Format - DD-MM-YYYY"
  echo "For District IDs, open district_ids.md"
  echo -e "Example: 
            $0 664 18 04-05-2021 Y
            $0 663 45 05-06-2021 y
            $0 664 18 04-05-2021 n
            $0 663 45 05-06-2021 N
          "
  exit
fi
district_id=$1
min_age=$2
custom_date=$3
j=0
k=0
file_name="${district_id}-${min_age}-${custom_date}.log"

slot_checker() {
  url="https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=${district_id}&date=${custom_date}"
  centers=`curl -s $url | jq '.centers'`

  while [ true ]
  do
    n=".[$k]"
    center=`echo $centers | jq $n`
    if [ "$center" = 'null' ]
    then
      break
    else
      center_id=`echo $center | jq -r '.center_id'`
      name=`echo $center | jq -r '.name'`
      address=`echo $center | jq -r '.address'`
      district_name=`echo $center | jq -r '.district_name'`
      state_name=`echo $center | jq -r '.state_name'`
      block_name=`echo $center | jq -r '.block_name'`
      pincode=`echo $center | jq -r '.pincode'`
      fee_type=`echo $center | jq -r '.fee_type'`
      available_capacity=`echo $center | jq -r '.sessions[0].available_capacity'`
      min_age_limit=`echo $center | jq -r '.sessions[0].min_age_limit'`
      vaccine_name=`echo $center | jq -r '.sessions[0].vaccine'`
      availability_date=`echo $center | jq -r '.sessions[0].date'`
      time_slots=`echo $center | jq -r '.sessions[0].slots' | sed 's/ /               /g' | sed 's/]/                          ]/g'`

      if [ "$min_age" = "$min_age_limit" ] && [ "$available_capacity" != 0 ]
      then
        echo -e "
          Center ID:      $center_id
          Name:           $name
          Address:        $address
          District:       $district_name
          State:          $state_name
          Block:          $block_name
          Pin Code:       $pincode
          Fees:           $fee_type
          Available:      $available_capacity
          Min Age Limit:  $min_age_limit
          Vaccine Name:   $vaccine_name
          Date:           $availability_date
          Time:           $time_slots
        "
        j=$((j+1))
      fi

      k=$((k+1))
    fi
  done

  if [ -z "$district_name" ]
  then
    echo "No Centers are available for District ID - $district_id for the Date - $custom_date"
  else
    echo "$j out of $k Centers are available for District - $district_name"
  fi
}

if [ "$4" = 'n' ] || [ "$4" = 'N' ]
then
  slot_checker
elif [ "$4" = 'y' ] || [ "$4" = 'Y' ]
then
  slot_checker > $file_name
  echo "Result is saved to - $file_name"
fi