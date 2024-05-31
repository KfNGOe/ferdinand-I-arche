import glob
import os
import shutil
from tqdm import tqdm
from acdh_tei_pyutils.tei import TeiReader
from acdh_tei_pyutils.utils import extract_fulltext
from rdflib import Namespace, URIRef, RDF, Graph, Literal, XSD


TOP_COL_URI = URIRef("https://id.acdh.oeaw.ac.at/ferdinand-korrespondenz")
BAND_I_URI = URIRef(f"{TOP_COL_URI}/band-001")

g = Graph().parse("arche_seed_files/arche_constants.ttl")
g_repo_objects = Graph().parse("arche_seed_files/repo_objects_constants.ttl")

ACDH = Namespace("https://vocabs.acdh.oeaw.ac.at/schema#")
COLS = [ACDH["TopCollection"], ACDH["Collection"], ACDH["Resource"]]
COL_URIS = set()
ingest_dir = "to_ingest"

shutil.rmtree(ingest_dir, ignore_errors=True)
print("copying register files")
src_dir = os.path.join("data", "register")

files = os.listdir(src_dir)
shutil.copytree(src_dir, ingest_dir)
os.makedirs(ingest_dir, exist_ok=True)
for x in COLS:
    for s in g.subjects(None, x):
        COL_URIS.add(s)


print("enriching Collections with shared properties")
for x in COL_URIS:
    for p, o in g_repo_objects.predicate_objects():
        g.add((x, p, o))

files = sorted(glob.glob("./data/editions/band_001/A*.xml"))
print(f"generating metadata for {len(files)} TEIs")
for x in tqdm(files):
    doc = TeiReader(x)
    _, file_name = os.path.split(x)
    uri = URIRef(f"{TOP_COL_URI}/{file_name}")
    g.add((uri, RDF.type, ACDH["Resource"]))
    g.add(
        (
            uri,
            ACDH["hasCategory"],
            URIRef("https://vocabs.acdh.oeaw.ac.at/archecategory/text/tei"),
        )
    )
    g.add(
        (
            uri,
            ACDH["hasSchema"],
            Literal(
                "https://id.acdh.oeaw.ac.at/ferdinand-korrespondenz/basisformat_all_ferdinand.xml"
            ),
        )
    )
    try:
        has_title = doc.any_xpath(".//tei:titleStmt/tei:title[@type='sub'][1]/text()")[
            0
        ]
    except IndexError:
        has_title = f"missing title for {x}"
    description = False
    try:
        description = doc.any_xpath(".//tei:div[@n='2']")[0]
        description_text = extract_fulltext(description)
    except IndexError:
        pass
    if description is not None:
        g.add((uri, ACDH["hasDescription"], Literal(description_text, lang="de")))
    try:
        description = doc.any_xpath(".//tei:div[@n='3']")[0]
        description_text = extract_fulltext(description)
    except IndexError:
        pass
    if description is not None:
        g.add((uri, ACDH["hasDescription"], Literal(description_text, lang="en")))

    g.add((uri, ACDH["hasTitle"], Literal(has_title, lang="de")))
    g.add((uri, ACDH["isPartOf"], BAND_I_URI))
    g.add(
        (
            uri,
            ACDH["hasCategory"],
            URIRef("https://vocabs.acdh.oeaw.ac.at/archecategory/text/tei"),
        )
    )

    date_when = False
    try:
        date_when = doc.any_xpath(
            ".//tei:correspAction[@type='sent']/tei:date[@when]/@when"
        )[0]
    except IndexError:
        try:
            date_when = doc.any_xpath(
                ".//tei:correspAction[@type='sent']/tei:date[@notBefore]/@notBefore"
            )[0]
        except IndexError:
            print(f"missing date for {x}")
    if date_when:
        g.add(
            (uri, ACDH["hasCoverageStartDate"], Literal(date_when, datatype=XSD.date))
        )
    for p, o in g_repo_objects.predicate_objects():
        g.add((uri, p, o))

    doc.tree_to_file(os.path.join(ingest_dir, file_name))


print("add spatial coverage")
register_file = os.path.join("data", "register", "register_place.xml")
geonames_pattern = "https://sws.geonames.org/{}/"
doc = TeiReader(register_file)
nsmap = doc.nsmap

ids = set()
for x in doc.any_xpath(
    ".//tei:item[./tei:note[@type='place'] and ./tei:note[@type='geoname']]"
):
    geonames = x.xpath("./tei:note[@type='geoname']", namespaces=nsmap)[0].text
    if geonames is not None:
        geonames_uri = geonames_pattern.format(geonames)
        try:
            name = x.xpath(".//tei:placeName", namespaces=nsmap)[0].text
        except Exception as e:
            print(x, e)
            continue
        if (
            geonames in ids
        ):  # this is needed to avoid multiple titles for same geonames id
            continue
        else:
            ids.add(geonames)
            subj = URIRef(geonames_uri)
            g.add((subj, RDF.type, ACDH["Place"]))
            g.add((subj, ACDH["hasTitle"], Literal(name, lang="und")))
            for y in x.xpath("./tei:note[@type]/tei:p[@source]", namespaces=nsmap):
                doc_id = y.attrib["source"]
                doc_subj = URIRef(f"{TOP_COL_URI}/{doc_id}")
                g.add((doc_subj, ACDH["hasSpatialCoverage"], subj))
g.parse("arche_seed_files/other_things.ttl")
g.serialize("to_ingest/arche.ttl")

shutil.copy(
    "data/basisformat_all_ferdinand.xml",
    os.path.join(ingest_dir, "basisformat_all_ferdinand.xml"),
)

shutil.copy(
    "title-image.jpg",
    os.path.join(ingest_dir, "title-image.jpg"),
)
