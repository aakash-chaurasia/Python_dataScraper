import json
import psycopg2

import loadToDb as parent
from DataAccessObjects.TagCount import TagCount

JsonOutputPath = "JSON"
JsonSuffix  = ".json"

def createJsonFiles(data, outputFile):
    outputFile = "{0}/{1}{2}".format(JsonOutputPath, outputFile, JsonSuffix)
    output = open(outputFile, "wb")
    json.dump(data, output, indent=4, sort_keys=True)

def fetchDistinctTags(openConnection) :
    cursor = openConnection.cursor()
    lis = []
    try:
        cursor.execute("SELECT DISTINCT tag FROM TAGS")
        rows = cursor.fetchall()
    except psycopg2.DatabaseError, e:
        print e
        openConnection.rollback()
    for row in rows :
        lis.append(row[0])
    createJsonFiles(lis, "DistinctTags")

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