import json
import urllib.request
j= urllib.request.urlopen('https://en.wikipedia.org/w/api.php?action=query&meta=siteinfo&siprop=namespaces&format=json')
# raw_data = json.load(j.content.decode('utf-8'))
raw_data = json.loads(j.read().decode('utf-8'))
# raw=json.load(j)
#print(type(raw_data))
# print(type(raw))
# list=[]
for key,value in raw_data['query']['namespaces'].items():
    if len(value['*'])==0:
        continue
    name = value['*'].lower().replace(" ","_")+":"
    print(name)
