FROM       ubuntu:latest
MAINTAINER Wilson Júnior <wilsonpjunior@gmail.com>

RUN apt-get update
RUN apt-get install -y git maven
RUN apt-get install -y default-jdk

RUN git clone https://github.com/globocom/galeb
RUN cd galeb && git submodule update --init
RUN cd galeb && mvn clean install
RUN cd galeb && mvn -q dependency:build-classpath -Dmdep.outputFile=/tmp/_classpath -DregenerateFile=true > /dev/null 2>&1

RUN mv galeb /opt/
ADD . /opt/galeb
ADD run.sh /usr/bin/

EXPOSE 8000
EXPOSE 9000

ENTRYPOINT ["/usr/bin/run.sh"]
