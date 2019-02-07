# Marbax_infra

Marbax Infra repository

## HW1 

<details><summary>Знакомство с Git</summary><p>

 ### Регистрация:
 - GitHub подключен к платформе Otus
 - Сделан форк тестового репозитория 
 ```git clone <url>```
 - Сделан Pull Request(PR) документа со своим ФИО в репозиторий Отуса
 - Принято приглашение вступить в организацию Otus-DevOps-2018-11

### Работа с ветками:
 - Пробовал создавать и удалять ветки
 - Мерджил ветки
 - Перемещал (rebase) ветки
 - Клонировал удаленные удаленный репозиторий

### Зраегестрировался на GCP

<details><summary>Работа с Git:</summary><p>

 - Устанвлен Git
 - Персонализирован Git
  - ```git config --global user.name "ФИО"``` добавление имени пользователя
  - ```git config --global user.email мыло``` добавление мыла пользователя
 - ```git init``` инициализирован Git
 - ```git status ``` статус файлов внутри директории Git'а и просмотр конфликтов
 - ```git add файл ``` добавление файла в index (отслеживание)
 - ```git diff --cached``` проиндексированые изменения
 - ```git commit -am "комментарий"``` коммит изменений с добавлением индексации
 - ```git log``` просмотр истории коммитов
 - ```git show``` информация о последнем коммите
 - ```git commit --amend``` изменение последнего коммита
 - ```git revert 1f829c0``` отмена коммита по хешу (лучше от 7 символов хеша) либо ```HEAD~1``` откат последнего коммита . После устранения конфликта ```git revert --continue``` чтобы продолжить откат.
 - ```.gitignore``` вносятся файлы которые Git не должен видеть
 - ```git branch``` просмотр какая ветка текущая. ```git branch ветка``` создание ветки. ```git branch -d ветка``` удаление ветки
 - ```git checkout ветка``` переход на другую ветку .  ```git checkout -b ветка``` создание ветки и переход в нее
 - ```git log --all --decorate --oneline --graph``` график изменений 
 - ```git config --global alias.g 'log --all --decorate --oneline --graph'``` создания алиаса на ```git g``` для отображения графика изменений
 - ```git merge ветка``` мердж веток (слияние/перемещение указателя текущей ветки на указаную)
 - ```git rebase ветка``` текущая ветка меняет свое основание согласно указаной ,история стает линейной
 - ```git remote add origin git@github.com:пользователь/репозиторий.git``` добавление текущего репозитория на гитхаб:пользователь/репа
 - ```git push origin -u --all``` пуш всех веток , а ключ ```-u``` делает синхронизацию с дефолтной удаленной веткой

</p></details>



</p></details>

## HW2

<details><summary>play-travis Локальное окружение инженера. ChatOps и визуализация рабочих процессов. Командная работа с Git. Работа в GitHub.</summary><p>

- Клонирован личный репозиторий из Otus-DevOps 2018-11 ``` git clone git@github.com:Otus-DevOps-2018-11/<GITHUB_USER>_infra.git``` 
- Скачан шаблон PR 
- Зарегестрировался в Slack чате
- Создан канал для вывода проверок тревиса и добавлены преподователи
- Интегрирован тревис со слаком 
- Для использования команды ```travis``` установлен gem ```gem install travis && travis login --com```
- В корне репозитория создан ямль тревиса 
- Зашифрован токен полученый от тревиса ```travis encrypt "devops-team-otus:<ваш_токен>#<имя_вашего_канала>" --add notifications.slack.rooms --com```

</p></details>

## HW3

<details><summary>cloud-bastion Знакомство с облачной инфраструктурой и облачными сервисами.</summary><p>

### Создана учетная запись GCP
 - Создан новый проект
 - Добавлены ssh ключи в Compute Engine -> Metadata

### Созданы инстансы в веб интерфейсе GCP и подключался к ним по ssh
 - Создана VM со статическим внешним ИП
 - Создана VM без внешнего ИП
 - Настроен ssh forwarding ```ssh-add -L``` просмотр добавленых агенту ключей . ```ssh-add ~/.ssg/приватный_ключ``` добавление ключей агенту
 - ```ssh -i ~/.ssh/ключ -A юзер@ИП``` подключаемся к бастиону используя форвард агента ```ssh ИП``` а от него к машине в локальной сети

## Самостоятельное задание 
 - Подключение в одну команду ```ssh -i ~/.ssh/nikita_lessons -A op@35.207.72.229 -W op@10.156.0.3```

 <details><summary>Подключение с помощью алиаса в ~/.ssh/config.</summary><p>

```
Host internal
	Hostname 10.156.0.3
	User op
	ProxyCommand ssh 35.207.72.229 -W %h:%p
	IdentityFile ~/.ssh/nikita_lessons
Host bastion
	Hostname 35.207.72.229
	User op
	IdentityFile ~/.ssh/nikita_lessons
```
или 

```
Host internal
        ProxyCommand ssh -A bastion -W 10.156.0.3
        User appuser

Host bastion
        Hostname 35.207.72.229
        User appuser
        IdentityFile ~/.ssh/nikita_lessons
```

 </p></details>

- Разрешен http и https трафик на bastion

 <details><summary>На хосте bastion выполнены команды </summary><p>

```
 cat <<EOF> setupvpn.sh
 \#!/bin/bash
 echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.4.list
 echo "deb http://repo.pritunl.com/stable/apt xenial main" > /etc/apt/sources.list.d/pritunl.list
 apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 0C49F3730359A14518585931BC711F9BA15703C6
 apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
 apt-get --assume-yes update
 apt-get --assume-yes upgrade
 apt-get --assume-yes install pritunl mongodb-org
 systemctl start pritunl mongod
 systemctl enable pritunl mongod
 EOF
```

 </p></details>

- В результате установлен mongodb и pritunl
- Открыл порт ,который слушает ВПН на бастионе для UDP 
- Скачал пользовательский конфиг ВПНа и протестировал 

### Данные для подключения 
```
bastion_IP = 35.207.72.229
someinternalhost_IP = 10.156.0.3
```

- Рассмотрены варианты подключения к хостам через бастион-хост и VPN
 
</p></details>

## HW4

<details><summary>Основные сервисы Google Cloud Platform (GCP).</summary><p>

В процессе


#gcloud command for create instance with startup script from local file

gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=/home/op/Documents/Marbax_infra/startup_script.sh 

#or with url --metadata startup-script-url=gs://bucket/file

#gcloud command for create firewall rule

gcloud compute --project=infra-226316 firewall-rules create default-puma-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server

#IP and port of host with test deployment homework 

testapp_IP = 35.204.135.240
testapp_port = 9292



</p></details>


## HW5

<details><summary>Модели управления инфраструктурой. </summary><p>

created "fry" image and create "bake" image with additional tasks , aded puma.service which starts with machine and aded script to config-scripts which create instance from reddit-full image
</p></details>

## HW6

<details><summary>Практика Infrastructure as a Code (IaC)</summary><p>

Добавление ключей для проекта ,для нескольких пользователей

resource "google_compute_project_metadata_item" "default" {
  key   = "ssh-keys"
  value = "op:${file(var.public_key_path)}appuser:${file(var.public_key_path)}appuser1:${file(var.public_key_path)}"
}
Все ключи перезаписываются, если в вебе добавлять какие то ключи , то при след terraform apply они будут удалены .
</p></details>

## HW7

<details><summary>Принципы организации инфраструктурного кода и работа над инфраструктурой в команде на примере Terraform.</summary><p>

В терраформе все красивенько раскидано по модулям . 
1. Введите в source_ranges не ваш IP адрес, примените
правило и проверьте отсутствие соединения к обоим
хостам по ssh. Проконтролируйте, как изменилось правило
файрвола в веб консоли.
-Соеденение отсутствовало.В веб консоли меняется фильтр в правеле фаерваола.

-* Созданы бакеты.Перенесены стейт файлы прода и стейджа в удаленные бакеты. При паральном применении конфигурации тераформ говорит что локнут стейт :
"Error: Error locking state: Error acquiring the state lock: writing "gs://marbax-infra-bucket2/stage/default.tflock" failed: googleapi: Error 412: Precondition Failed, conditionNotMet"

-** Gровиженеры для деплоя приложения и юнита не осилил ,ошибка : * module.app.google_compute_instance.app: interrupted - last error: dial tcp 35.234.90.228:22: i/o timeout.
</p></details>

## HW8

<details><summary>Ansible-1 Управление конфигурацией.</summary><p>

Так как папка редит существует ,то плейбук не вносит никаких изменений , если ее удалить коммандой ansible app -m command -a 'rm -rf ~/reddit' , то применения плейбука вносит изменения .
Не совсем понял какой смысл в такнцах с бубном вокруг инвентори в формате джсона и скриптов .
</p></details>

## HW9

<details><summary>Ansible-2 Продолжение знакомства с Ansible: templates, handlers, dynamic inventory, vault, tags</summary><p>

Пробовал использовать плейбуки, хендлеры и шаблоны для конфигурации окружения и деплоя тестового приложения.
Исследованы разные подходы : 
- Использование одного плейбука с множеством сценариев и тэгов - неудобно нагроможденно ,нужно использовать много доп ключей и указывать хосты.
- Подход один плейбук, с множеством разделенных сценариев с обобщенными тэгами ,немного удобнее ,не нужно указывать хочты ,только тэги.
- Подхов в множество плейбуков - самый приятный и масштабируемый ,просто переиспользовать плейбуки ,никаких доп ключей.
Так же был изменен провижн образов Packer на Ansible-плейбуки.
Задание со * не выполнено :С
</p></details>

## HW10

<details><summary>Ansible-3 Принципы организации кода для управления конфигурацией</summary><p>

- Созданные плейбуки перенесены в раздельные роли.
- Описаны два окружения stage и prod.
- Установлена комьюнити роль nginx (ansible-galaxy).
- Использован Ansible Vault для шифровки данных дополнительно добавленых пользователей.

Задания со * не выполнены :с
</p></details>


