from bs4 import BeautifulSoup
import requests
import re
from functools import reduce
import json
from result import Result

BASE_URL = "https://www.mos.ru/api"
STATIC_URL = "https://www.mos.ru/"

# HANDLERS

def get_afisha():
    url = BASE_URL + "/newsfeed/v4/frontend/json/ru/afisha"
    request = requests.get(url)

    if request.status_code == 200:
        model = AfishasModel(json.loads(request.text))
        return Result(result=model.as_string())
    else:
        return Result(error="Сервер не отвечает")

# MODELS


class AfishasModel:

    def __init__(self, json):
        self.items = []
        for j in json["items"]:
            self.items.append(AfishaModel(j))

    def as_string(self):
        r = ",".join(map(lambda x: str(x), self.items))
        return "[" + r + "]"


class AfishaModel:

    def __init__(self, json):
        print(json)
        self._id = json["id"]
        self.title = short_title(json["title"])
        self.text = clear_from_xml(json["text"])
        self.free = json["free"] == 1

        image = json["image"]["small"]
        self.image_url = STATIC_URL + image["src"]

    def as_json(self):
        r = """
        "id": {},
        "title": "{}",
        "text": "{}",
        "free": {},
        "img": "{}"
        """.format(self._id, self.title, self.text, str(self.free).lower(), self.image_url)
        return "{" + r + "}"

    def __str__(self):
        return self.as_json()


# HELPERS


def clear_from_xml(string):
    soup = BeautifulSoup(string, "html.parser")
    resulted_string = [p.get_text() for p in soup.find_all("p", text=True)][0]
    return resulted_string


def short_title(string):
    r = re.search("^«[^«]+»", string)
    if r:
        return r.group(0).replace("«", "").replace("»", "")
    else:
        return string
