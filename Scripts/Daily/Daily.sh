# Daily Script

# For the daily we decided to just show the creation of some accounts
# which is then updated in the accounts files -- this will help with the
# weekly script. 

# Changes directory for the transaction inputs
cd Transactions
# Each of the input files are fed into the frontend 
for FILE in *.inp; do echo "Running $FILE";
  ../../../FrontEnd/./main ../currentaccounts.txt ${FILE%.*}.atf < $FILE > ${FILE%.*}.out
  # Removing loose files
  rm ${FILE%.*}.out
done
# Concatenating the transaction files
for FILE in *.atf; do echo "Concatenating $FILE";
  awk 1 ${FILE} >> ../transactions.atf
  rm ${FILE}
done
# Putting the contents of the merged file into a new file
awk 1 ../transactions.atf > ../transactions.txt
# Removing first file
rm ../transactions.atf
cd ../../../BackEnd/src
# Feeding the appropriate files into the backend 
java com/backend/Main ../../Scripts/Daily/masteraccounts.txt ../../Scripts/Daily/currentaccounts.txt ../../Scripts/Daily/transactions.txt