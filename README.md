# tm_del_old_baks
-----------------
by oPromessa, 2020, V0.0.1
* Published on [https://github.com/oPromessa/tm_del_old_baks/](https://github.com/oPromessa/tm_del_old_baks/)

## Description
--------------
MAC OS shell utility to delete old Time Machine backups. Keeps one monthly copy. Also compacts the backup location to free up space.

## Features
-----------
* 

THIS SCRIPT IS PROVIDED WITH NO WARRANTY WHATSOEVER.
PLEASE REVIEW THE SOURCE CODE TO MAKE SURE IT WILL WORK FOR YOUR NEEDS.
IF YOU FIND A BUG, PLEASE REPORT IT.

## Requirements
---------------
* MAC
* ibash
* Must be run as _root_ with =sudo= to have permission to run =tmutil= (Time Machine Command/line utility) commmand.

## Setup on MAC
--------------------
* Place file on a folder an run with "sudo ..."
```bash
$ sudo tm_del_old_baks.sh
```

## Configuration
----------------
* * Edit variable machin ewithin file. 
```bash
machine=Donald
```

## Usage/Arguments/Options
--------------------------
Place the file uploadr.py in any directory and run via ssh (execution privs required).
```bash
tm_del_old_baks.sh: Usage: sudo tm_del_old_baks.sh [ -h | -? ] -v -r -f -M <opt>
tm_del_old_baks.sh: Deletes TimeMachine backups leaving last backup of each month. Except from last and current month which are not touched.
tm_del_old_baks.sh: -v: Verbose: show (partial) list of files to be deleted.
tm_del_old_baks.sh: -r: Dry run: echo commands but do not execute
tm_del_old_baks.sh: -f: Force execution of delete backups without asking
```


## Recognition
--------------
My family!

## Final remarks
---------------
You may use this code however you see fit in any form whatsoever.
And enjoy!!!

## Questions & Answers
----------------------
* Q: Who is this script designed for?
   - Those people comfortable with the command line that want to have control on the cleanup of old backups by time Machine.
   
* Q: Is this script feature complete and fully tested?
   - Nope. It's a work in progress. I've tested it as needed for my needs, but it's possible to build additional features by contributing to the script.
  
