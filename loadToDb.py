import psycopg2
import os
import sys
import datetime

DIRECTORY = "datasets"
TABLE_NAME = "DATASETS"
CURRENT_PATH = os.getcwd()
def getOpenConnection(user='postgres', password='1234', dbname='DV'):
    return psycopg2.connect("dbname='" + dbname + "' user='" + user + "' host='localhost' password='" + password + "'")

def loadRecursively(OpenConnection):
    cursor = OpenConnection.cursor()
    for filename in os.listdir(DIRECTORY):
        try:
            count = 0
            file = CURRENT_PATH+"\\"+DIRECTORY+"\\"+filename
            print file
            f = open(file)
            print f
            count1 = 0
            for line in f:
                if count > 0:
                    line = line.replace("'","''")
                    cols = line.split(",")
                    vals = "','".join(cols)
                    vals = "'{0}'".format(vals)
                    vals = vals.replace(",'\"\"',", ",'',")
                    try:
                        cursor.execute("INSERT INTO DATASETS VALUES ({0})".format(vals))
                        OpenConnection.commit()
                    except psycopg2.DatabaseError, e:
                        print count
                        print vals
                        print e
                        count1 += 1
                        OpenConnection.rollback()
                count += 1
            print "error count " + str(count1)
            #cursor.execute("COPY {0} FROM '{1}' DELIMITER ',' CSV HEADER;".format(TABLE_NAME, file))
        except psycopg2.DatabaseError, e:
            if OpenConnection:
                OpenConnection.rollback()
            print 'Error %s' % e
            sys.exit(1)
    if cursor:
        cursor.close()
if __name__ == '__main__':
    try:
        # Getting connection to the database
        print "Getting connection from the DV database"
        con = getOpenConnection();
        con.set_client_encoding('Latin1')
        # Loading Started
        loadRecursively(con)

        if con:
            con.close()

    except Exception as detail:
        print "Something bad has happened!!! This is the error ==> ", detail
