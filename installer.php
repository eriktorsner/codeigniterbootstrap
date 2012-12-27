<?php
/**
 * Erik Torsner CodeIgniter installer
 *
 * @author Erik Torsner <erik@torgesta.com>
 * @author Bennet Matschullat, 3mweb <bennet@giantmedia.de>
 * @date 27.12.12 - 22:39
 */


// call installer
process( $argv );


function cmd_readline( $prompt, $valid_inputs, $default = '' )
{
	while ( (!isset( $input ) || $input === '' ) || ( is_array( $valid_inputs ) && !in_array( $input, $valid_inputs ) ) )
	{
		echo $prompt;
		$input = trim( fgets( STDIN ) ) ;
		if ( empty( $input ) && !empty( $default ) )
		{
			$input = $default;
		}
	}

	return $input;
}


/**
 * processes the installer
 */
function process( $argv )
{

	// Settings
	$repo = 'eriktorsner/codeigniterbootstrap';
	$apiurl = 'https://api.github.com';
	$gitfileurl = 'https://raw.github.com';

	// Get the latest CI
	echo "Fetching latest CodeIgniter from Ellislab....\n";
	$cmd = "curl -sL http://ellislab.com/codeigniter/download > ci.zip";
	exec( $cmd );

	// Unzip it
	echo "Unzipping.\n";
	$cmd = "unzip ci.zip";
	exec( $cmd );

	// Remove archive
	echo "Cleaning up download\n";
	$cmd = "rm -rf ci.zip";
	exec( $cmd );

	// get the CI path into a var:
	$ci_folder = "";
	$cur_folder = scandir( "." );
	foreach ( $cur_folder as $file )
	{
		if ( substr( $file, 0, 13 ) == "CodeIgniter_2" )
		{
			$ci_folder = $file;
			break;
		}
	}
	echo "CodeIgniter downloaded into $ci_folder \n";

	// Get list of mods to run into an array
	$mods = array();
	$github_cmd = "$apiurl/repos/$repo/contents";

	echo "Getting list of mods $github_cmd \n\n";
	$content = get_content_from_github( $github_cmd );

	foreach ( $content as $file )
	{
		if ( $file[ 'type' ] == "file"
			&& substr( $file[ 'name' ], -4 ) == ".mod"
		)
		{
			$mod = array();
			$mod[ "name" ] = $file[ "name" ];
			$mod[ "path" ] = $file[ "path" ];

			$f = $mod[ "name" ];

			$line = (string)cmd_readline( 'install ' . $f . '[y / N]: ', array( 'y', 'N' ) );
			if ( $line == 'y' )
			{
				$mods[ ] = $mod;

				$f = $mod[ "name" ];
				echo "Downloading mod: $f\n";
				echo "$gitfileurl/$repo/master/$f" . "\n";
				$cmd = "curl -sL $gitfileurl/$repo/master/$f  > $f";
				exec( $cmd );

				// Execute the code in the mod... careful about
				// recreating function names etc....
				echo "Applying mod: $f\n";
				require_once( $f );
				unlink( $f );
			}
			else
			{
				continue;
			}

			echo "\n";

		}
	}
	echo "All mod's have executed.\n\n";
	echo "Moving content of $ci_folder into current folder....";
	$cmd = "mv $ci_folder/* .";
	exec( $cmd );
	$cmd = "rm -rf $ci_folder";
	exec( $cmd );
	echo "done.\n\n";

	echo "codeigniterbootstrap done.\n\n";


}


function get_content_from_github( $url )
{
	$ch = curl_init();
	curl_setopt( $ch, CURLOPT_URL, $url );
	curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
	curl_setopt( $ch, CURLOPT_CONNECTTIMEOUT, 1 );
	$content = curl_exec( $ch );
	curl_close( $ch );
	return json_decode( $content, true );
}




