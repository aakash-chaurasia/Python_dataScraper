class QuestionsAndTags(dict):
    qid = None
    title = ""
    tags = []

    def __init__(self, qid="", title="", tags = []):
        dict.__init__(self, qid=qid, title=title, tags=tags)
        self.qid = qid
        self.title = title
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

    def getTitle(self):
        return self.title

    def setTitle(self, title):
        dict.__init__(self, title=title)
        self.title = title

    def toString(self):
        result = "Question: {0}, Title: {2}, Tags: {1}".format(self.qid, self.tags, self.title)
        return result
