#/bin/bash

echo "ingest binaries"
docker run --rm \
  -v ${PWD}/to_ingest:/data \
  --entrypoint arche-import-binary \
  acdhch/arche-ingest \
  /data ${TOPCOLID}/ ${ARCHE} ${ARCHE_USER} ${ARCHE_PASSWORD} --skip not_exist
