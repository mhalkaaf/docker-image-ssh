FROM centos:7
RUN yum update -y && yum install openssh-server vim -y
RUN mkdir /var/run/sshd
RUN echo 'root:P@ssw0rd123' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]