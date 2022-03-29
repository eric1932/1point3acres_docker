FROM ubuntu
ENV INSTALL_PATH /1point3acres
ENV LOG_PATH /tmp/1point3acres.log

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update \
    # RUN prepare.sh (apt install)
    && apt install -y cron \
    && apt install -y python3 python3-pip \
    # && pip3 install requests==2.22.0 lxml==4.6.3 cssselect==1.1.0 2captcha-python==1.0.3 \
    && echo "15 8 * * * cd ${INSTALL_PATH}/src && python3 ./service.py 2>&1 1>${LOG_PATH}" >> /etc/crontab \
    && touch ${LOG_PATH}

COPY ./1point3acres ${INSTALL_PATH}

# RUN prepare.sh (python requirements)
RUN pip3 install -r ${INSTALL_PATH}/requirements.txt

# Configure credentials
COPY ./cookie.json ${INSTALL_PATH}/configure/cookie.json
# COPY ./data.json ${INSTALL_PATH}/configure/data.json

# crontab
# CMD cron && tail -f ${LOG_PATH}
# Single-run
CMD cd ${INSTALL_PATH}/src && python3 ./service.py
