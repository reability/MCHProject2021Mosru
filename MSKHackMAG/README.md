# MSKHackMAG (Mobile API Gateway)

Основной бекенд приложение. Отвечает за работу с АПИ mos.ru. Технологический стек - Digital Ocean + linux(Ubuntu 19) + Python3 + Flask + sqlite3. В качестве архитектуры была выброана MVC (Model View Controller)

Сервер крутится на http://157.230.221.235:5000/ (Digital Ocean)

## View

Все запросы возвращают Result с требуемым объектом при успехе. При ошибке сервер возвращает 500 ошибку и текстовое описание проблемы в Result

GET - /feed - Получение списка мероприятий

GET - /feed/{userId} - Получение персональной ленты для пользователя userId 

POST - /stats - Отправка данных по калибровке

## Model

Afisha

```
{
    "id": Integer,   # id афишы на базе mos.ru
    "title": String  # Короткое оглавление меропрития
    "text": String   # Описание мероприятия
    "free": Bool     # Бесплатное ли
    "img": String    # Ссылка на картинку под мобильное приложение
} 
```

Like

```
{
    "id": Integer     # id афиши
    "userId": Integer # id пользователя
    "value": Integer  # Оценка пользователя 1 или -1
} 
```

Result

```
{
    "result": Object       # Результат выполнения запроса если код 200
    "errorMessage": String # Текстовое описание ошибки если код 500
}
```

## Запуск

Требуется python3 и pip3

```bash
pip3 install flask
pip3 install requests
pip3 install bs4
python3 app.py
```
