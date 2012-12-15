<?php
/**
* This mod adds twitter bootstrap
* 
*/

// Get the latest CI
echo "Fetching latest bootstrap from github.com....\n";
$cmd = "curl -sL http://twitter.github.com/bootstrap/assets/bootstrap.zip > bootstrap.zip";
exec($cmd);

// unzip it
echo "Unzipping...\n";
$cmd = "unzip bootstrap.zip";
exec($cmd);

// move files and folders into the CI install
echo "Moving bootstrap files into CodeIgniter folder\n";
$cmd = "cp -r bootstrap/css $ci_folder";
exec($cmd);
$cmd = "cp -r bootstrap/img $ci_folder";
exec($cmd);
$cmd = "cp -r bootstrap/js $ci_folder";
exec($cmd);

echo "Cleaning up\n";
$cmd = "rm -rf bootstrap";
exec($cmd);
$cmd = "rm -rf bootstrap.zip";
exec($cmd);



