import json
from collections import OrderedDict

import loadToDb as parent
from DataAccessObjects.TagCount import TagCount

JsonOutputPath = "JSON"
JsonSuffix  = ".json"

def createJsonFiles(data, outputFile):
    outputFile = "{0}/{1}{2}".format(JsonOutputPath, outputFile, JsonSuffix)
    output = open(outputFile, "wb")
    json.dump(data, output)

def fetchDistinctTags(openConnection) :
    lis = [1, "aakash", "akriti", "manoj", "bhakti"]
    tag1 = TagCount()
    tag1.setTag("Java")
    tag1.setCount(10)
    tag2 = TagCount("Python")
    lis.append(tag1)
    lis.append(tag2)
    createJsonFiles(lis, "DistinctTags")
    print json.dumps(lis, indent=4, sort_keys=True)

if __name__ == '__main__':
    try:
        # Getting connection to the database
        print "Getting connection from the DV database"
        con = parent.getOpenConnection()
        con.set_client_encoding('Latin1')
        fetchDistinctTags(con)
        if con:
            con.close()

    except Exception as detail:
        print "Something bad has happened!!! This is the error ==> ", detail
        if con:
            con.close()