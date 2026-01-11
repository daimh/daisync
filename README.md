# daisync — rsync-based Time-Machine Style Backup Tool

**daisync** is a powerful, lightweight, rsync-based backup tool that creates **time-machine-style** snapshots.

It has been used for decades at the **Michigan Neuroscience Institute (MNI)**, University of Michigan, to back up **petabytes** of research data nightly across multiple large file servers.

Since March 2022, the new **`-c reflink`** mode makes backups **modifiable**: changes to files in one snapshot do **not** affect others, thanks to **copy-on-write reflinks** instead of traditional hard links.

## Key Features

- Extremely space-efficient incremental backups using rsync + hardlinks/reflinks
- Daily/periodic snapshots named like `0000`, `0001`, `0002`, … (or custom naming)
- Users can browse and restore from **any** historical snapshot directly
- Supports **reflink** copy-on-write (CoW) — edit files in old backups safely
- Automatic detection of moved/renamed files with inode-based relinking (`-l`)
- Custom exclusion via `.daisync-exclude-from` file (globs supported)
- Pass-through of arbitrary **rsync** options
- Optional fast file search via `locate` database (`-ds` / `--mk-locate-db`)
- Single-file, dependency-free shell script — easy to deploy

## Requirements

- `rsync` ≥ 3.1.0 (for best reflink support — ideally ≥ 3.2.3)
- Filesystem that supports **hard links** (most Linux filesystems)
- For **reflink** mode (`-c reflink`): filesystem with CoW/reflink support  
  → **btrfs**, **XFS** (with reflink feature), some modern **ext4** setups
- `locate` / `updatedb` (optional — for `-ds` feature)

## Installation (one-liner)

```
wget https://raw.githubusercontent.com/daimh/daisync/master/daisync
chmod +x daisync
sudo mv daisync /usr/local/bin/   # just keep in ~/bin/ and make sure it is in your $PATH
```

## Quick Start

##### 1. Prepare test data
```
mkdir -p src
seq 10 | split -l 2 - src/file_

tree src
```

##### 2. First backup
```
mkdir -p dst
daisync -s src/ dst

tree dst               # → you should see dst/0000/
```

##### 3. Modify source → second backup
```
echo "new content" > src/file_aa
daisync -s src/ dst

tree dst               # → dst/0000/  dst/0001/
```

##### 4. Try reflink mode (if you have btrfs / XFS with reflink)
```
daisync -c reflink -s src/ dst

# Now you can safely modify files in dst/0001/ without breaking dst/0000/
```


## Common Usage Examples
#### Exclude a directory permanently
```
# After first backup
echo "this-is-excluded-from-daisync/" > dst/.daisync-exclude-from

# Next backups will respect it automatically
daisync -s src/ dst
```

#### Pass custom rsync options (e.g. size filters)
```
# Skip files > 1MB
daisync -s "--max-size=1M" src/ dst

# Or combine multiple options
daisync -s "--exclude=*.tmp --max-size=50M" src/ dst
```

#### Detect moved/renamed files (save huge space)
```
mv src/bigfile.dat src/bigfile-renamed.dat
daisync -l 1 -s src/ dst    # -l 1 = look back 1 backup
```

#### Create fast search database (locate)
```
daisync -ds src/ dst

# Then search (relative path only)
locate -d dst/0003/.daisync-locate.db important.pdf
```

## Full Help
```
daisync -h
```

## Important Notes

Reflink mode (-c reflink) is experimental but very useful on supported filesystems.
Traditional hardlink mode is more compatible but not modifiable (changing a file updates all linked backups).
Always test on non-critical data first when using reflink or new features.

## Contributing

Contributions, bug reports, and suggestions are very welcome!
Feel free to open issues or send pull requests.

## License
GPLv3+

Copyright © 2002–2026 University of Michigan / Manhong Dai

This is free software: you are free to change and redistribute it.
There is **NO WARRANTY**, to the extent permitted by law.
[GNU General Public License v3.0](https://gnu.org/licenses/gpl.html)


## Acknowledgments

Ruth Freedman, MPH

Fan Meng, Ph.D.

Brock Palen

Huda Akil, Ph.D.

Stanley J. Watson

And the whole MNI/University of Michigan team that helped make this tool reliable for massive production use over two decades.

Developed by Manhong Dai
