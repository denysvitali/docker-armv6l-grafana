FROM resin/rpi-raspbian:stretch
RUN apt-get update
RUN apt-get install -y ca-certificates adduser libfontconfig wget apt-utils
ENV GOARCH arm
ENV GOARM 6
ENV PATH=/usr/share/grafana/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    GF_PATHS_CONFIG="/etc/grafana/grafana.ini" \
    GF_PATHS_DATA="/var/lib/grafana" \
    GF_PATHS_HOME="/usr/share/grafana" \
    GF_PATHS_LOGS="/var/log/grafana" \
    GF_PATHS_PLUGINS="/var/lib/grafana/plugins" \
    GF_PATHS_PROVISIONING="/etc/grafana/provisioning"
RUN apt-get update
RUN apt-get install -y ca-certificates adduser libfontconfig
RUN wget 'https://dl.bintray.com/fg2it/deb-rpi-1b/main/g/grafana_5.1.0_armhf.deb' -O /tmp/grafana.deb
RUN dpkg -i /tmp/grafana.deb
EXPOSE 3000

COPY ./run.sh /run.sh

USER grafana
WORKDIR /
ENTRYPOINT [ "/run.sh" ]
