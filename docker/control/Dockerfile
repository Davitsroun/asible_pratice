FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Corporate networks often block HTTP :80 to Ubuntu mirrors; use HTTPS.
RUN sed -i 's|http://|https://|g' /etc/apt/sources.list \
    && apt-get -o Acquire::https::Verify-Peer=false \
               -o Acquire::https::Verify-Host=false update \
    && apt-get -o Acquire::https::Verify-Peer=false \
               -o Acquire::https::Verify-Host=false install -y --no-install-recommends \
        ca-certificates \
        python3 \
        python3-pip \
        openssh-client \
        sshpass \
        vim \
        iputils-ping \
        jq \
        curl \
    && pip3 install --no-cache-dir 'ansible-core>=2.15,<2.17' \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.ssh /root/my-ansible /etc/ansible \
    && ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa \
    && printf 'Host *\n  StrictHostKeyChecking no\n  UserKnownHostsFile=/dev/null\n' > /root/.ssh/config \
    && chmod 600 /root/.ssh/config \
    && printf '%s\n' \
        '[defaults]' \
        'inventory = /root/my-ansible/inventory' \
        'remote_user = root' \
        'ask_pass = false' \
        'host_key_checking = False' \
        'deprecation_warnings = False' \
        '' \
        '[privilege_escalation]' \
        'become = true' \
        'become_method = sudo' \
        'become_user = root' \
        'become_ask_pass = false' \
        > /etc/ansible/ansible.cfg

WORKDIR /root/my-ansible

CMD ["sleep", "infinity"]
