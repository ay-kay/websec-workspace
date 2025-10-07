
FROM docker.io/kalilinux/kali-rolling:latest

LABEL maintainer="websecurity-training"
LABEL description="Kali Linux Container mit Web Security Tools"

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install \
    kali-linux-core \
    kali-tools-web \
    john \
    ffuf \
    feroxbuster \
    gobuster \
    curl \
    wget \
    git \
    vim \
    nano \
    net-tools \
    iputils-ping \
    dnsutils \
    locales \
    tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8


WORKDIR /opt

RUN git clone --depth 1 https://github.com/swisskyrepo/PayloadsAllTheThings.git

RUN mkdir -p /opt/seclists && \
    cd /opt/seclists && \
    git init && \
    git remote add origin https://github.com/danielmiessler/SecLists.git && \
    git config core.sparseCheckout true && \
    echo "Discovery/*" >> .git/info/sparse-checkout && \
    echo "Passwords/*" >> .git/info/sparse-checkout && \
    git pull --depth 1 origin master


RUN mkdir -p /workspace
WORKDIR /workspace

RUN cat <<'EOF' > /etc/motd
==================================================
 Web Security Training Environment
 Kali Linux mit Web Security Metacapackage
==================================================

Wichtige Tools:
  Web: sqlmap, gobuster, nikto, dirb, wfuzz, ffuf
  Passwords: hydra, john, medusa

Lokale Ressourcen:
  /opt/PayloadsAllTheThings - Payload-Sammlung
  /opt/seclists - SecLists
  /usr/share/webshells - Webshells (PHP, ASP, JSP, etc.)
  /workspace - Arbeitsverzeichnis

Burp Suite Proxy:
  --proxy=http://host.docker.internal:8080

--------------------------------------------------
LEARNING RESOURCES & CHEAT SHEETS:
--------------------------------------------------

PortSwigger Web Security Academy:
  https://portswigger.net/web-security

PortSwigger Cheat Sheets:
  XSS:  https://portswigger.net/web-security/cross-site-scripting/cheat-sheet
  SSRF: https://portswigger.net/web-security/ssrf/url-validation-bypass-cheat-sheet
  SQLi: https://portswigger.net/web-security/sql-injection/cheat-sheet

OWASP Cheat Sheet Series:
  https://cheatsheetseries.owasp.org/
==================================================
EOF

RUN echo 'cat /etc/motd' >> /etc/bash.bashrc

SHELL ["/bin/bash", "-c"]

ENTRYPOINT ["/bin/bash"]