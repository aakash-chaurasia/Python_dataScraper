#!flask/bin/python
import json

import psycopg2
from flask import Flask

from CreateJson import fetchQuestionAndTags, tagsOfTags
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
    #print rows
    return json.dumps(rows[0][0])

@app.route('/questionToTags/', methods=['GET'])
@crossdomain("*")
def getQuestionToTags():
    output = []
    cursor = OpenConnection.cursor()
    f = open("CSV/secondInput.txt").readline()
    li = f.split()
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

@app.route('/writeAfterFirst/<string:QueryTags>', methods=['GET'])
@crossdomain("*")
def postProcessFirst(QueryTags):
    f = open("CSV/secondInput.txt", "w")
    f.write(QueryTags)
    return json.dumps(1)

@app.route('/writeAfterSecond/<string:QueryTags>', methods=['GET'])
@crossdomain("*")
def postProcessSecond(QueryTags):
    f = open("CSV/thirdInput.txt", "w")
    f.write(QueryTags)
    return json.dumps(1)


@app.route('/tagsOfTags/', methods=['GET'])
@crossdomain("*")
def fetchTagsFromQuery():
    QueryTag = open("CSV/thirdInput.txt").readline()
    return tagsOfTags(OpenConnection, QueryTag)

@app.route('/onLoadFourth/<string:questionId>', methods=['GET'])
@crossdomain("*")
def preProcessFourth(questionId):
    output = []
    cursor = OpenConnection.cursor()
    cursor.execute("SELECT _title, _text, _code, _tag FROM FQUESTIONS WHERE row_number = {0}".format(questionId))
    row = cursor.fetchall()[0]
    output.append(row)
    cursor.execute("SELECT _title, _text, _code, _tag FROM FACCEPTEDANSWERS WHERE fk_row_num = {0}".format(questionId))
    for row in cursor.fetchall():
        output.append(row)
    cursor.execute("SELECT _title, _text, _code, _tag FROM FANSWERS WHERE fk_row_num = {0}".format(questionId))
    for row in cursor.fetchall():
        output.append(row)
    return json.dumps(output)

if __name__ == '__main__':
    global OpenConnection
    OpenConnection = getOpenConnection()
    app.run(debug=True, host='192.168.0.16', threaded=True)