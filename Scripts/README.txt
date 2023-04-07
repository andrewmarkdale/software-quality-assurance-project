DAILY

The frontend and the backend have already been compiled for ease of use. (Since they're all over the place). 

To run the daily script merely go into the appropriate directly and run ./Daily.sh

If there happens to be an error (there shouldn't be) just run chmod +x Daily.sh and then run ./Daily.sh once again. 


WEEKLY

Similar to above, everything is already compiled just run the script and it will loop through the days of transactions and applying each. For weekly use the command ./Weekly.sh

NOTE: I can't for the life of me find the bug that sometimes causes a transaction to not be added onto the total transaction count, not sure why that's happening. 

If I happen to forget to delete the contents of one of the files, the error is expected as it's trying to create accounts that already exist.

The scripts are capitalized so use ./Daily.sh and ./Weekly.sh

Ryan Guenther 100702069
Andrew Dale 100491442
John Hruda 100698231
Sara Bhatti 100473397
