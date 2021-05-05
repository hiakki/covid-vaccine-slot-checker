# cowin-vaccine-slot-checker
This is a Shell script which will help you to know when a slot is available on Cowin website.

## Features:
1. Find any open slots and print it in the terminal and optionally write to a file
2. (Optional) Run the script as a cron job (Linux/MacOS) which will periodically check for the slots.

## Prerequisites:
1. Make sure ```jq``` is present in your machine.
<br />MacOS - ```brew install jq```
<br />Note: For mac, if installation fails, try these commands -
<br />```ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null```
<br />```brew install jq```

<br />CentOS - ```sudo yum install jq -y```
<br />Ubuntu - ```sudo apt install jq -y```

## Steps to run:
1. Clone the repository
2. Usage: ```slot_checker.sh <DISTRICT ID> <MIN AGE> <DATE> <O/P to file: Y/y/N/n>```
3. Date Format - DD-MM-YYYY
4. For District IDs, open [district_ids.md](https://github.com/hiakki/covid_helper/blob/master/district_lists.md)
<br />Example: 
<br />```slot_checker.sh 664 18 04-05-2021 Y```
<br />```slot_checker.sh 663 45 05-06-2021 y```
<br />```slot_checker.sh 664 18 04-05-2021 n```
<br />```slot_checker.sh 663 45 05-06-2021 N```

<br />File will be saved with following naming convention - ```<district_id>-<min_age>-<custom_date>.log```
<br />Example: ```664-45-05-05-2021.log```

<br />Output Sample -

```
          Center ID:      611574
          Name:           CVC 1 UHM HOSPITAL CV
          Address:        MALL ROAD
          District:       Kanpur Nagar
          State:          Uttar Pradesh
          Block:          KPM
          Pin Code:       208001
          Fees:           Free
          Available:      137
          Min Age Limit:  45
          Vaccine Name:   COVISHIELD
          Date:           05-05-2021
          Time:           [
                              "10:00AM-12:00PM",
                              "12:00PM-02:00PM",
                              "02:00PM-04:00PM",
                              "04:00PM-05:00PM"
                          ]


          Center ID:      660774
          Name:           CVC 1 Armapur Hospital CV
          Address:        Armapur
          District:       Kanpur Nagar
          State:          Uttar Pradesh
          Block:          Geeta Nagar
          Pin Code:       208002
          Fees:           Free
          Available:      37
          Min Age Limit:  45
          Vaccine Name:   COVISHIELD
          Date:           05-05-2021
          Time:           [
                              "09:00AM-11:00AM",
                              "11:00AM-01:00PM",
                              "01:00PM-03:00PM",
                              "03:00PM-05:00PM"
                          ]


          Center ID:      626325
          Name:           CVC 1 PHC HATHIPUR CV
          Address:        HATHIPUR
          District:       Kanpur Nagar
          State:          Uttar Pradesh
          Block:          Sarsaul
          Pin Code:       209402
          Fees:           Free
          Available:      57
          Min Age Limit:  45
          Vaccine Name:   COVISHIELD
          Date:           05-05-2021
          Time:           [
                              "09:00AM-11:00AM",
                              "11:00AM-01:00PM",
                              "01:00PM-03:00PM",
                              "03:00PM-05:00PM"
                          ]
```

## Reference:
https://github.com/faizulhai24/cowin-vaccine-slot-checker
