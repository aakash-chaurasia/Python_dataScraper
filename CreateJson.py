import json
import psycopg2

import loadToDb as parent
from DataAccessObjects.TagCount import TagCount

JsonOutputPath = "JSON"
JsonSuffix  = ".json"

def createJsonFiles(data, outputFile):
    outputFile = "{0}/{1}{2}".format(JsonOutputPath, outputFile, JsonSuffix)
    output = open(outputFile, "wb")
    print "Creating JSON file - '{0}'".format(outputFile)
    json.dump(data, output, indent=4, sort_keys=True)
    print "'{0}' JSON file created.".format(outputFile)

def fetchDistinctTags(openConnection) :
    cursor = openConnection.cursor()
    lis = []
    try:
        cursor.execute("SELECT DISTINCT tag FROM TAGS")
        rows = cursor.fetchall()
        cursor.close()
        for row in rows:
            lis.append(row[0])
        createJsonFiles(lis, "DistinctTags")
    except Exception, e:
        print e
        openConnection.rollback()
        if(cursor):
            cursor.close()



def fetchListOfTagCounts(openConnection):
    cursor = openConnection.cursor()
    lis = []
    try:
        cursor.execute("SELECT tag, count(1) FROM TAGS GROUP BY tag ORDER BY 2 DESC")
        rows = cursor.fetchall()
        cursor.close()
        for row in rows:
            t = TagCount(row[0], row[1])
            lis.append(t)
        createJsonFiles(lis, "TagsCount")
    except Exception, e:
        print e
        openConnection.rollback()
        if (cursor):
            cursor.close()

if __name__ == '__main__':
    try:
        # Getting connection to the database
        print "Getting connection from the DV database"
        con = parent.getOpenConnection()
        con.set_client_encoding('Latin1')
        # fetchDistinctTags(con)
        fetchListOfTagCounts(con)
        if con:
            con.close()

    except Exception as detail:
        print "Something bad has happened!!! This is the error ==> ", detail
        if con:
            con.close()