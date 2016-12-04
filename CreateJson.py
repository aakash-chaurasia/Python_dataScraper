import json
import psycopg2

import loadToDb as parent
from DataAccessObjects.TagCount import TagCount
from DataAccessObjects.QuestionsAndTags import QuestionsAndTags
from DataAccessObjects.TagsOfTags import TagsOfTags
from DataAccessObjects.childName import childName

JsonOutputPath = "JSON"
JsonSuffix  = ".json"

def createJsonFiles(data, outputFile):
    outputFile = "{0}/{1}{2}".format(JsonOutputPath, outputFile, JsonSuffix)
    output = open(outputFile, "wb")
    print "Creating JSON file - '{0}'".format(outputFile)
    json.dump(data, output, encoding='Latin1')
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

def fetchQuestionWithTags(openConnection):
    cursor = openConnection.cursor()
    lis = []
    try:
        cursor.execute("Select row_number() over () as qid, t.* from (Select distinct _title, _tag from datasets where lower(_tag) like '%android%') as t")
        rows = cursor.fetchall()
        cursor.close()
        t2 = []
        for row in rows :
            if len(t2) == 4:
                lis.append(t2)
                t2 = []
            t = QuestionsAndTags(row[0], row[1].strip("\""), row[2].split(" ")[:-1])
            t1 = []
            t1.append(t.getQid())
            t1.append(t.getTitle())
            t1.append(t.getTags())
            t2.append(t1)
        createJsonFiles(lis, "QuestionToTags2")
    except Exception, e:
        print e
        openConnection.rollback()
        if (cursor):
            cursor.close()

def fetchQuestionAndTags(openConnection, res):
    cursor = openConnection.cursor()
    lis = []
    try:
        for r in res:
            cursor.execute("SELECT * FROM QUESTION_TO_TAGS WHERE ROW_NUMBER = {0}".format(str(r)))
            rows = cursor.fetchall()[0]
            t = QuestionsAndTags(rows[0], rows[1], rows[2].split(" ")[:-1])
            t1 = []
            t1.append(t.getQid())
            t1.append(t.getTitle())
            t1.append(t.getTags())
            lis.append(t1)
        cursor.close()
        return json.dumps(lis)
    except Exception, e:
        print e
        openConnection.rollback()
        if (cursor):
            cursor.close()


def fetchTagList(openConnection):
    cursor = openConnection.cursor()
    lis = []
    try:
        cursor.execute("SELECT tag,420 - row_number() over () * 10 FROM tag_count order by count desc limit 40")
        rows = cursor.fetchall()
        cursor.close()
        for row in rows:
            t = TagCount(row[0], row[1])
            lis.append(t)
        createJsonFiles(lis, "ListTags")
    except Exception, e:
        print e
        openConnection.rollback()
        if (cursor):
            cursor.close()

def fetchTagToQuestions(openConnection):
    cursor = openConnection.cursor()
    lis = []
    try:
        cursor.execute("SELECT tag FROM DISTINCTTAGS")
        rows = cursor.fetchall()
        cursor.execute("TRUNCATE TABLE TAG_TO_QUESTIONS")
        for row in rows:
            lis1 = []
            cursor.execute("SELECT ROW_NUMBER FROM QUESTION_TO_TAGS WHERE _TAG LIKE '%{0}%'".format(row[0]))
            rows1 = cursor.fetchall()
            for row1 in rows1:
                lis1.append(str(row1[0]))
            strlist = ' '.join(lis1)
            cursor.execute("INSERT INTO TAG_TO_QUESTIONS VALUES ('{0}', '{1}')".format(str(row[0]), strlist))
            openConnection.commit()
    except Exception, e:
        print e
        openConnection.rollback()
        if (cursor):
            cursor.close()


def fetchTagsOfTags(openConnection):
    cursor = openConnection.cursor()
    try:
        # cursor.execute("SELECT tag FROM distincttags")
        # tags = cursor.fetchall();
        # for tag in tags:
        s = set()
        lis1 = []
        cursor.execute("SELECT _questionids FROM TAG_TO_QUESTIONS WHERE _tag = '{0}'".format("android"))
        qids = set(cursor.fetchall()[0][0].split())
        cursor.execute("SELECT _tag FROM fquestions where _tag like '%{0}%' ORDER BY _reputation desc".format("android"))
        rows = cursor.fetchall()
        l = []
        for row in rows:
            if len(l) > 200:
                break
            l = l + row[0].split()
        s = set(l)
        for item in list(s) :
            if(len(lis1)) > 20:
                break
            cursor.execute("SELECT _questionids FROM TAG_TO_QUESTIONS WHERE _tag = '{0}'".format(item))
            qids1 = set(cursor.fetchall()[0][0].split())
            lis2 = list(qids & qids1)
            lis3 = []
            x = 0
            for li in lis2:
                if x > 5 :
                    break
                temp = childName(li)
                lis3.append(temp)
                x = x + 1
            child = TagsOfTags(item, lis3)
            lis1.append(child)
        mainTag = TagsOfTags("android", lis1)
        cursor.close()
        createJsonFiles(mainTag, "TagsOfTags")
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
        # fetchListOfTagCounts(con)
        fetchQuestionWithTags(con)
        # fetchTagToQuestions(con)
        # fetchTagList(con)
        # fetchTagsOfTags(con)
        if con:
            con.close()

    except Exception as detail:
        print "Something bad has happened!!! This is the error ==> ", detail
        if con:
            con.close()