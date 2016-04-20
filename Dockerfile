FROM buildpack-deps:trusty-curl

MAINTAINER Alexei Ledenev <alexei.led@gmail.com>
MAINTAINER github.com/PengBAI

COPY chkconfig /sbin/chkconfig
COPY init.ora /
COPY initXETemp.ora /

RUN apt-get update && \
    apt-get install -y libaio1 net-tools bc unixodbc && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/awk /bin/awk
RUN mkdir /var/lock/subsys
RUN touch /var/lock/subsys/listener
RUN chmod 755 /sbin/chkconfig
RUN ln -sf /proc/mounts /etc/mtab

COPY oracle-shm /etc/init.d/oracle-shm
RUN chmod 755 /etc/init.d/oracle-shm
RUN /etc/init.d/oracle-shm start

COPY ./pkg /tmp
RUN cat /tmp/oracle-xe_11.2.0-1.0_amd64.deba* > /tmp/oracle-xe_11.2.0-1.0_amd64.deb && \
    dpkg --install /tmp/oracle-xe_11.2.0-1.0_amd64.deb && \
    rm /tmp/oracle-xe_11.2.0-1.0_amd64.deb

RUN mv /init.ora /u01/app/oracle/product/11.2.0/xe/config/scripts
RUN mv /initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts

RUN printf 8080\\n1521\\noracle\\noracle\\ny\\n | /etc/init.d/oracle-xe configure

RUN echo 'export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe' >> /etc/bash.bashrc
RUN echo 'export PATH=$ORACLE_HOME/bin:$PATH' >> /etc/bash.bashrc
RUN echo 'export ORACLE_SID=XE' >> /etc/bash.bashrc

VOLUME /usr/lib/oracle/xe/oradata/XE

EXPOSE 1521
EXPOSE 8080

COPY start.sh /
RUN chmod 755 /start.sh

CMD /start.sh
