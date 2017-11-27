FROM debian:9

RUN groupadd -r --gid=999 zuul && useradd -r -g zuul -d / -s /usr/sbin/nologin --uid=999 zuul

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                gcc \
                git \
                graphviz \
                libffi-dev \
                libssl-dev \
                libyaml-dev \
                make \
                openssh-client \
                python3-dev \
                python3-pip \
                python3-setuptools \
                python3-wheel && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://git.openstack.org/openstack-infra/zuul.git /opt/zuul

WORKDIR /opt/zuul
RUN git checkout feature/zuulv3 && \
    pip3 install . && \
    rm -rf /opt/zuul

COPY config/ /etc/zuul/

RUN mkdir -p /var/lib/zuul
WORKDIR /var/lib/zuul
VOLUME /var/lib/zuul

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 79 4730 8001 9000
CMD ["/bin/bash"]
