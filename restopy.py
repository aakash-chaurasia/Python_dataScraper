#!flask/bin/python
import json

import psycopg2
from flask import Flask

from CreateJson import fetchQuestionAndTags
from cross import crossdomain

app = Flask(__name__)
OpenConnection = None
def getOpenConnection(user='postgres', password='1234', dbname='DV'):
    return psycopg2.connect("dbname='" + dbname + "' user='" + user + "' host='localhost' password='" + password + "'")

@app.route('/')
@crossdomain("*")
def index():
    print 'Server Started'

@app.route('/checkTag/<string:QueryTag>', methods=['GET'])
@crossdomain("*")
def checkTag(QueryTag):
    cursor = OpenConnection.cursor()
    cursor.execute("SELECT count(1) FROM DISTINCTTAGS WHERE tag = '{0}'".format(QueryTag))
    rows = cursor.fetchall()
    print rows
    return json.dumps(rows[0][0])

@app.route('/questionToTags/<string:QueryTags>', methods=['GET'])
@crossdomain("*")
def getQuestionToTags(QueryTags):
    output = []
    cursor = OpenConnection.cursor()
    li = QueryTags.split(",")
    for item in li:
        cursor.execute("SELECT _QUESTIONIDS FROM TAG_TO_QUESTIONS WHERE _tag = '{0}'".format(item))
        row = cursor.fetchall()[0][0]
        cols = set(row.split(" "))
        output.append(cols)
    result = None
    for s in output:
        if result == None:
            result = s
        else :
            result = result & s
    return fetchQuestionAndTags(OpenConnection, list(result))

if __name__ == '__main__':
    global OpenConnection
    OpenConnection = getOpenConnection()
    app.run(debug=True, host='192.168.0.16')
    app.run(debug=True)