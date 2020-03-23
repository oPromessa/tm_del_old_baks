#!/bin/bash

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Config the name of your MAC machine
machine=$(scutil --get ComputerName)

# Config the Time Machine server name
server=katuiti

# Initialize our own variables:
output_file=""
verbose=""
dryrun=""
force_run="-p"
tempfile=tm_del_old_baks.$$.txt

function show_help () {
	echo "$0: Usage: sudo $0 [ -h | -? ] -v -r -f -M <hostname>"
	echo "$0: Deletes TimeMachine backups leaving last backup of each month. Except from last and current month which are not touched."
	echo "$0: -v: Verbose: show (partial) list of files to be deleted."
	echo "$0: -r: Dry run: echo commands but do not execute"
	echo "$0: -f: Force execution of delete backups without asking"
	echo "$0: -M <hostname>: Your hostname"
	echo "$0: by oPromessa, 2020"
}

while getopts "h?vrfM:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    v)  verbose="1"
        ;;
    r)  dryrun="echo"
        ;;
    f)  force_run=""
        ;;
    M)  machine=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift

echo "dryrun=$dryrun, verbose=$verbose, force_run=$force_run, machine=$machine Leftovers: $@"

# No leftovers option is possible
if [ ! -z "$@" ]
then
	show_help
	exit 0
fi

tmutil listbackups > $tempfile

if [ "$verbose" == "1" ]
then
	echo ----------------
	head $tempfile
	echo ----------------
	mount
	echo ----------------
fi
if [ ! -z "$force_run" ]
then
	echo $0: ready to go [n]/y?
	read x
	if [ "$x" == "y" ]
	then
		echo $0: Continuing...
	else
		echo $0: Aborting...
		rm -f  $tempfile
		exit 1
	fi
fi

# use xargs -p to confirm each TM delete operation
# get every month form the list of backups except last and current month (possibly being current month)
cut -d\/ -f 6 $tempfile | cut -c1-7 | uniq | sed '$d' | sed '$d' | while read month; do echo ---------- Month: $month ; grep "$month" $tempfile | sort -rn | tail +2 | sort -n | xargs $force_run -Ifile $dryrun tmutil delete file ; echo ----------; done

echo $0: Make sure Time Machine Folder is VISIBLE in Finder but not mounted!
echo $0: Eject Folder Time Machine Backups in FINDER if required
echo $0: ready to go for hdutil COMPACT [n]/y?
read x
if [ "$x" == "y" ]
then
	echo $0: Executing HDUTIL. Connecting to ${server}. You will be asked to input the user and password.
	# http://sysadminnotebook.blogspot.com/2014/07/reclaim-free-space-from-time-machine.html
	$dryrun mkdir -p /Volumes/TM
	$dryrun mount_afp -i 'afp://${server}/Time Machine Folder' /Volumes/TM && $dryrun hdiutil compact /Volumes/TM/"${machine}.sparsebundle"
	$dryrun umount /Volumes/TM/
else
	echo $0: Not executing HDUTIL.
fi

rm -f  $tempfile
