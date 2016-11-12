class TagCount:
    tag = None
    count = None

    def __init__(self, tag="", count=0):
        self.tag = tag
        self.count = count

    def setTag(self, tag):
        self.tag = tag

    def getTag(self):
        return self.tag

    def setCount(self, count):
        self.count = count

    def getCount(self):
        return self.count

    def toString(self):
        result = "Tag: {0}, Count: {1}".format(self.tag, self.count)
        return result
