FROM ubuntu
ENV INSTALL_PATH /1point3acres
ENV LOG_PATH /tmp/1point3acres.log

RUN apt update \
    && apt install -y cron \
    && apt install -y python3 python3-pip tesseract-ocr=4.1.1-2build2 \
    && pip3 install -r requests==2.22.0 lxml==4.6.3 cssselect==1.1.0 TwoCaptcha==0.0.1 \
    && echo "15 8 * * * cd ${INSTALL_PATH}/src && python3 ./service.py 2>&1 1>${LOG_PATH}" >> /etc/crontab

COPY ./1point3acres ${INSTALL_PATH}
# RUN bash ${INSTALL_PATH}/prepare.sh

# Configure credentials
COPY ./cookie.json ${INSTALL_PATH}/configure/cookie.json

CMD cron && tail -f ${LOG_PATH}
