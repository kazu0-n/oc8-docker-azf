FROM centos:latest
MAINTAINER hostmaster@std-adhocracy.net
ENV container docker

# Perform updates
RUN yum -y update; yum clean all
RUN yum -y install epel-release

# Setting Azure Storage Mount
#RUN touch /etc/sysconfig/azfile_env
ADD ./azfenv.sh /usr/local/sbin/azfenv.sh
RUN chmod +x /usr/local/sbin/azfenv.sh
ADD ./azfenv.service /etc/systemd/system/azfenv.service
ADD ./mnt-pgsql.mount /etc/systemd/system/mnt-pgsql.mount

# Install systemd
#RUN yum swap -y fakesystemd systemd || true

# Setting owncloud repositris
RUN rpm --import https://download.owncloud.org/download/repositories/stable/CentOS_7/repodata/repomd.xml.key
ADD ce:stable.repo /etc/yum.repos.d/

# Setting remi repositris
RUN rpm -ivh http://remi.kazukioishi.net/enterprise/remi-release-7.rpm

# Install owncloud rpms
RUN yum install -y httpd php-pgsql amba-client samba-common cifs-utils owncloud || true

# Install and Update PHP
RUN yum --enablerepo=remi-php56 -y update php* || true

# Set Apache environment variables (can be changed on docker run with -e)
RUN sed -i -e "s|#ServerName www.example.com:80|ServerName localhost:80|g" /etc/httpd/conf/httpd.conf

# Expose port 80 and set httpd as our entrypoint
RUN systemctl enable httpd
RUN systemctl enable azfenv.service
RUN systemctl enable mnt-pgsql.mount
EXPOSE 80
CMD ["/sbin/init"]