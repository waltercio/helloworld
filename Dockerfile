FROM alpine:latest

RUN apk add --update wget bash libc6-compat \
	&& apk add maven \
    && apk add curl \
    && mkdir -p /helloworld \
    && apk add vim 
	
COPY . /helloworld

WORKDIR /helloworld

RUN mkdir target $$ mkdir target/classes

RUN echo 'server.port=22244' > target/classes/application.properties

RUN ls -ltra target/classes/

RUN chgrp -R 0 target/classes/application.properties && chmod -R g=u target/classes/application.properties && chgrp -R 0 /helloworld && chmod -R g+rw /helloworld

RUN ls -ltra target/classes/

ENV HOME=/tmp

RUN mvn -Dmaven.repo.local=/tmp/.m2/repository clean install

RUN chmod +wrx entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]