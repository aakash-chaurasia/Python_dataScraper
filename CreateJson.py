import json
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
    createJsonFiles(lis, "DistinctTags")
    tag1 = TagCount()
    tag1.setTag("Java")
    tag1.setCount(10)
    tag2 = TagCount("Python")
    print tag1.toString()
    print tag2.toString()

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