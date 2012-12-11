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
	//$help       = in_array('--help', $argv);
	/**
	* 1. Get the archive from Ellis
	* 2. Unzip it
	* 3. Go in and add the 'localsettings' hack
	* 4. Download the CI
	*
	*/
  $cmd = 'curl -sL http://ellislab.com/codeigniter/download > ci.zip';
	exec $cmd;


}