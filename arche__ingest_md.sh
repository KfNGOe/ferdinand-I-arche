#/bin/bash

echo "ingest metadata"
docker run --rm \
  -v ${PWD}:/data \
  --entrypoint arche-import-metadata \
  acdhch/arche-ingest \
  arche.ttl ${ARCHE} ${ARCHE_USER} ${ARCHE_PASSWORD}