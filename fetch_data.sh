# bin/bash

rm -rf data/editions
rm -rf data/register
rm -rf ./ferdinand-I-data-main
rm main.zip
wget https://github.com/KfNGOe/ferdinand-I-data/archive/refs/heads/main.zip
unzip main
rm main.zip

mkdir -p ./data/editions
mkdir -p ./data/indices

mv ./ferdinand-I-data-main/data/dtabf_id/band_001 ./data/editions
mv ./ferdinand-I-data-main/data/register ./data/indices

rm -rf ./ferdinand-I-data-main

# mv ./schnitzler-briefe-data-main/data .
# rm -rf ./data/xslts
# rm main.zip
# rm -rf ./schnitzler-briefe-data-main

# echo "update imprint"
# ./dl_imprint.sh

# echo "delete schema reference"
# find ./data/editions/ -type f -name "*.xml"  -print0 | xargs -0 sed -i -e 's@xsi:schemaLocation="http://www.tei-c.org/ns/1.0 ../meta/asbwschema.xsd"@@g'

# echo "fixing entitiy ids"
# find ./data/indices/ -type f -name "*.xml"  -print0 | xargs -0 sed -i -e 's@<person xml:id="person__@<person xml:id="pmb@g'
