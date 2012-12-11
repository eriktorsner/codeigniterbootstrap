<?php
/**
* This mod adds a CIUinit/PHPUnit base install to the CI installation
* 
*/

// Get the latest CI
echo "Fetching latest CIUnit from github.com/eriktorsner/ciunit....\n";
$cmd = "curl -sL https://github.com/eriktorsner/ciunit/archive/master.zip > ciunit.zip";
exec($cmd);

// unzip it
echo "Unzipping...\n";
$cmd = "unzip ciunit.zip";
exec($cmd);

// move files and folders into the CI install
$cmd = "mv ciunit-master/application/config/testing/ $ci_folder/application/config/";
exec($cmd);
$cmd = "mv ciunit-master/application/third_party/CIUnit/ $ci_folder/application/third_party/";
exec($cmd);
$cmd = "mv ciunit-master/tests/ $ci_folder/";
exec($cmd);
$cmd = "rm -rf ciunit-master/";
exec($cmd);

// Remove archive
echo "Cleaning up download\n";
$cmd = "rm -rf ci.zip";
exec($cmd);
