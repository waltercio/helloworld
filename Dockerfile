FROM alpine:latest

RUN apk add --update wget bash libc6-compat \
	&& apk add maven \
    && apk add curl \
    && mkdir -p /helloworld \
    && apk add vim 
	
RUN mkdir -p /helloworld && \
    chmod -R 777 /helloworld

WORKDIR /helloworld

COPY . .

RUN chown -R 1000650000 /helloworld

RUN chown -R 1000650000 /helloworld/target

RUN chown -R 1000650000 /helloworld/target/classes

RUN chown -R 1000650000 /helloworld/src/main/resources/application.properties

ENV HOME=/tmp

RUN mvn -Dmaven.repo.local=/tmp/.m2/repository clean install

RUN chmod +wrx entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]