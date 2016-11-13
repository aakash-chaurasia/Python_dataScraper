class QuestionsAndTags(dict):
    qid = None
    tags = []

    def __init__(self, qid="", tags = []):
        dict.__init__(self, qid=qid, tags=tags)
        self.qid = qid
        self.tags = tags

    def setTags(self, tags):
        dict.__init__(self, tags=tags)
        self.tags = tags

    def getTags(self):
        return self.tags

    def setQid(self, qid):
        dict.__init__(self, qid=qid)
        self.qid = qid

    def getQid(self):
        return self.qid

    def toString(self):
        result = "Question: {0}, Tags: {1}".format(self.qid, self.tags)
        return result
