directoryToWriteReportsInto="fc_out"

echo "run ${directoryToWriteReportsInto}"
rm -rf ${directoryToWriteReportsInto}
mkdir -p ${directoryToWriteReportsInto}
vendor/bin/arche-filechecker --csv --html to_ingest ${directoryToWriteReportsInto}