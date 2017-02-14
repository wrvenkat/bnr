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
`--installlog=<install-log-file-path>`&nbsp;`- optionally provide the path to a ibn-conf type file to be used for determining the programs for which the configuration needs to be restored or backed up. By default, the script looks for the file successful_ppa_list.conf`  
`--all`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- process all entries in the configfile. If this is the case, the install log file is ignored.`  
`--configfile=<config-file-path>`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- optionally provide the config file path for this script. By default, the script looks for the file bnr_list.conf`  
`--list`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- display the contents of the install log file and config file.`  
`--restore`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- restore the dotfiles and configuration for programs found in the config file (either the default file or the one provided to --configfile).by copying it to the directory of the source file.`  
`--backup`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- create a backup by copying the dotfiles and running the script for the entries found in the config file (either the default file or the one provided to --configfile) from their destination to the dotfiles directory.`  
`--backupdir=<backup-directory-path>`&nbsp;&nbsp;&nbsp;`- when provided, the directory that will be used as source directory to restore backups from and as destination directory to create backups to.`  
`--mirror`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- this option when specified during a backup, mirrors the directory structure of the source dotfile.`

#### Example ####

  1. Get a stable copy of the project:  
  `git clone --recursive https://github.com/wrvenkat/bnr.git && git checkout stable`
  2. Navigate to bnr-conf directory and get the config file for your Ubuntu version:  
  `cd ibnr-conf; git checkout <your_ubuntu_version>`  
  Example: `cd ibnr-conf; git checkout 16.04`
  3. Navigate to config_scripts directory and get the config scripts for your Ubuntu version:  
  `cd config_scripts; git checkout <your_ubuntu_version>`  
  Example: `cd config_scripts; git checkout 16.04`
  4. Navigate back to the project dir and run the tool to list the config file, add the PPAs and install the software:  
  To restore backup for all entries,  
  `cd ..; ./bnr --list --all --restore`  
  To restore backup for entries in a ibnr-conf type file,  
  `cd ..; ./bnr --list --restore --installlog=../successfull_ppa_list.conf`  
  To restore backup from the provided directory instead of the default one,  
  `cd ..; ./bnr --list --restore --backupdir=~/dotfiles/`  
  To create a backup mirroring the dotfiles' source path inside the default config files directory,  
  `./bnr --list --backup --mirror`  
  To create a backup inside the provided config files directory,  
  `./bnr --list --backup --backupdir=~/dotfiles/`  

## Contributing

Contributions are welcome. Please see the README.md for the submodules for information on contributing.

## LICENSE

[GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)
