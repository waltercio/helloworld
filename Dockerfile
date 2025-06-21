FROM alpine:latest

RUN apk add --update wget bash libc6-compat \
	&& apk add maven \
    && apk add curl \
    && mkdir -p /helloworld \
    && apk add vim 
	
RUN mkdir /tmp

RUN chmod 777 /tmp

COPY . /helloworld

WORKDIR /helloworld

ENV HOME /tmp

RUN mvn install
RUN chmod +wrx entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]