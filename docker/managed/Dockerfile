FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Corporate networks often block HTTP :80 to Ubuntu mirrors; use HTTPS.
RUN sed -i 's|http://|https://|g' /etc/apt/sources.list \
    && apt-get -o Acquire::https::Verify-Peer=false \
               -o Acquire::https::Verify-Host=false update \
    && apt-get -o Acquire::https::Verify-Peer=false \
               -o Acquire::https::Verify-Host=false install -y --no-install-recommends \
        ca-certificates \
        openssh-server \
        python3 \
        sudo \
        iputils-ping \
        vim \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd /root/.ssh \
    && echo 'root:ansible' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && ssh-keygen -A

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e"]
