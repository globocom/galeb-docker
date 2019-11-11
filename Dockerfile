FROM ubuntu:latest

LABEL mantainer="Wilson Júnior <wilsonpjunior@gmail.com>"

RUN apt-get update && \
    apt-get install -y git maven && \
    apt-get install -y default-jdk && \
    git clone --recursive https://github.com/globocom/galeb && \
    cd galeb && mvn clean install && \
    cd galeb && mvn -q dependency:build-classpath -Dmdep.outputFile=/tmp/_classpath -DregenerateFile=true > /dev/null 2>&1 && \
    mv galeb /opt/

COPY ["cluster.xml", "config.json", "log4j.xml", "/opt/galeb/"]
COPY run.sh /usr/bin/

EXPOSE 8000 9000

ENTRYPOINT ["/usr/bin/run.sh"]
