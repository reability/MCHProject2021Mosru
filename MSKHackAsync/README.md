# MSKHackAsync (Асинхронный сервис для парной рекомендации)

Микросервис для фичи парного подбора приложения. Технологический стек - Digital Ocean + linux(Ubuntu 19) + Python3 + Aiohttp + Websockets

## API

GET - / - Подключение к сокету

Сокет принимает сообщения в формате JSON

```bash
{
    "userId": Integer*
    "action": enum: String*
    "code": String*
    "afisha": Integer
    "value": Integer
}


Action:
"new" - Для открытия новой комнаты. Требует code
"join" - Для подключения к комнате. Требует code
"mark" - Для оценки афиши. Требует code, afisha, value
"finish" - Для завершения подборки. Требует code
```
## Запуск

Требуется python3 и pip3

```bash
pip3 install aiohttp
pip3 install requests
python3 app.py
```
