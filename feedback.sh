#!/bin/sh
# Export data from MySQL database back to ipcc-facts-checking
# to perform comparisons for Quality Assurance
#
# USAGE:
# feedback.sh [user] [host] [password]
# with
#   user - optional, string, database user name, defaults to 'root'
#   host - optional, string, database host name, defaults to 'localhost'
#   password - optional, string, database user password,
#              defaults to 'no password' which provides no password;
#              an empty string results in a prompt for password.
user=${1:-'root'}
host=${2:-'localhost'}
password=${3:-'no password'}

if [ "$password" = 'no password' ]
then
  passwordParam=''
else
  passwordParam="--password $password"
fi

database=giec
query="mysql --host $host --user $user $passwordParam"

# change to the script's directory
cd $(dirname $0)

# change to feedback directory
cd feedback

feedback()
{
  dataset=$(dirname $1)
  echo "Export ipcc-fact-checking/$dataset/back.csv"
  $query $database < $1 \
  | ../tsv2csv.sh > "../ipcc-fact-checking/$dataset/back.csv"
}

for script in */*/*/back.sql
do
  feedback "$script"
done

# clean-up
$query $database << EOF
DROP VIEW feedback_chapter;
EOF
