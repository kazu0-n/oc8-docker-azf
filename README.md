Files are in connection with OwnCloud8 docker container
======================
##Outline
This container image is mounting the Azure File Storage for OwnCloud shared directory.

The container uses systemd to control processes.
It consists of multiple files shell script and systemd unit.

####Building  container image
```
# docker build --no-cache --rm -t oc8:image-version-no .
```
####Running container
This image controls processes using systemd. So it's necessary to use privileged mode.
```
# docker run -i -t -d --name=oc8015 --privileged -p 10080:80 --link pgsql94:ocdb oc8:image-version-no
```
####Explanation for systemd unit files and execution Shell script
