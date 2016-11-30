class TagsOfTags(dict):
    name = None
    children = []

    def __init__(self, name="", children=[]):
        dict.__init__(self, name=name, children=children)
        self.name = name
        self.children = children

    def setname(self, name):
        self.name = name

    def getname(self):
        return self.name

    def setchildren(self, children):
        self.children= children

    def getchildren(self):
        return self.size

    def toString(self):
        result = "text: {0}, size: {1}".format(self.text, ','.join(self.size))
        return result

    # def toJson(self):
    #     return self.__dict__
