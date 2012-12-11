codeigniterbootstrap
====================

Set of scripts to kickstart a new CI project with my personal settings.

To run
====================

curl -s https://raw.github.com/eriktorsner/codeigniterbootstrap/master/installer.php | php

What it will do
====================
It will get the latest CodeIgniter install from Ellislab and unzip it into the current folder. After that, it will run 
each of the .mod files. Curently we have:

 * localsettings - Create a localsettings.php to make it easier to keep some server specific settings in a separate file outside of source control
 * remove_userguide - Remove the user_guide subfolder from your installation

