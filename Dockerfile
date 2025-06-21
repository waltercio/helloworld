FROM alpine:latest

RUN apk add --update wget bash libc6-compat \
	&& apk add maven \
    && apk add curl \
    && mkdir -p /helloworld \
    && apk add vim 
	
COPY . /helloworld

WORKDIR /helloworld

RUN ls -ltra

RUN mkdir target $$ mkdir target/classes

RUN echo 'server.port=22244' > target/classes/application.properties

RUN chmod 777 target/classes/application.properties

ENV HOME /tmp

RUN mvn -Dmaven.repo.local=/tmp/.m2/repository clean install

RUN chmod +wrx entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]