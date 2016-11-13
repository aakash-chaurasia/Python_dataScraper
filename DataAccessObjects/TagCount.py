class TagCount(dict):
    Tag = None
    count = None

    def __init__(self, Tag="", count=0):
        dict.__init__(self, Tag=Tag, count=count)
        self.Tag = Tag
        self.count = count

    def setTag(self, Tag):
        dict.__init__(self, Tag=Tag)
        self.Tag = Tag

    def getTag(self):
        return self.Tag

    def setCount(self, count):
        dict.__init__(self, count=count)
        self.count = count

    def getCount(self):
        return self.count

    def toString(self):
        result = "Tag: {0}, Count: {1}".format(self.Tag, self.count)
        return result

    # def toJson(self):
    #     return self.__dict__
