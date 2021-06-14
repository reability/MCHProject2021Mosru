# MCHProject2021Mosru

![alt text](https://github.com/reability/MCHProject2021Mosru/blob/main/src/headers.png?raw=true)

Проект команды Dungeon masters специально для  MOSCOW CITY HACK 2021 (https://moscityhack.innoagency.ru/)

Трек 4 - Планирование досуговых мероприятий в приложении «Моя Москва»

@ha47ze - Ванурин Алексей (Генеральный директор продуктовой аналитики и младший back-end разработчик команды "Dungeon masters")

@Kelbinary - Максим Савченко (Teamlead iOS команды и СТЕ комады "Dungeon masters")

@lynnica - Александра Ставская (Арт-директор и идейный вдохновитель комады "Dungeon masters")

## Название продукта


![alt text](https://github.com/reability/MCHProject2021Mosru/blob/main/src/appImg.png?raw=true)

### Персонально для тебя и твоих друзей

Рекоммендательная система подберет мероприятия под твой вкус

<img src="https://github.com/reability/MCHProject2021Mosru/blob/main/src/reco.gif" width="250">

Ищи только то, что нужно

<img src="https://github.com/reability/MCHProject2021Mosru/blob/main/src/filters.gif" width="250">

Выбирай мероприятия для совместного похода с другом, девушкой или мамой



### UI/UX

Тут про юикс

### Масштабируемость и интеграция

Бекенд реализован на микросвервисном подходе. Сервис реализован как отдельный набор из двух приложений, которые поддерживаются и деплоятся независимо друг от друга и обзаются с клиентом и основной апи mos.ru только посредством http

Для работы сервиса достаточно запусть его на отдельных серверах

## MSKHackApp (IOS App)

Мобильный клиент сервиса

Технологический стек: Swift, Xcode, Viper + DataSource, Storyboard.
Используемые библиотеки: Starscream (веб-сокеты), SnapKit(верстка экранов), Kingfisher (ассинхронная загрузка картинок), Koloda (тиндер-like карточки), PullUp (Собственноручно написан). 
В качестве архитектуры была выбрана архитектура VIPER. Ее преимущество в том, что каждая из сущностей предоставляет возможность контролировать более детально, ту или иную, логику (верстка, бизнес-логика). В дальнейшем бы это позволило покрыть 99% unit(ui)-тестами проект, чтобы избежать багов. Также VIPER предоставляет отличное разделение абстракций. 
### Запуск

pod instal

## MSKHackMAG (Mobile API Gateway)

Основной бекенд приложение. Отвечает за работу с АПИ mos.ru. Технологический стек - Digital Ocean + linux(Ubuntu 19) + Python3 + Flask + sqlite3. В качестве архитектуры была выброана MVC (Model View Controller)

Сервер крутится на http://157.230.221.235:5000/ (Digital Ocean)

### View

Все запросы возвращают Result с требуемым объектом при успехе. При ошибке сервер возвращает 500 ошибку и текстовое описание проблемы в Result

GET - /feed - Получение списка мероприятий

GET - /feed/{userId} - Получение персональной ленты для пользователя userId 

POST - /stats - Отправка данных по калибровке

### Model

Afisha

```bash
{
    "id": Integer,   # id афишы на базе mos.ru
    "title": String  # Короткое оглавление меропрития
    "text": String   # Описание мероприятия
    "free": Bool     # Бесплатное ли
    "img": String    # Ссылка на картинку под мобильное приложение
} 
```

Like

```bash
{
    "id": Integer     # id афиши
    "userId": Integer # id пользователя
    "value": Integer  # Оценка пользователя 1 или -1
} 
```

Result

```bash
{
    "result": Object       # Результат выполнения запроса если код 200
    "errorMessage": String # Текстовое описание ошибки если код 500
}
```

### Запуск

Требуется python3 и pip3

```bash
pip3 install flask
pip3 install requests
pip3 install bs4
python3 app.py
```

## MSKHackAsync (Асинхронный сервис для парной рекомендации)

Микросервис для фичи парного подбора приложения. Технологический стек - Digital Ocean + linux(Ubuntu 19) + Python3 + Aiohttp + Websockets

### API

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

### Запуск

Требуется python3 и pip3

```bash
pip3 install aiohttp
pip3 install requests
python3 app.py
```









