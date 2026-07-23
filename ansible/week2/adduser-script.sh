#!/bin/bash

# Check that user list and password list were passed as args
if [[ -n $1 ]] && [[ -n $2 ]]
then

  UserList=($1)
  Password=($2)

  # Create each user
  for (( i=0; i < ${#UserList[@]}; i++ ))
  do
    if [[ $(grep -c "^${UserList[$i]}:" /etc/passwd) == 0 ]]
    then
      useradd "${UserList[$i]}"
      # Ubuntu uses chpasswd (passwd --stdin is RHEL-only)
      echo "${UserList[$i]}:${Password[$i]}" | chpasswd
      echo "created user ${UserList[$i]}"
    else
      echo "this user ${UserList[$i]} is existing."
    fi
  done

else
  echo -e 'Please input user id and password.\nUsage: adduser-script.sh "user01 user02" "pw01 pw02"'
fi
