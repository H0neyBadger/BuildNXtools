README
======
This project use podman ArchLinux image to build nintendo switch tools and homebrews.

Run
---
```bash
sudo ./podman_build.sh
```

Or from your host system
```
./run.sh

```

SELinux
-------
Note for SELinux users: to avoid trouble with selinux and docker mounted files; you may use the context type ```container_file_t```

```
# For tests only
# chcon -Rv -t container_file_t './'

# Redefine the default SELinux context for the current dir 
sudo semanage fcontext --add "$(pwd)(/.*)?" --type container_file_t
# Verify
sudo semanage fcontext -l | grep  "$(pwd)"
# Apply
sudo restorecon -Rv "$(pwd)"
```
