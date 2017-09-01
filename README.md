About
-----

Builds old fast version of the esedbexport tool (libesedb-alpha-20120201) so you don't have to.

Based on Alpine.

### Usage

```
docker run -it --rm -v /path/to/ntds:/data ilyaglow/esedbexport -t /data/domain /data/domain-ntds.dit
```
