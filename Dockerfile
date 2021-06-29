from ubuntu

SHELL ["/bin/bash", "--login", "-o", "pipefail", "-c"]


ARG NB_USER="ariel"
ARG NB_UID="1000"
ARG NB_GID="100"



RUN apt-get -q update && \
    apt-get install -yq --no-install-recommends \
    wget \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation \
    run-one \
    git \
    cifs-utils && \
    apt-get clean && rm -rf /var/lib/apt/lists/*



ENV HASH=\$5\$No6Sm6L3G7F\$Kw5J5e2Tapt.7wm/tWdUdouFj1LDLtkhuUobCUR51.1


RUN sed -i.bak -e '/^%sudo/a '"$NB_USER"' ALL=(ALL) NOPASSWD: ALL' /etc/sudoers && cat /etc/sudoers && \
    useradd -m -g $NB_GID -u $NB_UID $NB_USER && \ 
    sudo usermod -aG sudo $NB_USER && \ 
    echo "$NB_USER:$HASH" | /usr/sbin/chpasswd -e && usermod -aG $NB_GID $NB_USER 

USER $NB_USER
WORKDIR /home/$NB_USER
