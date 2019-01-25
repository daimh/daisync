#!/usr/bin/env bash
set -xe
which tree md5sum shuf bc updatedb flock rsync fuser df locate

################source directory################################################
#parepare directory 'source' for tests
################################################################################
mkdir -p tutorial.dir/source.dir
date >> tutorial.dir/source.dir/1
mkdir -p tutorial.dir/source.dir/2
tree tutorial.dir/source.dir
################tutorial-1######################################################
#backs up all files under directory 'source', create some new files under source directory, and back it up again
################################################################################
mkdir -p tutorial.dir/tutorial-1.dir/0000
scripts/daisync -s tutorial.dir/source.dir/ tutorial.dir/tutorial-1.dir
echo 3 >> tutorial.dir/source.dir/2/3
scripts/daisync -s tutorial.dir/source.dir/ tutorial.dir/tutorial-1.dir
tree -a tutorial.dir/tutorial-1.dir

################tutorial-2######################################################
#exclude a subdirectory '2' from backup
################################################################################
mkdir -p tutorial.dir/tutorial-2.dir/0000
scripts/daisync -s tutorial.dir/source.dir/ tutorial.dir/tutorial-2.dir
echo 2 > tutorial.dir/tutorial-2.dir/.exclude-from
scripts/daisync -s tutorial.dir/source.dir/ tutorial.dir/tutorial-2.dir
tree -a tutorial.dir/tutorial-2.dir

################tutorial-3######################################################
#use rsync parameter to exclude file that is less/greater than 10 bytes
################################################################################
mkdir -p tutorial.dir/tutorial-3.dir/0000
scripts/daisync -s "--min-size=10 tutorial.dir/source.dir/" tutorial.dir/tutorial-3.dir
scripts/daisync -s "--max-size=10 tutorial.dir/source.dir/" tutorial.dir/tutorial-3.dir
tree -a tutorial.dir/tutorial-3.dir

################tutorial-4######################################################
#locate file '1' 
################################################################################
mkdir -p tutorial.dir/tutorial-4.dir/0000
scripts/daisync -d 400 -s tutorial.dir/source.dir/ tutorial.dir/tutorial-4.dir
scripts/daisync-locate tutorial.dir/tutorial-4.dir -b 1

################tutorial-5######################################################
#generate plot report for multiple backups 
################################################################################
scripts/daisync-plot -o tutorial.dir/tutorial-5.png tutorial.dir/tutorial-*.dir
