# Contenedor para emerald Crypto coin
# Pertenece al proyecto emdpay.cl
# plataforma de pago para la moneda emd
# Mantenido por WeTrust E.I.R.L 2017

FROM ubuntu:xenial
USER root
RUN apt-get update && apt-get install --no-install-recommends -y \
    git build-essential libssl-dev libdb5.3-dev libdb5.3++-dev \
    libboost-all-dev libqrencode-dev libminiupnpc-dev miniupnpc \
    supervisor ca-certificates \
    && apt-get autoremove -y && apt-get autoclean -y && apt-get clean \
    && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/* && rm -rf /var/tmp/*
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN useradd emerald &&  mkdir /home/emerald && mkdir /home/emerald/.emerald
RUN chown -R emerald.emerald /home/emerald && chmod 770 -R /home/emerald

USER emerald
ADD emerald.conf /home/emerald/.emerald/emerald.conf
WORKDIR /home/emerald
RUN git clone https://github.com/crypto-currency/Emerald.git
WORKDIR /home/emerald/emerald/src
RUN mkdir obj && make -f makefile.unix && mv emeraldd /home/emerald/
WORKDIR /home/emerald
RUN rm -rf emerald
EXPOSE 12127
CMD supervisord -c /etc/supervisor/conf.d/supervisord.conf
