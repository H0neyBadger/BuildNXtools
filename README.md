README
======
This project use docker ArchLinux image to build nintendo switch tools and homebrews.

Config
------
Edit Dockerfile to add your current user's UID and GID
```
vi docker/Dockerfile
```
The GID/UID must match the current system folder owner 

Run
---
As a privileged user (root or a user from the docker group)
```bash
./docker_build.sh
```

Or from your host system
```
./run.sh
```


