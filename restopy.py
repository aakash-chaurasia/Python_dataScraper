#!flask/bin/python
import json
import BaseHTTPServer, SimpleHTTPServer
import ssl
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
    result = set()
    index = len(output)
    while len(list(result)) < 16:
        flag = True
        for s in output[0:index]:
            if flag:
                result = s
            else :
                result = result & s
            flag = False
        index = index - 1
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
    if(questionId != 'null'):
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
    else:
        return json.dumps(0)

if __name__ == '__main__':
    global OpenConnection
    OpenConnection = getOpenConnection()
    app.run(debug=True, host='192.168.0.16', port=4443, threaded=True)
    # httpd = BaseHTTPServer.HTTPServer(('localhost', 4443), SimpleHTTPServer.SimpleHTTPRequestHandler)
    # httpd.socket = ssl.wrap_socket(httpd.socket, certfile='path/to/localhost.pem', server_side=True)
    # httpd.serve_forever()