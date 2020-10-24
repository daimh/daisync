# daisync, rsync-based time-machine-backup

## Installation
```
$ wget https://raw.githubusercontent.com/daimh/daisync/master/daisync
$ chmod +x daisync
$ mv daisync ~/bin/ # or any directory in your PATH
```

## Test steps

1. prepare a directory for tests
```
$ mkdir src
$ seq 2 | split -l 1 - src/old
$ tree src
```

2. backs up all files under directory 'src' to 'dst'
```
$ mkdir -p dst/0000
$ daisync -s src/ dst
$ tree dst
```

3. change some files in src, and back them up again
```
$ seq 2 | split -l 1 - src/new
$ daisync -s src/ dst
$ tree dst
```

4. exclude a subdirectory from backup
```
$ mkdir src/this-is-excluded-from-daisync
$ touch src/this-is-excluded-from-daisync/demo
$ daisync -s src/ dst
$ echo "*-excluded-from-daisync" > dst/.daisync-exclude-from
$ daisync -s src/ dst
$ tree dst
```

5. use rsync parameter to exclude file that is less/greater than 10 bytes
```
$ seq 10 > src/big
$ daisync -s src/ dst
$ daisync -s "--max-size=10 src/" dst
$ tree dst
```

6. relink moved big file to save space

```
$ seq 200000 > src/1M
$ daisync -s src/ dst
$ stat dst/0000/1M
$ mv src/1M src/1M-MOVED
$ daisync -l 1 -s src/ dst
$ stat dst/0001/1M dst/0000/1M-MOVED | grep Inode #It shows the same Inode
```

## Help
```
$ daisync -h
```

## Contribute

Contributions are always welcome!

## Copyright

Developed by [Manhong Dai](mailto:daimh@umich.edu)

Copyright © 2020 University of Michigan. License [GPLv3+](https://gnu.org/licenses/gpl.html): GNU GPL version 3 or later 

This is free software: you are free to change and redistribute it.

There is NO WARRANTY, to the extent permitted by law.

## Acknowledgment

Ruth Freedman, MPH, former administrator of MNI, UMICH

Fan Meng, Ph.D., Research Associate Professor, Psychiatry, UMICH

Huda Akil, Ph.D., Director of MNI, UMICH

Stanley J. Watson, M.D., Ph.D., Director of MNI, UMICH
