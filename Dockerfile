FROM python:3.7
WORKDIR /web
ADD . /web

RUN apt-get update
RUN pip install -r requirements.txt
RUN pip install opencv-python-headless

RUN apt-get install -y tzdata
RUN cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime
RUN ln -sf /etc/localtime /usr/share/zoneinfo/Asia/Taipei

# Setup supervisord
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY gunicorn.conf /etc/supervisor/gunicorn.conf

COPY . .

ENTRYPOINT ["bash", "entrypoint.sh"]