FROM wmarinho/pentaho-kettle

ENV R_VERSION 0.0.4
RUN apt-get update -y

RUN apt-get install r-base -y

RUN apt-get install unzip

RUN wget -nv http://dekarlab.de/download/RScriptPlugin-${R_VERSION}.zip -O /tmp/RScriptPlugin-${R_VERSION}.zip
 
RUN unzip -q /tmp/RScriptPlugin-${R_VERSION}.zip -d /opt/ &&\
    mv /opt/RScript* ${PENTAHO_HOME}/data-integration/plugins/steps/

ENV PENTAHO_JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-amd64
RUN wget -nv http://cran.r-project.org/src/contrib/rJava_0.9-6.tar.gz -O /tmp/rJava_0.9-6.tar.gz &&\
    R CMD javareconf JAVA_HOME=${PENTAHO_JAVA_HOME} &&\
    R CMD INSTALL -l /usr/lib/R/library /tmp/rJava_0.9-6.tar.gz 

RUN cp /usr/lib/R/library/rJava/jri/libjri.so   ${PENTAHO_HOME}/data-integration/libswt/linux/x86_64/libjri.so

ENV R_HOME=/usr/lib/R
ENV R_LIBS_USER=/usr/lib/R/library
ENV PATH=.:$PATH:$R_HOME/bin

COPY test /opt/pentaho/test
RUN sed -i 's/\.\.\/libswt/libswt/g' ${PENTAHO_HOME}/data-integration/spoon.sh


