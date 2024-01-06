# directoryToWriteReportsInto="fc_out"

# echo "run ${directoryToWriteReportsInto}"
# rm -rf ${directoryToWriteReportsInto}
# mkdir -p ${directoryToWriteReportsInto}
# vendor/bin/arche-filechecker --csv --html to_ingest ${directoryToWriteReportsInto}


directoryToWriteReportsInto="fc_out"

echo "run ${directoryToWriteReportsInto}"
rm -rf ${directoryToWriteReportsInto}
mkdir -p ${directoryToWriteReportsInto}
docker run --rm -v `pwd`/${directoryToWriteReportsInto}:/reports -v `pwd`/to_ingest:/data --entrypoint /opt/filechecker/bin/arche-filechecker acdhch/arche-filechecker --csv --html /data /reports