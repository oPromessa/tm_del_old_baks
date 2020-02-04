#!/bin/bash

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Config the name of your MAC machine
machine=Donald

# Initialize our own variables:
output_file=""
verbose=""
dryrun=""
force_run="-p"

function show_help () {
	echo "$0: Usage: sudo $0 [ -h | -? ] -v -r -f -M <machine_name>"
	echo "$0: Deletes TimeMachine backups leaving last backup of each month. Except from last and current month which are not touched."

	echo "$0: -v: Verbose: show (partial) list of files to be deleted."
	echo "$0: -r: Dry run: echo commands but do not execute"
	echo "$0: -f: Force execution of delete backups without asking"
	echo "$0: by oPromessa, 2020
}

while getopts "h?vrf" opt; do
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
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift

echo "dryrun=$dryrun, verbose=$verbose, force_run=$force_run, Leftovers: $@"

# No leftovers option is possible
if [ ! -z "$@" ]
then
	show_help
	exit 0
fi

tmutil listbackups > listbackups2del.txt

if [ "$verbose" == "1" ]
then
	echo ----------------
	head listbackups2del.txt
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
		exit
	fi
fi

# use xargs -p to confirm each TM delete operation
# get every month form the list of backups except last and current month (possibly being current month)
cut -d\/ -f 6 listbackups2del.txt | cut -c1-7 | uniq | sed '$d' | sed '$d' | while read month; do echo ---------- Month: $month ; grep "$month" listbackups2del.txt | sort -rn | tail +2 | sort -n | xargs $force_run -Ifile $dryrun tmutil delete file ; echo ----------; done

echo $0: Make sure Time Machine Folder is VISIBLE in Finder but not mounted!
echo $0: Eject Folder Time Machine Backups in FINDER if required
echo $0: ready to go for hdutil COMPACT [n]/y?
read x
if [ "$x" == "y" ]
then
	echo $0: Executing HDUTIL.
	$dryrun hdiutil compact /Volumes/Time\ Machine\ Folder/"${Donald}.sparsebundle"
else
	echo $0: Not executing HDUTIL.
fi

