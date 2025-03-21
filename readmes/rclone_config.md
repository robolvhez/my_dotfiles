# Mount rclone

For any rclone connection, create the directories:

```shell
# create the directory
mkdir -p /mnt/rclone/<your_mount>

# make your user propietary of that dir
chown <username>:<group> /mnt/rclone/<your_mount>
```

Preferably, also, create symlinks in `~/Documents/`

To activate the connections, copy the `.service` files from `rclone/dotfiles/` into

```shell
/home/<username>/.config/systemd/user/
```

Make a `cd` into the directory and then run:

```shell
systemd --user start rclone-mount*
```

## Pending

- [ ] How to automate the mounts?
