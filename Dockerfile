FROM       ubuntu:latest
MAINTAINER Wilson Júnior <wilsonpjunior@gmail.com>

RUN apt-get update
RUN apt-get install -y git maven
RUN apt-get install -y default-jdk

RUN git clone --recursive https://github.com/globocom/galeb
RUN cd galeb && mvn clean package

RUN apt-get install -y wget
RUN wget http://dl.bintray.com/vertx/downloads/vert.x-2.1.1.tar.gz
RUN tar -zxvf vert.x-2.1.1.tar.gz
RUN mv vert.x-2.1.1 /opt/
RUN mv galeb /opt/
ADD run.sh /usr/bin/

EXPOSE 8000
EXPOSE 9000

ENTRYPOINT ["/usr/bin/run.sh"]
