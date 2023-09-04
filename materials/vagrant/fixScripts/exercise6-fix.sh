#!/bin/bash
#add fix to exercise6-fix here

# Check for the minimum number of arguments
if [ "$#" -lt 3 ]; then
    echo "Usage: $0 file1 file2 ... destination_folder"
    exit 1
fi

# Get the last argument as the destination folder
destination_folder="${!#}"
HOSTNAME=`hostname`
USR=`whoami`
# Iterate over all arguments except the last one
for ((i = 1; i < $#; i++)); do
    file="${!i}"
    # Check if the file exists
    if [ ! -f "$file" ]; then
        echo "File not found: $file"
        exit 1
    fi
    # Check host
    if [ "$HOSTNAME" == "server1" ]; then
      if [ "$USR" == "root" ]; then
         scp -o "StrictHostKeyChecking=no" -i /home/vagrant/.ssh/id_rsa $file vagrant@server2:$destination_folder 2>/dev/null
       else
         # Copy the file to the destination folder
        scp -o "StrictHostKeyChecking=no" $file vagrant@server2:$destination_folder  2>/dev/null
      fi
    else
      if [ "$USR" == "root" ]; then
         scp -o "StrictHostKeyChecking=no" -i /home/vagrant/.ssh/id_rsa $file vagrant@server1:$destination_folder 2>/dev/null
       else
         # Copy the file to the destination folder
        scp -o "StrictHostKeyChecking=no" $file vagrant@server1:$destination_folder 2>/dev/null
      fi
    fi

    if [ "$?" -ne 0 ]; then
        echo "Failed to copy $file to $destination_folder"
        exit 1
    fi
done

# Calculate and print the total number of bytes copied
total_bytes_copied=0
for ((i = 1; i < $#; i++)); do
    file="${!i}"
    file_size=$(stat -c %s "$file")
    total_bytes_copied=$((total_bytes_copied + file_size))
done

echo "$total_bytes_copied"
