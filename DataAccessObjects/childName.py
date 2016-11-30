class childName(dict):
    name = None

    def __init__(self, name=""):
        dict.__init__(self, name=name)
        self.name = name

    def setname(self, name):
        self.name = name

    def getname(self):
        return self.name

    def toString(self):
        result = "text: {0}".format(self.name)
        return result

    # def toJson(self):
    #     return self.__dict__
