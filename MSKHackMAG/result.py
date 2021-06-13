
class Result:

    def __init__(self, result="", error="", ):
        self.resut = result
        self.error = error

    def as_response(self):
        if self.resut:
            return "{" + """
            "result": {},
            "errorMessage": ""
            """.format(self.resut, self.error) + "}", 200
        else:
            return "{" + """
            "result": "",
            "errorMessage": {}
            """.format(self.resut, self.error) + "}", 500

    @staticmethod
    def void_success():
        return Result(result="{}"), 200
