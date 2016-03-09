FROM phusion/baseimage

RUN sed -i -e 's/archive.ubuntu.com/mirror.solidgear.prv/' -e 's/deb-src/#deb-src/' /etc/apt/sources.list

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  git \
  mtr \
  python-pip \
  python-dev

WORKDIR /web-mtr

ADD requirements.txt /web-mtr

RUN pip install -r /web-mtr/requirements.txt

ADD . /web-mtr/

CMD ["gunicorn","-k","flask_sockets.worker","-b", "0.0.0.0:8000", "mtr-web:app"] 
