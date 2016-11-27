from flask import Flask, render_template, redirect, url_for,request
from flask import make_response

from cross import crossdomain

app = Flask(__name__)

@app.route("/")
def home():
    return "hi"
@app.route("/index")

@app.route('/login', methods=['GET', 'POST'])
def login():
   message = None
   if request.method == 'GET':
        #datafromjs = request.form['mydata']
        #result = "return this" + datafromjs
        resp = make_response('{"response": hieee}')
        resp.headers['Content-Type'] = "application/json"
        return resp
        return render_template('login.html', message='')
if __name__ == "__main__":
    app.run(debug = True)
