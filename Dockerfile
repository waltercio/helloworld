FROM alpine:latest

RUN apk add --update wget bash libc6-compat \
	&& apk add maven \
    && apk add curl \
    && mkdir -p /app \
	&& mkdir -p /app/helloworld \
    && apk add vim 
	
WORKDIR /app/helloworld

#copy files
COPY . .

RUN chgrp -R 0 /helloworld && \
    chmod -R g+rwX /helloworld && \
    chgrp -R 0 /app/helloworld && \
    chmod -R g+rwX /app/helloworld

# Define diretório HOME para o Maven
ENV HOME=/tmp

ENV MAVEN_OPTS="-Dmaven.repo.local=/tmp/.m2/repository"

RUN chmod +x entrypoint.sh
