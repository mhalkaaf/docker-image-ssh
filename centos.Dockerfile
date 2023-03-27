FROM centos:7

# Install OpenSSH server and client
RUN yum -y install openssh-server vim

# Configure SSH server
RUN mkdir /var/run/sshd \
    && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key \
    && ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key \
    && ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key \
    && sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && echo "AllowUsers root" >> /etc/ssh/sshd_config

RUN echo "root:P@ssw0rd123" | chpasswd

# Expose SSH port
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
# FROM centos:7
#RUN yum update -y && yum install openssh-server vim -y
#RUN mkdir /var/run/sshd
#RUN echo 'root:P@ssw0rd123' | chpasswd
#RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
#EXPOSE 22
#CMD ["/usr/sbin/sshd", "-D"]

#    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \