# ferdinand-I-arche
Workflow repo for ARCHE ingest

## what it does

* installs needed libraries e.g. acdh-tei-pyutils
* copies (some) data from [ferdinand-I-data]() into the current repo
* generates ARCHE-MD from TEI/XMLs
* ingests Data and Metadata into ARCHE via GitHub Actions

## Metadaten Kuratierung/Generierung

ARCHE-Metadaten werden aus 
* den einzelnen XML/TEIs (`./data/editions/*/*.xml` sowie `./data/indices/*.xml`')
* aus `arche_seed_files/arche_constants.ttl` und `arche_seed_files/repo_objects_constants.ttl`
* via python script `make_arche_rdf.py` und `mint_hanles.py` generiert und in `./arche.rdf` abgelegt. 

An diesen Stellen können die Metadaten entsprechend geändert/modifiziert werden. V.a. statische Teile wie `acdh:TopCollection` Metadaten werden i.d.R. in `arche_seed_files/arche_constants.ttlf` bearbeitet. 

Das alles, wie auch das Generieren von HANDLE-PIDS (`mint_handles.py`) sowie der ARCHE-Ingest erfolgt über GitHub-Action
