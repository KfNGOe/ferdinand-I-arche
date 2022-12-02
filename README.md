# ferdinand-I-arche
Workflow repo for ARCHE ingest

## what it does

* installs needed libraries e.g. saxon and acdh-tei-pyutils
* copies (some) data from [ferdinand-I-data]() into the current repo
* runs some XSLTs (via `ant`) to generate ARCHE-RDF
* ingests Data and Metadata into ARCHE via GitHub Actions

## Metadaten Kuratierung/Generierung

ARCHE-Metadaten werden aus 
* den einzelnen XML/TEIs (`./data/editions/*/*.xml` sowie `./data/indices/*.xml`'),
* `./data/meta/arche_constants.rdf`
* via XSL Transformation mittels `xslt/arche.xsl` generiert und in `./arche.rdf` abgelegt. 

An diesen Stellen können die Metadaten entsprechend geändert/modifiziert werden. V.a. statische Teile wie `acdh:TopCollection` Metadatan werden i.d.R. in `arche_constants.rdf` bearbeitet. 

Die eigentliche XSLT-Transformation, wie auch das generieren von HANDLE-PIDS (`mint_handles.py`) sowie der ARCHE-Ingest erfolgt über GitHub-Action
