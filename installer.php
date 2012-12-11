<?php
/**
 * Erik Torsner CodeIgniter installer
 *
 * (c) Erik Torsner <erik@torgesta.com>
 *
 */

process($argv);

/**
 * processes the installer
 */
function process($argv)
{

	// Settings
	$repo 		= 'eriktorsner/codeigniterbootstrap';
	$apiurl 	= 'https://api.github.com';
	$gitfileurl 	= 'https://raw.github.com';

	// Get the latest CI
	echo "Fetching latest CodeIgniter from Ellislab....\n";
	$cmd = "curl -sL http://ellislab.com/codeigniter/download > ci.zip";
	exec($cmd);

	// Unzip it
	echo "Unzipping.\n";
	$cmd = "unzip ci.zip";
	exec($cmd);

	// Remove archive
	echo "Cleaning up download\n";
	$cmd = "rm -rf ci.zip";
	exec($cmd);

	// get the CI path into a var:
	$ci_folder = "";
	$cur_folder = scandir(".");
	foreach($cur_folder as $file) 
	{
		if(substr($file, 0, 13) == "CodeIgniter_2") 
		{
			$ci_folder = $file;
			break;
		}
	}
	echo "CodeIgniter downloaded into $ci_folder \n";

	// Get list of mods to run into an array
	$mods = array();
	$github_cmd = "$apiurl/repos/$repo/contents";
	echo "Getting list of mods $github_cmd \n";
	$content = get_content_from_github($github_cmd);
	foreach($content as $file)
	{
		if($file['type'] == "file" 
			&& substr($file['name'],-4) == ".mod")
		{
			$mod = array();	
			$mod["name"] = $file["name"];
			$mod["path"] = $file["path"];
			$mods[] = $mod;

			$f = $mod["name"];
			echo "Downloading mod: $f\n";
			$cmd = "curl -sL $gitfileurl/$repo/master/$f  > $f";
			exec($cmd);
			
			// Execute the code in the mod... careful about 
			// recreating function names etc....
			echo "Applying mod: $f\n";
			require_once($f);
			unlink($f);
			echo "\n";

		}
	}
	echo "All mod's have executed. Done!\n\n";
}


function get_content_from_github($url) {
	$ch = curl_init();
	curl_setopt($ch,CURLOPT_URL,$url);
	curl_setopt($ch,CURLOPT_RETURNTRANSFER,1); 
	curl_setopt($ch,CURLOPT_CONNECTTIMEOUT,1);
	$content = curl_exec($ch);
	curl_close($ch);
	return json_decode($content, true);
}




