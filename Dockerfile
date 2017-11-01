FROM debian

LABEL MAINTAINER="Mickael AZEMA mickael@azema.net"

RUN apt-get update && apt-get clean

RUN apt-get update && apt-get install -y python \
    locales \
    python-setuptools \
    python-requests \
    python-pycurl \
    python-crypto \
    python-imaging \
    python-pyxmpp \
    python-jinja2 \
    python-thrift \
    python-feedparser \
    python-beautifulsoup \
    python-pip \
    tesseract-ocr \
    python-beaker \
    unrar-free \
    unzip \
    gocr \
    python-django \
    git \
    rhino \
    
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
### Checkout pyload sources
RUN git clone https://github.com/pyload/pyload.git /opt/pyload  \
        && cd /opt/pyload \
        && git checkout stable 


### Add PyLoad Config Dir
ADD conf /opt/pyload/.pyload
### Add own script to copy file to home nas

#Add key for transfert to NAS
#RUN mkdir /root/.ssh && chmod 700 /root/.ssh
#ADD key /root/.ssh
#RUN chmod 400 /root/.ssh/id_rsa

RUN apt-get -y autoclean
RUN apt-get -y clean
RUN apt-get -y autoremove

### Expose ports
EXPOSE 80 7227

ADD run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 80
VOLUME /opt/pyload/Downloads

CMD ["/run.sh"]
