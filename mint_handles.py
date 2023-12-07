import os
import glob
import json
from acdh_handle_pyutils.client import HandleClient
from rdflib import Namespace, URIRef, Graph, Literal

arche_ns = Namespace("https://vocabs.acdh.oeaw.ac.at/schema#")

HANDLE_CACHE = "handles.json"
HANDLE_USERNAME = os.environ.get("HANDLE_USERNAME")
HANDLE_PASSWORD = os.environ.get("HANDLE_PASSWORD")
cl = HandleClient(HANDLE_USERNAME, HANDLE_PASSWORD)


with open(HANDLE_CACHE, "r") as f:
    loaded_data = json.load(f)

files = glob.glob("to_ingest/*.xml", recursive=True)

data = {}
for x in files:
    _, tail = os.path.split(x)
    if tail[0] == "A" or tail.startswith("register"):
        uri = f"https://id.acdh.oeaw.ac.at/ferdinand-korrespondenz/{tail}"
        try:
            handle = loaded_data[uri]
            data[uri] = handle
        except KeyError:
            handle = cl.register_handle(uri, full_url=True)
            data[uri] = handle
            print(handle)
    else:
        continue

with open(HANDLE_CACHE, "w") as f:
    json.dump(data, f)

with open(HANDLE_CACHE, "r") as file:
    data = json.load(file)

g = Graph().parse("arche.ttl")
for key, value in data.items():
    sub = URIRef(key)
    g.add((sub, arche_ns["hasPid"], Literal(value)))
g.serialize("arche.ttl")
