# tm_del_old_baks
-----------------
by oPromessa, 2020, V0.0.1
* Published on [https://github.com/oPromessa/tm_del_old_baks/](https://github.com/oPromessa/tm_del_old_baks/)

## Description
MAC OS shell utility to delete old Time Machine backups. Keeps one monthly copy. Also compacts the backup location to free up space.

## Features
* Provides you some more fine/tunning control over Time Machine handling of old backups.
* MAC OS shell utility to delete old Time Machine backups. Keeps one monthly copy. Also compacts the backup location to free up space.

THIS SCRIPT IS PROVIDED WITH NO WARRANTY WHATSOEVER.
PLEASE REVIEW THE SOURCE CODE TO MAKE SURE IT WILL WORK FOR YOUR NEEDS.
IF YOU FIND A BUG, PLEASE REPORT IT.

## Requirements
* MAC
* bash
* Must be run as _root_ with `sudo` to have permission to run `tmutil` (Time Machine Command/line utility) commmand.

## Setup on MAC
* Place file on a folder an run with "sudo ..."
```bash
$ sudo tm_del_old_baks.sh
```

## Configuration
* Edit variable machin ewithin file.
```bash
machine=YOURMACHINE
```

## Usage/Arguments/Options
Place the file uploadr.py in any directory and run via ssh (execution privs required).
```bash
tm_del_old_baks.sh: Usage: sudo tm_del_old_baks.sh [ -h | -? ] -v -r -f -M <opt>
tm_del_old_baks.sh: Deletes TimeMachine backups leaving last backup of each month. Except from last and current month which are not touched.
tm_del_old_baks.sh: -v: Verbose: show (partial) list of files to be deleted.
tm_del_old_baks.sh: -r: Dry run: echo commands but do not execute
tm_del_old_baks.sh: -f: Force execution of delete backups without asking
```
### Example
```
18:04:11 Documents[937]> sudo  ./deletebackups.sh -vf
Password:
dryrun=, verbose=1, force_run=, Leftovers:
----------------
/Volumes/Time Machine Backups/Backups.backupdb/YOURMACHINE/2019-09-28-211904
/Volumes/Time Machine Backups/Backups.backupdb/YOURMACHINE/2019-10-26-034833
/Volumes/Time Machine Backups/Backups.backupdb/YOURMACHINE/2019-11-09-034834
/Volumes/Time Machine Backups/Backups.backupdb/YOURMACHINE/2019-11-16-034644
/Volumes/Time Machine Backups/Backups.backupdb/YOURMACHINE/2019-11-23-034747
/Volumes/Time Machine Backups/Backups.backupdb/YOURMACHINE/2019-11-30-034432
/Volumes/Time Machine Backups/Backups.backupdb/YOURMACHINE/2019-12-07-034942
/Volumes/Time Machine Backups/Backups.backupdb/YOURMACHINE/2019-12-14-034909
/Volumes/Time Machine Backups/Backups.backupdb/YOURMACHINE/2019-12-21-034705
/Volumes/Time Machine Backups/Backups.backupdb/YOURMACHINE/2019-12-28-034743
----------------
/dev/disk2s1 on / (apfs, local, journaled)
devfs on /dev (devfs, local, nobrowse)
/dev/disk2s4 on /private/var/vm (apfs, local, noexec, journaled, noatime, nobrowse)
map -hosts on /net (autofs, nosuid, automounted, nobrowse)
map auto_home on /home (autofs, automounted, nobrowse)
//Time%20Machine%20User@server._afpovertcp._tcp.local./Time%20Machine%20Folder on /Volumes/com.apple.TimeMachine.Time Machine Folder-F7099937-ACDF-CDEF-9090-67769BC3CB3A (afpfs, nobrowse)
/dev/disk4s2 on /Volumes/Time Machine Backups (hfs, local, nodev, nosuid, journaled, nobrowse)
----------------
---------- Month: 2019-09
----------
---------- Month: 2019-10
----------
---------- Month: 2019-11
Deleting: /Volumes/Time Machine Backups/Backups.backupdb/YOURMACHINE/2019-11-09-034834
Deleted (6.0G): /Volumes/Time Machine Backups/Backups.backupdb/YOURMACHINE/2019-11-09-034834
Total deleted: 6.0G
Deleting: /Volumes/Time Machine Backups/Backups.backupdb/YOURMACHINE/2019-11-16-034644
```

```
hdiutil compact /Volumes/TM/YOURMACHINE.sparsebundle/
Starting to compact…
Reclaiming free space…
.................................................................................................................................................................
Finishing compaction…
Reclaimed 36.6 GB out of 7.0 TB possible.
```
## Recognition
My family!

## Final remarks
You may use this code however you see fit in any form whatsoever.
And enjoy!!!

## Questions & Answers
* Q: Who is this script designed for?
   - Those people comfortable with the command line that want to have control on the cleanup of old backups by time Machine.

* Q: Is this script feature complete and fully tested?
   - Nope. It's a work in progress. I've tested it as needed for my needs, but it's possible to build additional features by contributing to the script.
