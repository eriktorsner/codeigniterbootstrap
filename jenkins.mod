<?php
/**
* This mod adds a ant build.xml config file in the project root. Suitable
* for hooking up with a Jenkins CI server or just to use to create builds
* with ant.
* 
*/


// Get the latest CI
echo "Fetching build.xml template....\n";
$cmd = "curl -sL https://raw.github.com/eriktorsner/jenkinsforcodeigniter/master/build.xml > build.xml";
exec($cmd);

$cmd = "mv build.xml $ci_folder/";
exec($cmd);

