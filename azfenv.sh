[Unit]
Description = Setting Azure File Storage Credential
After=network.target
Before=remote-fs.target mnt-oc8015.mount

[Service]
Type = oneshot
ExecStart=/usr/local/sbin/azfenv.sh

[Install]
WantedBy = multi-user.target
[root@docker-easia-01 0.1.7]# cat azfenv.sh
#!/bin/sh -eu

ENV_FILE=/etc/sysconfig/azfile_env

AZF_NAME=$(curl -s https://s3-ap-northeast-1.amazonaws.com/dockerenv/AZF_NAME.txt)
AZF_PASS=$(curl -s https://s3-ap-northeast-1.amazonaws.com/dockerenv/AZF_PASS.txt)

AZFENV="username=$AZF_NAME\npassword=$AZF_PASS"
echo -e $AZFENV > $ENV_FILE