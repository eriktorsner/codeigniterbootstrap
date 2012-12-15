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
$cmd = "cp -r boostrap/css $ci_folder/";
exec($cmd);
$cmd = "cp -r boostrap/img $ci_folder/";
exec($cmd);
$cmd = "cp -r boostrap/js $ci_folder/";
exec($cmd);


