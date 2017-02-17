# bnr
bnr is a shell script tool to create and restore backups of dotfiles based off a config file.

## Getting Started
* There are many dotfiles management softwares out there. This is just another. The following describes what the tool is about and what it does.  
  
* The bnr script is customizable and reads config information from a [config file](https://github.com/wrvenkat/bnr-conf) to restore or create backup. Backups and restore are handled by copying their dotfiles. bnr can also run additional scripts to backup or restore. For example, to restore configuration information for a software that uses dconf, merely copying the user file will copy the entire dconf database and not the one particular for the software.  
  
  The bnr script processes each line entry in the config file and,  

	1. Restores a backup by copying files from the dotfiles directory to their destination as specified in the config file. (or) run the corresponding script.
	2. Creates a backup for each entry by copying files from their source destination to the dotfiles directory. (or) run the corresponding script.  

* The bnr script can also mirror the source directory structure when creating the backup.
* The bnr script can also take an optional install log file which is a file that is generated as part of running the install script of the [ibnr](https://github.com/wrvenkat/ibnr) tool. If this is specified, the bnr script will only process those entries for which the [actual program name](https://github.com/wrvenkat/ibnr-conf#format) value matches as that of the second column value of the [bnr-conf]() file. It can be regarded as the first column in bnr-conf having a "forerign key" relationship with the second column in the ibnr_conf file.  

* Any line whose program name has `$def$` as the first name in a value that is of the format `$def$-val` is processed regardless of whether an entry is present in the install log file or not.

* The script logs entries for which the source file was not found in either a backup or restore into failed_bnr_list.conf file. Successful entries are logged into the successful_bnr_list.conf file.

* An error.log is created inside the bnr directory that has the output from all operations.

Please see [bnr-conf](https://github.com/wrvenkat/bnr-conf) for more information on the config file.

## Usage

`usage: ./bnr <options>`  

`options`  
`-h | --help`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- display this message and quit.`  
`--installlog=<install-log-file-path>`&nbsp;`- the path to a ibnr-conf type file to be used for determining the programs to be processed`  
`--all`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- process all entries in the configfile. When provided, the install log file is ignored.`  
`--configfile=<config-file-path>`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- the config file path for this script. By default, the script looks for the file bnr_list.conf`  
`--list`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- display the contents of the install log file and config file.`  
`--restore`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- restore the dotfiles by copying it to the destination.`  
`--backup`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- create a backup by copying the dotfiles from the source.`  
`--backupdir=<backup-directory-path>`&nbsp;&nbsp;&nbsp;`- when provided, the directory that will be used as source directory to restore backups from and as destination directory to create backups to.`  
`--mirror`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- when specified during a backup, mirrors the directory structure of the source dotfile.`

#### Example ####
You can get the [bootstrap] (link) script that does the following.  
  1. Get a stable copy of the project and move to the folder:  
  `git clone https://github.com/wrvenkat/bnr.git && cd bnr`  
  2. Get a stable copy of the config file or you can use your own version:  
  `git clone https://github.com/wrvenkat/bnr-conf.git`  
  3. Get a stable copy of the config_scripts for your Ubuntu version:  
  `git clone https://github.com/wrvenkat/config_scripts.git && cd config_scripts && git checkout <your-ubuntu-version> && cd ..`  
   Example: `git clone https://github.com/wrvenkat/config_scripts.git && cd config_scripts && git checkout 16.04`  
  4. Get the stable version of [bash helper scripts](https://github.com/wrvenkat/bash_helper_scripts.git):  
  `git clone https://github.com/wrvenkat/bash_helper_scripts.git`  
  5. Run the tool,
	 1. To restore backup for all entries,  
	 `./bnr --list --all --restore`  
	 2. To restore backup for entries in a ibnr-conf type file,  
	 `./bnr --list --restore --installlog=successfull_ppa_list.conf`  
	 3. To restore backup from the provided directory instead of the default one,  
	 `./bnr --all --list --restore --backupdir=~/dotfiles\ backup/`  
	 4. To restore a mirrored backup from the provided directory,  
	 `./bnr --all --list --restore --mirror --backupdir=~/dotfiles\ backup/`  
	 5. To create a backup mirroring the dotfiles' source path inside the default backup directory,  
	 `./bnr --all --list --backup --mirror`  
	 6. To create a backup inside the provided backup directory,  
	 `./bnr --list --backup --backupdir=~/dotfiles/`  
	 
## Contributing

Any type of contribution is welcome! :) The master branch holds the latest stable. The dev branch holds the latest unstable code. The test branch is a submodule to the dev branch and holds the test scripts.  
For contributions to bnr-conf and config_scripts, please see [bnr-conf](https://github.com/wrvenkat/bnr-conf.git) and [config_scrtips](https://github.com/wrvenkat/config_scripts.git).

## LICENSE

[GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)
