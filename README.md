# hac
hash and check

hash.sh: for each directory $DIR in current working directory: create $DIR.sha1sum containing sha1 hashes for every file in $DIR

check.sh: for each $DIR.sha1sum check files using `sha1sum -c $DIR.sha1sum`
