FROM eclipse-temurin:17-jdk-alpine

RUN apk add --update wget bash libc6-compat \
	&& apk add maven \
    && apk add curl \
    && mkdir -p /helloworld \
    && apk add vim 
	
WORKDIR /helloworld

# Do NOT copy everything
COPY pom.xml .
COPY src ./src
COPY entrypoint.sh .

RUN mkdir -p /helloworld/target && \
    chgrp -R 0 /helloworld && \
    chmod -R g+rwX /helloworld

ENV MAVEN_OPTS="-Dmaven.repo.local=/tmp/.m2/repository"

RUN chmod +x entrypoint.sh
