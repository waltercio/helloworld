FROM alpine:latest

RUN apk add --update wget bash libc6-compat \
	&& apk add maven \
    && apk add curl \
    && mkdir -p /helloworld \
    && apk add vim 
	
RUN mkdir -p /helloworld && \
    chmod -R 777 /helloworld

RUN mkdir -p /helloworld/target && chmod -R 777 /helloworld/target

RUN mkdir -p /helloworld/target/classes && chmod -R 777 /helloworld/target/classes

WORKDIR /helloworld

COPY . .

RUN chmod -R u+w /helloworld && chgrp -R 0 /helloworld

RUN chmod -R u+w /helloworld/target && chgrp -R 0 /helloworld/target

RUN chmod -R u+w /helloworld/target/classes && chgrp -R 0 /helloworld/target/classes

RUN chmod -R u+w /helloworld/target/classes/application.properties && chgrp -R 0 /helloworld/target/classes/application.properties

RUN chmod -R u+w /helloworld/src/main/resources/application.properties && chgrp -R 0 /helloworld/src/main/resources/application.properties

RUN chown -R 1000650000 /helloworld

RUN chown -R 1000650000 /helloworld/target

RUN chown -R 1000650000 /helloworld/target/classes

RUN chown -R 1000650000 /helloworld/target/classes/application.properties

RUN chown -R 1000650000 /helloworld/src/main/resources/application.properties

ENV HOME=/tmp

RUN mvn -Dmaven.repo.local=/tmp/.m2/repository clean install

RUN chmod +wrx entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]