<?php
/**
* This mod will just remove the user_guide folder from 
* the root.
*
* 
*/

$cmd = "rm -rf $ci_folder/user_guide";
exec($cmd);


