FROM alpine:latest

RUN apk add --update wget bash libc6-compat \
	&& apk add maven \
    && apk add curl \
    && mkdir -p /helloworld \
    && apk add vim 
	
COPY . /helloworld

WORKDIR /helloworld
RUN chown
RUN chmod 777 target/classes/application.properties
ENV HOME /tmp
RUN mvn -Dmaven.repo.local=/tmp/.m2/repository clean install
RUN chmod +wrx entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]