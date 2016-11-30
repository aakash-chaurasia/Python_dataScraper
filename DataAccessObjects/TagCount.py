class TagCount(dict):
    text = None
    size = None

    def __init__(self, text="", size=0):
        dict.__init__(self, text=text, size=size)
        self.text = text
        self.size = size

    def settext(self, text):
        dict.__init__(self, text=text)
        self.text = text

    def gettext(self):
        return self.text

    def setsize(self, size):
        dict.__init__(self, size=size)
        self.size = size

    def getsize(self):
        return self.size

    def toString(self):
        result = "text: {0}, size: {1}".format(self.text, self.size)
        return result

    # def toJson(self):
    #     return self.__dict__
