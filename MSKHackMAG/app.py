from flask import Flask, request
from afisha import get_afisha
from analytic import read_all_likes, write_like
from api import *
app = Flask(__name__)


@app.route("/feed", methods=["GET"])
def hello_world():
    result = get_afisha()
    return result.as_response()


@app.route("/feed/<userId>", methods=["GET"])
def get_recommendation_feed(userId):
    result = get_recomendation_feed(int(userId))

    return result.as_response()


@app.route("/stats", methods=["GET"])
def get_all_stats():
    result = read_all_likes()
    print(result)
    return result


@app.route("/stats", methods=["POST"])
def post_a_stat():
    data = request.get_json()
    result = write_like(data["userId"], data["afishaId"], data["value"])
    return result


app.run()