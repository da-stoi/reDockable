# Use an official Ubuntu base image
FROM ubuntu:24.04

# Avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install OpenSSH server, clean up, create directories, set permissions, and configure SSH to allow root login
RUN apt-get update \
    && apt-get install -y iproute2 iputils-ping openssh-server telnet \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && mkdir -p /run/sshd \
    && chmod 755 /run/sshd \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Copy the root ssh config script
COPY root-ssh-config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/root-ssh-config.sh

# Copy reMarkable folder into the Ubuntu file system
RUN mkdir -p /usr/share/remarkable
COPY remarkable /usr/share/remarkable

# Expose SSH port
EXPOSE 22

# Start SSH server
CMD ["/usr/local/bin/root-ssh-config.sh"]
