#!/bin/bash

TODAY=$(date +%Y%m%d)
DIR="/home/ycn/mysql-bak"

FILE=$(find $DIR -name "*$TODAY*gz")

if [ -e "$FILE" ]; 
then

  echo $FILE
  /bin/gzip -d -f $FILE

else
  echo "No gz-compressed file found !"
fi

SQL=$(find $DIR -name "*$TODAY*sql")
echo $SQL

# echo " continue?"
# read a

# Importing database.
/usr/bin/mysql -uroot -piSA3ksV-EiN1 ngocn_news < $SQL

if [ $? == 0 ]; then
	echo "Done!"
else
	echo "Something wrong!"
	exit
fi

# Change the domain in fab_settings.
/usr/bin/mysql -uroot -piSA3ksV-EiN1 << EOF
USE ngocn_news;
UPDATE fab_settings SET value="www.ngocn.ovh" WHERE id=1;
UPDATE fab_settings SET value="http://www.ngocn.ovh" WHERE id=11;
EOF

if [ $? == 0 ]; then
	echo "Done!"
else
	echo "Something wrong!"
	exit
fi

# echo "Updating the url field in table fab_post..."

/usr/bin/mysql -uroot -piSA3ksV-EiN1 << EOF
USE ngocn_news;
UPDATE fab_post SET url=REPLACE(url, 'cn.net', 'cn.ovh');
EOF


# Deleting old ones.
/usr/bin/find $DIR -mtime +2 -exec rm -f {} \;

exit
