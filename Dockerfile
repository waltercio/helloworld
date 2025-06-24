FROM alpine:latest

RUN apk add --update wget bash libc6-compat \
	&& apk add maven \
    && apk add curl \
    && mkdir -p /helloworld \
    && apk add vim 
	
WORKDIR /helloworld

# Copia os arquivos da aplicação
COPY . .

# Ajusta permissões para permitir escrita por qualquer usuário do grupo 0 (OpenShift roda como random UID no grupo 0)
RUN mkdir -p /helloworld/target/classes && \
    chgrp -R 0 /helloworld && \
    chmod -R g+rwX /helloworld

# Define diretório HOME para o Maven
ENV HOME=/tmp

# Executa o build do Maven usando repositório local temporário
RUN mvn -Dmaven.repo.local=/tmp/.m2/repository clean install

# Permissão para o script de entrada
RUN chmod +x entrypoint.sh

# Entrypoint do container
ENTRYPOINT ["./entrypoint.sh"]