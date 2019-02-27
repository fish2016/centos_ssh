FROM centos

#http://blog.csdn.net/waixin/article/details/50212079
#show the version of centos 
RUN cat /etc/centos-release

RUN yum install -y openssl openssh-server
#RUN yum install -y passwd #系统已经自带了

RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key  -N ''

RUN sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
RUN sed -i "s/UsePAM yes/UsePAM no/g" /etc/ssh/sshd_config

##########################################################################
# passwords 
RUN echo "root:root" | chpasswd
#RUN echo password | passwd --stdin root

RUN /usr/sbin/sshd -D &

EXPOSE 22