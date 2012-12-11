<?php
/**
* This mod will introduce the application/config/localsettings.php
* file. It's where we keep all config that is related to a specific
* server (test/development/sandbox) etc.
*
* 
*/

$localsettings = <<<EOD
<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/*
|--------------------------------------------------------------------------
| NOT INTENDED FOR VERSION HANDLING THIS FILE MAY NOT
| BE IMPORTED TO SUBVERSION or GIT
|
| local settings
|--------------------------------------------------------------------------
|
| This file exists in order to override certain settings 
| to values that only applies for the local server. This means
| that the standard configuration files that are part of the 
| framwork can be kept clean from stuff like passwords, url for
| local access etc.
|
*/


define('CONST_CONFIG_BASE_URL',  	"http://localhost/myproject");

// Database
define('CONST_DB_DEFAULT_HOSTNAME', "localhost");
define('CONST_DB_DEFAULT_USERNAME', "user");
define('CONST_DB_DEFAULT_PASSWORD', "pass");
define('CONST_DB_DEFAULT_DATABASE', "database");*/


/* End of file localsettings.php */
/* Location: ./application/config/localsettings.php */
EOD;



// 1. Create the localsettings.php file in application config
$target_file = "$ci_folder/application/config/localsettings.php.sample";
file_put_contents($target_file, $localsettings);

// 2. Modify config/config.php to include localsettings.php
// and point some config to it:
$target_file = "$ci_folder/application/config/config.php";
$config_file = file_get_contents($target_file);
$rows = split("\n", $config_file);
$inserted = array("require_once localsettings.php");
array_splice($rows, 2, 0, $inserted);
$config_file = join("\n", $rows);

$config_file = str_replace("config['base_url']	= '';", 
	"config['base_url']	= CONST_CONFIG_BASE_URL;", $config_file);	
// Write the file back to disk.
file_put_contents($target_file, $config_file);


// 2. Modify config/database.php to include this file:
$target_file = "$ci_folder/application/config/database.php";
$config_file = file_get_contents($target_file);
$rows = split("\n", $config_file);
$inserted = array("require_once localsettings.php\n\n");
array_splice($rows, 1, 0, $inserted);
$config_file = join("\n", $rows);

$config_file = str_replace(
	"db['default']['hostname'] = 'localhost';",  
	"db['default']['hostname'] = CONST_DB_DEFAULT_HOSTNAME;", $config_file);
$config_file = str_replace(
	"db['default']['username'] = '';",  
	"db['default']['username'] = CONST_DB_DEFAULT_USERNAME;", $config_file);
$config_file = str_replace(
	"db['default']['password'] = '';",  
	"db['default']['password'] = CONST_DB_DEFAULT_PASSWORD;", $config_file);
$config_file = str_replace(
	"db['default']['database'] = '';",  
	"db['default']['database'] = CONST_DB_DEFAULT_DATABASE;", $config_file);
// Write the file back to disk.
file_put_contents($target_file, $config_file);


