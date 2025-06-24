#!/bin/sh
set -e

echo "[INFO] Running with UID: $(id -u)"

# Remova o target e classes criadas por usuários anteriores (caso existam)
rm -rf target/

# Rode o Maven (recria os arquivos com o UID do pod atual)
mvn clean spring-boot:run