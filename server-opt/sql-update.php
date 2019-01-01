<?php
$dbhost = 'localhost:3306';
$dbuser = 'root';
$dbpass = 'iSA3ksV-EiN1';
$conn = mysql_connect($dbhost, $dbuser, $dbpass);

$FileNew = '/var/lib/mysql-files/domain-new.txt';

if ( ! $conn ) {
  die('Could not connect: ' . mysql_error());
}

// Enter the database I want.

mysql_select_db('ngocn_news');


// Change domain in fab_settings table.

// Export domains from old table (fab_post).

// substitute with new domains.

// Import the new ones into the url column in the same table.

$DomainNew = file( $FileNew );
                 # $Count = exec("wc -l $FileNew | awk '{ print $1 }'");

     # var_dump( $DomainNew );

foreach ( $DomainNew as $Num => $Link ) {
  if ($Num < 1) continue;
  $sql = "UPDATE fab_post
        SET url='$Link'
        WHERE id=$Num";

  $retval = mysql_query( $sql, $conn );

  if(! $retval )
  {
    die('Could not update data: ' . mysql_error());
  }
}

# mysql_affected_rows( $retval );

echo "Updated data successfully\n";
mysql_close($conn);
?>
