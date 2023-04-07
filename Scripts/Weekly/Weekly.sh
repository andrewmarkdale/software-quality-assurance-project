# Sorry for the mess Jude

# Array of weekdays to iterate over
declare -a days=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday")
# Initial Monday transaction is done outside of the loop as it's easier
# this way
cd Monday/Transactions

# Going through every input file in the transaction folder and feeding it
# into the frontend

for FILE in *.inp; do #echo "Frontend: $FILE";
  ../../../../FrontEnd/./main currentaccounts.txt ${FILE%.*}.atf < $FILE > ${FILE%.*}.out
  # Cleaning up the folder
  rm ${FILE%.*}.out
done
# Merging all transaction files into one merged transaction file
for FILE in *.atf; do #echo "Concatenating $FILE";
  awk 1 ${FILE} >> ../transactions.atf
  # Cleaning up the folder by removing loose transaction files
  rm ${FILE}
done
# Putting the contents of the merged transactions file into a new file
# makes it easier to keep running scripts.
awk 1 ../transactions.atf > ../transactions.txt
rm ../transactions.atf

# I wasn't sure of a better way to run the backend then to manually find it
# and run it using the appropriate files.

# NOTE: We feed the currentaccounts into the backend just so it knows where to find
# it for the project.
cd ../../../../BackEnd/src 
java com/backend/Main ../../Scripts/Weekly/Monday/masteraccounts.txt ../../Scripts/Weekly/Monday/currentaccounts.txt ../../Scripts/Weekly/Monday/transactions.txt

# Going back to our original directory
cd ../../Scripts/Weekly

# Iterating through the aforementioned list to pass as directories
for ((i = 0; i < ${#days[*]}; ++i))
  do
  # Skipping Monday in the list to apply the transactions, but still needed in list
  # to grab the old master and current files.
  if [[ "$i" != "0" ]] 
  then
    # Changing into the appropriate directory.
    cd ${days[i]}
    cd Transactions
    echo "Performing Transactions for: ${days[i]}";
    # From here out is basically the same as above, puts inputs into the frontend and uses the
    # merged transactions file and puts it into the backend.
    for FILE in *.inp; do #echo "Frontend: $FILE";
      ../../../../FrontEnd/./main ../../${days[i-1]}/currentaccounts.txt ${FILE%.*}.atf < $FILE > ${FILE%.*}.out
      rm ${FILE%.*}.out
    done
    for FILE in *.atf; do #echo "Concatenating $FILE";
      awk 1 ${FILE} >> ../transactions.atf
      rm ${FILE}
    done
    awk 1 ../transactions.atf > ../transactions.txt
    rm ../transactions.atf
    cd ../../../../BackEnd/src 
    java com/backend/Main ../../Scripts/Weekly/${days[i-1]}/masteraccounts.txt ../../Scripts/Weekly/${days[i-1]}/currentaccounts.txt ../../Scripts/Weekly/${days[i]}/transactions.txt
    awk 1 ../../Scripts/Weekly/${days[i-1]}/masteraccounts.txt > ../../Scripts/Weekly/${days[i]}/masteraccounts.txt
    awk 1 ../../Scripts/Weekly/${days[i-1]}/currentaccounts.txt > ../../Scripts/Weekly/${days[i]}/currentaccounts.txt 
  fi
  # Going back to the appropriate directory.
  cd ../../Scripts/Weekly
done
