import os
import glob
import json
from acdh_handle_pyutils.client import HandleClient

HANDLE_USERNAME = os.environ.get("HANDLE_USERNAME")
HANDLE_PASSWORD = os.environ.get("HANDLE_PASSWORD")
cl = HandleClient(HANDLE_USERNAME, HANDLE_PASSWORD)


with open("handles.json", 'r') as f:
    loaded_data = json.load(f)

files = glob.glob('data/**/*.xml', recursive=True)
data = {}
for x in files:
    _, tail = os.path.split(x)
    if tail[0] == 'A' or tail.startswith('register'):
        uri = f"https://ferdinand-korrespondenz.acdh.oeaw.ac.at/{tail}"
        try:
            handle = loaded_data[uri]
            data[uri] = handle
        except KeyError:
            handle = cl.register_handle(uri, full_url=True)
            data[uri] = handle
            print(handle)
    else:
        continue

with open("handles.json", 'w') as f:
    json.dump(data, f)

