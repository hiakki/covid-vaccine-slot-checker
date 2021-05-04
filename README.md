# cowin-vaccine-slot-checker
This is a Shell script which will help you to know when a slot is available on Cowin website.

## Features:
1. Find any open slots and print it in the terminal and optionally write to a file
2. (Optional) Run the script as a cron job (Linux/MacOS) which will periodically check for the slots.

## Steps to run:
1. Clone the repository
2. Usage: ```slot_checker.sh <DISTRICT ID> <MIN AGE> <DATE> <O/P to file: Y/y/N/n>```
3. Date Format - DD-MM-YYYY
4. For District IDs, open [district_ids.md](https://github.com/hiakki/covid_helper/blob/master/district_lists.md)
Example: 
```slot_checker.sh 664 18 04-05-2021 Y```
```slot_checker.sh 663 45 05-06-2021 y```
```slot_checker.sh 664 18 04-05-2021 n```
```slot_checker.sh 663 45 05-06-2021 N```

## Reference:
https://github.com/faizulhai24/cowin-vaccine-slot-checker
