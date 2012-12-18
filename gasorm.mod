<?php
/**
* This mod adds Gas-ORM 2 to CI
* 
*/

// Get the latest gas
echo "Fetching latest gas from github.com/toopay/gas-orm....\n";
$cmd = "git clone git://github.com/toopay/gas-orm.git";
exec($cmd);


echo "Moving into project folders....\n";
$cmd = "mv gas-orm/config/gas.php $ci_folder/application/config/";
exec($cmd);
$cmd = "mv gas-orm/libraries/gas $ci_folder/application/libraries/";
exec($cmd);
$cmd = "mv gas-orm/libraries/gas.php $ci_folder/application/libraries/";
exec($cmd);
$cmd = "mv gas-orm/third_party/gas $ci_folder/application/third_party/";
exec($cmd);

echo "Cleaning up....\n";
$cmd = "rm -rf gas-orm";
exec($cmd);




