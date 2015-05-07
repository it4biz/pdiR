FROM wmarinho/pentaho-kettle

ENV R_VERSION 0.0.4
RUN apt-get update -y

RUN apt-get install r-base -y

RUN apt-get install unzip

RUN wget -nv http://dekarlab.de/download/RScriptPlugin-${R_VERSION}.zip -O /tmp/RScriptPlugin-${R_VERSION}.zip
 
RUN unzip -q /tmp/RScriptPlugin-${R_VERSION}.zip -d /opt/ && \
    mv /opt/RScript* /opt/rscript

COPY init.r /opt/rscript/






