from afisha import get_afisha
from analytic import write_like, calculate_recomendation
from result import Result
import json


def get_feed():
    r = get_afisha()
    return r


def send_like(data):
    userId = data["userId"]
    afishaId = data["afishaId"]

    result = write_like(userId, afishaId, 1)
    return result


def send_likes(data):
    userId = data["userId"]
    stats = data["stats"]
    for stat in stats:
        afishaId = stat["id"]
        like = stat["value"]
        write_like(userId, afishaId, like)
    return Result.void_success()


def get_recomendation_feed(userId):
    afishas = json.loads(get_feed().resut)
    values = []
    for afisha in afishas:
        value = calculate_recomendation(userId, afisha["id"])
        values.append((value, afisha))

    values.sort(key=lambda x: x[0], reverse=True)
    resulted_feed = list(map(lambda x: x[1], values))
    print(resulted_feed)

    return Result(result=json.dumps(resulted_feed))

