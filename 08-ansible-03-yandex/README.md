# Домашнее задание к занятию 3 «Использование Ansible»

## Подготовка к выполнению

1. Подготовьте в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.
2. Репозиторий LightHouse находится [по ссылке](https://github.com/VKCOM/lighthouse).

## Основная часть

1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse.
2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.
3. Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.
4. Подготовьте свой inventory-файл `prod.yml`.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.

## Решение

## Описание плейбука

Этот плейбук выполняет установку и настройку ClickHouse и Vector на соответствующих хостах. Он скачивает необходимые пакеты, устанавливает их, настраивает конфигурационные файлы и управляет службами.

## Установка и настройка ClickHouse

### Параметры 
*hosts*: clickhouse </br>
*become*: true

### Хэндлеры 
Start clickhouse service </br>
Перезапускает службу ClickHouse </br>
Теги: *clickhouse, start service*

### Задачи 
* Get clickhouse distrib </br>
Скачивает дистрибутивы ClickHouse для архитектуры AMD64 </br>
Теги: *clickhouse, distr*

* Update apt cache </br>
Обновляет кэш APT
Теги: *update*

* Install clickhouse packages using dpkg  </br>
Устанавливает пакеты ClickHouse с использованием dpkg </br>
Теги: *clickhouse, install* </br>
Notify: *Start clickhouse service*

* Flush handlers </br>
Выполняет все отложенные хэндлеры </br>
Теги: *clickhouse, start service*

* Wait for clickhouse-server to be ready </br>
Ожидает, пока сервер ClickHouse станет доступен на порту 9000 </br>
Теги: *clickhouse, wait*

* Create database </br>
Создает базу данных logs в ClickHouse </br>
Теги: *clickhouse, db*

## Установка и настройка Vector 

### Параметры 
*hosts*: vector </br>
*become*: true

### Хэндлеры 
Start vector service </br>
Перезапускает службу Vector </br>
Теги: *vector, restartservice*

### Задачи 
* Get vector distrib </br>
Скачивает дистрибутив Vector для архитектуры AMD64 </br>
Теги: *vector, distr*

* Update apt cache </br>
Обновляет кэш APT
Теги: *update*

* Install vector </br>
Устанавливает пакет Vector с использованием dpkg </br>
Теги: *vector, install*

* Deploy vector configuration </br>
Развертывает конфигурационный файл Vector с использованием шаблона Jinja2 </br>
Теги: *vector, config* </br>
Notify: *Start vector service*

* Flush handlers </br>
Выполняет все отложенные хэндлеры </br>
Теги: *vector, restart service*

## Установка и настройка Lighthouse

### Параметры 
*hosts*: lighthouse </br>
*become*: true

### Хэндлеры 
Restart Nginx </br>
Перезапускает службу Nginx </br>
Теги: *restart service, nginx*

### Задачи

* Update apt cache </br>
Обновляет кэш APT </br>
Теги: *update*

* Install Nginx </br>
Устанавливает пакет Nginx </br>
Теги: *install, nginx*

* Start Nginx service </br>
Запускает службу Nginx </br>
Теги: *service, nginx*

* Deploy Nginx configuration </br>
Развертывает конфигурационный файл Nginx с использованием шаблона Jinja2 </br>
Теги: *config, nginx* </br>
Notify: *Restart Nginx*

* Install git </br>
Устанавливает пакет Git </br>
Теги: *install, git*

* Clone Lighthouse repository </br>
Клонирует репозиторий Lighthouse </br>
Теги: *git, clone*

* Deploy Lighthouse configuration </br>
Развертывает конфигурационный файл Lighthouse с использованием шаблона Jinja2 </br>
Теги: *config, nginx* </br>
Notify: *Restart Nginx*


## Переменные 
*clickhouse_version*: версия ClickHouse для установки </br>
*clickhouse_packages*: список пакетов ClickHouse для установки </br>
*vector_version*: версия Vector для установки </br>
*vector_config_path*: путь для конфигурационного файла Vector </br>
*repo_lighthouse*: URL репозитория Lighthouse </br>
*path_to_repo*: путь для клонирования репозитория Lighthouse </br>
*lighthouse_host*: хост для Lighthouse </br>
*lighthouse_port*: порт для Lighthouse </br>
*clickhouse_host*: Хост для ClickHouse </br>
*clickhouse_user*: Пользователь ClickHouse </br>
*clickhouse_password*: Пароль пользователя ClickHouse </br>
*lighthouse_access_log_name*: Имя файла лога доступа для Lighthouse </br>


---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
