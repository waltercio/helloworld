FROM alpine:latest

RUN apk add --update wget bash libc6-compat \
	&& apk add maven \
    && apk add curl \
    && mkdir -p /helloworld \
    && apk add vim 
	
COPY . /helloworld

WORKDIR /helloworld

RUN mvn install
RUN chmod +wrx entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]