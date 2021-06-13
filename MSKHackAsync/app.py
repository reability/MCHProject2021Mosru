from aiohttp import web
from aiohttp import WSMsgType
import random
import json


afishasId = [98016257, 98007257, 97981257, 97975257, 97933257, 97601257, 97539257, 97527257]
rooms = []


class WebSocket(web.View):
    async def get(self):
        ws = web.WebSocketResponse()

        await ws.prepare(self.request)
        await ws.send_str("pong")

        self.request.app['websockets'].append(ws)
        print("ws connection opened")

        async for msg in ws:
            if msg.type == WSMsgType.text:
                if msg.data == 'close':
                    await ws.close()
                else:
                    json_msg = json.loads(msg.data)

                    user = json_msg["userId"]
                    action = json_msg["action"]

                    if action == "new":
                        code = json_msg["code"]
                        new_room = Room(userId=user, code=code)
                        new_room.fill_afisha(afishasId)

                        rooms.append(new_room)
                    elif action == "join":
                        code = json_msg["code"]
                        for room in rooms:
                            if room.code == code:
                                room.join(user)
                                room.connect(ws)
                                await room.announce_start()
                            if room.owner == user:
                                await room.wsOwner.close()
                                rooms.remove(room)
                    elif "mark" in action:
                        code = json_msg["code"]
                        afisha = json_msg["afisha"]
                        value = json_msg["value"]
                        for room in rooms:
                            if room.code == code:
                                room.set_value(afisha, value)
                                break
                    elif "finish" in action:
                        code = json_msg["code"]
                        for room in rooms:
                            if room.code == code:
                                room.set_user_finished(user)
                                if room.is_all_finished():
                                    await room.announce_results()

            self.request.app['websockets'].remove(ws)
            print('ws connection closed')
            return ws


class Room:
    def __init__(self, userId, code):
        self.owner = userId
        self.users = []
        self.users.append(RoomUser(userId=userId, status="ready"))
        self.code = code

        self.wsOwner = None
        self.wsOther = None
        self.l = []

    def connect(self, ws):
        if self.wsOwner:
            self.wsOther = ws
        else:
            self.wsOwner = ws

    def fill_afisha(self, afishas):
        for afisha in afishas:
            model = {
                "id": afisha,
                "value1": 0,
                "value2": 0
            }
            self.l.append(model)

    async def announce_start(self):
        await self.wsOwner.send_str("start:" + "," + ",".join(map(lambda x: str(x), self.l)))
        await self.wsOther.send_str("start:" + "," + ",".join(map(lambda x: str(x), self.l)))

    async def announce_results(self):
        random.shuffle(self.l)
        result = ""
        for item in self.l:
            if item["value1"] == 1 and item["value2"] == 1:
                result = item["id"]
        await self.wsOwner.send_str("end:" + "," + str(result))
        await self.wsOther.send_str("end:" + "," + str(result))


    def set_value(self, afisha, value):
        for a in self.l:
            if a["id"] == afisha:
                if a["value1"] == 0:
                    a["value2"] = value
                else:
                    a["value1"] = value

    def join(self, userId):
        self.users.append(RoomUser(userId=userId, status="ready"))
        for user in self.users:
            user.status = "in progress"

    def set_user_finished(self, userId):
        for user in self.users:
            if user.userId == userId:
                user.set_finished()
                break

    def is_all_finished(self):
        for user in self.users:
            if not user.is_finished():
                return False
        else:
            return True


class RoomUser:
    def __init__(self, userId, status):
        self.userId = userId
        self.status = status

    def set_finished(self):
        self.status = "finished"

    def is_finished(self):
        return self.status == "finished"


if __name__ == "__main__":

    app = web.Application()

    app.router.add_route("GET", "/", WebSocket, name="ws")

    app['websockets'] = []
    web.run_app(app)