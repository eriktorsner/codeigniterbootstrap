<?php
/**
* This mod adds the layout library Twig to CI
* 
*/

// Get the latest CI
echo "Fetching latest Twig from github.com/eriktorsner....\n";
$cmd = "git clone git@github.com:eriktorsner/Twig-Codeigniter.git";
exec($cmd);

// get the submodule
echo "Fetching Twig as a submodule.\n";
chdir("Twig-Codeigniter");
$cmd = "git submodule init";
echo exec($cmd);
$cmd = "git submodule update";
exec($cmd);
chdir("..");

echo "Moving into project folders....\n";
$cmd = "mv Twig-Codeigniter/application/config/twig.php $ci_folder/application/config/";
exec($cmd);
$cmd = "mv Twig-Codeigniter/application/libraries/Twig.php $ci_folder/application/libraries/";
exec($cmd);
$cmd = "mv Twig-Codeigniter/application/third_party/Twig $ci_folder/application/third_party/";
exec($cmd);



