#/bin/bash

## this does not work!

echo "ingest metadata"
rm -rf ${PWD}/fc_out && mkdir ${PWD}/fc_out
docker run \
  --rm \
  -v ${PWD}/to_ingest:/data \
  acdhch/arche-filechecker vendor/bin/arche-import-metadata arche.ttl ${ARCHE}/api ${ARCHE_USER} ${ARCHE_PW}
