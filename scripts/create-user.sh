#! /bin/sh -e

d=`dirname "$0"`

# collect Makefile-generated user information
. "$d"/../.userinfo.sh

# create non-root user's group and mirror account
groupadd -g "$mk_UID" "$mk_LOGNAME" || true
useradd -g "$mk_GID" -m -s /bin/bash -u "$mk_UID" "$mk_LOGNAME"

# allow non-root user to use sudo without password
mkdir -p /etc/sudoers.d/
echo "$mk_LOGNAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/"$mk_LOGNAME"

# configure tmux for people who like emacs but don't use control-t
cp "$d"/../.tmux.conf /home/"$mk_LOGNAME"
chown "$mk_LOGNAME" /home/"$mk_LOGNAME"/.tmux.conf
