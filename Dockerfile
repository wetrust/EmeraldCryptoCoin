FROM phusion/baseimage:0.10.2


RUN apt-get update -y && apt-get install --no-install-recommends -y \
    git build-essential libssl-dev libdb5.3-dev libdb5.3++-dev \
    libboost-all-dev libqrencode-dev libminiupnpc-dev miniupnpc \
    ca-certificates \
    && apt-get autoremove -y && apt-get autoclean -y && apt-get clean \
    && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/* && rm -rf /var/tmp/*

RUN useradd -r -m -d /opt/emerald emerald
RUN mkdir /data && \
    chown emerald:emerald /data && \
    chmod 700 /data
RUN mkdir /opt/emerald/.emerald && \
    chown emerald:emerald /opt/emerald/.emerald && \
    chmod 700 /opt/emerald/.emerald
ADD emerald.conf /opt/emerald/.emerald/emerald.conf
RUN chmod 700 /opt/emerald/ && chown emerald:emerald /opt/emerald/
RUN chown 600 /opt/emerald/.emerald/emerald.conf && chown emerald:emerald /opt/emerald/.emerald/emerald.conf

USER emerald
WORKDIR /opt/emerald
RUN git clone https://github.com/crypto-currency/Emerald.git
WORKDIR /opt/emerald/Emerald/src
RUN test -e obj || mkdir obj 
RUN make -f makefile.unix && mv emeraldd /opt/emerald/
WORKDIR /opt/emerald
RUN rm -rf Emerald
USER root

RUN mkdir /etc/service/emeraldd
COPY emeraldd.sh /etc/service/emeraldd/run
RUN chmod +x /etc/service/emeraldd/run

EXPOSE 12127
VOLUME /data

CMD ["/sbin/my_init"]