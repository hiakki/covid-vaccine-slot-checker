#!/bin/bash

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]
then
  echo "Usage: $0 <DISTRICT ID> <MIN AGE> <DATE>"
  echo "Date Format - DD-MM-YYYY"
  echo "For District IDs, open district_ids.md"
  echo "Example: $0 664 18 04-05-2021"
  exit
fi
district_ids=$1
min_age=$2
t_date_raw=$3
i=1
j=0
k=0

t_date=$t_date_raw

for district_id in ${district_ids[@]}
do
  url="https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=${district_id}&date=${t_date}"
  centers=`curl -s $url | jq '.centers'`
  i=$((i+1))

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

      if [ "$min_age" = "$min_age_limit" ]
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

  echo "$j out of $k Centers are available for District - $district_name"

done
