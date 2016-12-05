class quesans(dict):
    type = None
    title = None
    text = None
    code = None

    def __init__(self, type="", title="", text="", code=""):
        dict.__init__(self, type=type, title=title, text=text, code=code)
        self.type = type
        self.title = title
        self.text = text
        self.code = code