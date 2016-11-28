#!flask/bin/python
import json

import psycopg2
from flask import Flask
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

if __name__ == '__main__':
    global OpenConnection
    OpenConnection = getOpenConnection()
    app.run(debug=True)