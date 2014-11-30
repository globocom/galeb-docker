FROM       ubuntu:latest
MAINTAINER Wilson Júnior <wilsonpjunior@gmail.com>

RUN apt-get update
RUN apt-get install -y git maven
RUN apt-get install -y default-jdk

RUN git clone --recursive https://github.com/globocom/galeb
RUN cd galeb && mvn clean install
RUN cd galeb && mvn -q dependency:build-classpath -Dmdep.outputFile=/tmp/_classpath -DregenerateFile=true > /dev/null 2>&1

RUN mv galeb /opt/
ADD cluster.xml /opt/galeb/
ADD config.json /opt/galeb/
ADD log4j.xml /opt/galeb/
ADD run.sh /usr/bin/

EXPOSE 8000
EXPOSE 9000

ENTRYPOINT ["/usr/bin/run.sh"]
