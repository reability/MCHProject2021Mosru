import sqlite3
from flask import g
from result import Result

DATABASE = "database.db"


def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        return sqlite3.connect(DATABASE)
    return db


def write_like(user, afisha, value):
    conn = get_db()
    cur = conn.cursor()

    script = """
    INSERT INTO likes (userId, afishaId, VALUE) VALUES (
    {user}, {afisha}, {value}
    );
    """.format(user=user, afisha=afisha, value=value)

    r = cur.execute(script)
    conn.commit()

    if r:
        return Result.void_success()
    else:
        return Result(error="Не удалось записать в базу")

def calculate_recomendation(userId, afishaId):
    c = get_db().cursor()
    c.execute(f"SELECT * FROM likes WHERE userId={userId} AND NOT afishaId={afishaId}")
    userLikes = c.fetchall()

    c.execute(f'SELECT * FROM likes WHERE afishaId={afishaId} AND NOT userId={userId}')
    rows = c.fetchall()

    final_value = 0

    for row in rows:
        anotherUserId = row[0]
        anotherUserValue = row[1]
        c.execute(f"SELECT * FROM likes WHERE userId={anotherUserId}")
        likes_rows = c.fetchall()

        sim = 0
        total_new_for_user = 0

        for like_row in likes_rows:
            cuurent_afisha_id = like_row[1]

            founded = None
            for user_like in userLikes:
                if cuurent_afisha_id == user_like[1]:
                    founded = user_like[2]
                    break
            if founded:
                if founded * likes_rows[2] > 0:
                    sim += 1
                else:
                    sim -= 1
            else:
                total_new_for_user += 1

        new_for_another_user = 0
        for user_like in userLikes:
            cuurent_afisha_id = user_like[1]
            founded = None
            for like_row in likes_rows:
                if like_row[1] == cuurent_afisha_id:
                    founded = like_row[2]
                    break
            if founded:
                pass
            else:
                new_for_another_user += 1

        if total_new_for_user == 0 and new_for_another_user == 0:
            sim_ratio = 1.0
        else:
            sim_ratio = float(sim) / float((total_new_for_user + new_for_another_user))
        final_value += sim_ratio * anotherUserValue
    return final_value



def read_all_likes():
    cur = get_db().cursor()

    script = 'SELECT * FROM likes'
    cur.execute(script)

    result = cur.fetchall()
    return result

def initiate_db():
    scrypt = """
    CREATE TABLE likes (
    userId INTEGER,
    afishaId INTEGER,
    VALUE INTEGER
    );
    """
    conn = sqlite3.connect(DATABASE)
    cur = conn.cursor()
    cur.execute(scrypt)
    conn.commit()


if __name__ == "__main__":
    initiate_db()
