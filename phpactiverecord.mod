<?php
/**
* This mod adds phpactiverecord to CI
* 
*/

// Get the latest phpactiverecord 
echo "Fetching latest phpactiverecord from github.com/toopay/gas-orm....\n";
$cmd = "git clone git://github.com/eriktorsner/php-activerecord.git";
exec($cmd);

echo "Moving into application/third_party ..\n";
$cmd = "mv php-activerecord $ci_folder/application/third_party/";

echo "Enable hooks in application/config/config.php\n";
$target_file = "$ci_folder/application/config/config.php";
$config_file = file_get_contents($target_file);
$needle = "\$config['enable_hooks'] = FALSE;";
$newneedle = "\$config['enable_hooks'] = TRUE;";
$config_file = str_replace($needle, $newneedle, $config_file);
file_put_contents($target_file, $config_file);

echo "Add hook in application/config/hooks.php\n";
$hook_code = <<<EOD

\$hook['pre_controller'][] = array(
    'class'    => '',
    'function' => 'initialize_php_activerecord',
    'filename' => 'CI_ActiveRecord.php',
    'filepath' => 'third_party/php-activerecord'                                
);
EOD;
$target_file = "$ci_folder/application/config/hooks.php";
$config_file = file_get_contents($target_file);
$rows = split("\n", $config_file);
$inserted = array($hook_code);
array_splice($rows, 11, 0, $inserted);
$config_file = join("\n", $rows);
file_put_contents($target_file, $config_file);

echo "Cleaning up....\n";
$cmd = "rm -rf php-activerecord";
exec($cmd);




