# bin/bash

rm -rf data/editions
rm -rf data/register
rm -rf ./ferdinand-I-data-main
wget https://github.com/KfNGOe/ferdinand-I-data/archive/refs/heads/main.zip
unzip main
rm main.zip

mkdir -p ./data/editions
mkdir -p ./data/

mv ./ferdinand-I-data-main/data/dtabf_id/band_001 ./data/editions
mv ./ferdinand-I-data-main/data/register ./data
mv ./ferdinand-I-data-main/src/tei2dtabf/schema/basisformat_all_ferdinand.rng ./data

rm -rf ./ferdinand-I-data-main
