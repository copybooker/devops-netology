# Задание - 5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера.

##        1. Сценарий выполнения задачи:
- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

### Ответ:

    ```
    https://hub.docker.com/repository/docker/copybooker/web
    ```

##        2. Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- Высоконагруженное монолитное java веб-приложение;
- Nodejs веб-приложение;
- Мобильное приложение c версиями для Android и iOS;
- Шина данных на базе Apache Kafka;
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
- Мониторинг-стек на базе Prometheus и Grafana;
- MongoDB, как основное хранилище данных для java-приложения;
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.

### Ответ:

- Высоконагруженное монолитное java веб-приложение -
так как приложение монолитное, нужно использовать виртуальную машину;
- Nodejs веб-приложение -
в данном случае лучше использовать докер в связи с удобством развертывания;
- Мобильное приложение c версиями для Android и iOS -
лучше использовать виртуальную машину, не смог найти информацию об использовании докер для сборки мобильных приложений ios;
- Шина данных на базе Apache Kafka -
Возможно использование на базе готовых докер образов;
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana -
возможно использование на базе докер;
- Мониторинг-стек на базе Prometheus и Grafana -
предпочтительно использование докер для возможности масштабирования;
- MongoDB, как основное хранилище данных для java-приложения -
предпочтительно использовать виртуальную либо физическую машину, так как возможно потребуется высокая производительность при работе с базами данных;
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry -
возможно использование докер, но предпочтительнее использовать виртуальную машину по рекомендации в описании гитлаб сервера.


##       3. - Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.


### Ответ:

- Запускаю контейнер с Centos, подключив папку /data из текущей рабочей папки
```
and@and-Standard-PC-Q35-ICH9-2009:/opt/docker/change-volume$ sudo docker run -d -v /data:/data centos sleep infinity & wait
```
- Запускаю контейнер с Debian, подключив папку /data из текущей рабочей папки
```
and@and-Standard-PC-Q35-ICH9-2009:/opt/docker/change-volume$ sudo docker run -d -v /data:/data debian sleep infinity
```
- Подключаюсь к первому контейнеру с Centos и создаю файл в папке data
```
and@and-Standard-PC-Q35-ICH9-2009:/opt/docker/change-volume$ sudo docker exec -it 26b4283f2254 bash
[root@26b4283f2254 data]# touch file_centos
```
- Подключаюсь во второй контейнер с Debian, предварительно создав файл на хосте
```
and@and-Standard-PC-Q35-ICH9-2009:/opt/docker/change-volume$ sudo docker exec -it db6030a88da5 bash
[root@db6030a88da5 data]# ls -la
drwxr-xr-x 2 root root 4096 Oct 27 16:34 .
drwxr-xr-x 1 root root 4096 Oct 27 05:46 ..
-rw-r--r-- 1 root root    0 Oct 27 16:34 file_centos
-rw-rw--r-- 1 root root    0 Oct 27 16:35 file_host
```

##        4(*). Воспроизвести практическую часть лекции самостоятельно.

Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

### Ответ: 
```
https://hub.docker.com/repository/docker/copybooker/ansible
```
