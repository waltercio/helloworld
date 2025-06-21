FROM alpine:latest

RUN apk add --update wget bash libc6-compat \
	&& apk add maven \
    && apk add curl \
    && mkdir -p /helloworld \
    && apk add vim 
	
RUN mkdir -p /helloworld && \
    chmod -R 777 /helloworld

RUN mkdir -p /helloworld/target && \
    mkdir -p /helloworld/target/classes && \
    chmod -R g+rwX /helloworld && \
    chown -R 1001:0 /helloworld

WORKDIR /helloworld

COPY . .

RUN echo 'server.port=22244' > target/classes/application.properties

RUN chmod -R u+w /helloworld

RUN chmod -R u+w /helloworld/target

RUN chmod -R u+w /helloworld/target/classes

RUN chown -R $(whoami) /helloworld

RUN chown -R $(whoami) /helloworld/target

RUN chown -R $(whoami) /helloworld/target/classes

RUN chmod -R u+w /helloworld/target/classes/application.properties

RUN chown -R $(whoami) /helloworld/target/classes/application.properties

ENV HOME=/tmp

RUN mvn -Dmaven.repo.local=/tmp/.m2/repository clean install

RUN chmod +wrx entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]