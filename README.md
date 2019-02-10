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
 #!/bin/bash
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

<details><summary>cloud-testapp Основные сервисы Google Cloud Platform (GCP).</summary><p>

### Установлен и настроен gcloud для работы с нашим аккаунтом
- Скачан с офф сайта и устанвлен согласно документации от туда же
### Создан хост с помощью gcloud
### Установлен Ruby для работы приложения 
### Установлен MongoDB и запущен
### Задеплоино тестовое приложение ,запущено и проверено
- Так же открыт порт в фаерволе для http

### Созданы скрипты для установки ruby , mongodb и дэплоя приложения соответственно

### Доп задание 
- Создание инстанса с использованием стартап скрипта 
```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=/home/op/Documents/Marbax_infra/startup_script.sh 
```
или через урл
```
 --metadata startup-script-url=gs://bucket/file
```

- Создание правила фаервола при помощи gcloud 
```
gcloud compute --project=infra-226316 firewall-rules create default-puma-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server
```

- Данные для подключения 
```
testapp_IP = 35.204.135.240
testapp_port = 9292
```

</p></details>


## HW5

<details><summary>packer-base Модели управления инфраструктурой. </summary><p>

- Скачан Пакер , помещен в директорию ```/opt/``` , для окружения дописан путь в ```/etc/environment``` и применен ```source /etc/environment```
- Поделючен пользователь для использования Google API другими приложениями ```gcloud auth application-default login```
- Собран образ VM с предустановлеными  Ruby и MongoDB (baked-образ)
 - ```gcloud projects list``` посмотреть проекты на своем аккаунте
- Разобраны основные настройки секции builder в шаблоне , которая отвечает за создание виртуальной машины и образа
- Создана provisiners секция , которая отвечает за установку доп. ПО. Использованы shell скрипты для установки приложения и зависимостей ,также для установки базы данных
- Провалидирован шаблон ```packer validate ./ubuntu16.json``` и начата сборка ```packer build ubuntu16.json```
- Создан инстанс из ранее подготовленого образа
- Параметизирован созданый шаблон , переменные вынесены в ```variables.json```
- Исследованы другие опции builder для GCP

### Доп задание с *
#### Подход к управлению инфраструктурой Immutable infrastructure
- Создан шаблон immutable.json из которого пакер создает полностью готовый к работе инстанс (добавлен deploy скрипт)
- Создан shell-скрипт create-reddit-vm.sh в директории congig-scripts , который создает инстанс из раннее подготовленых образов 

</p></details>

## HW6

<details><summary>terraform-1 Практика Infrastructure as a Code (IaC)</summary><p>

- Скачан Terraform. Помещен в директорию ```/opt/``` , для окружения дописан путь в ```/etc/environment``` и применен ```source /etc/environment```
- В .gitignore добавлены служебные файлы тераформа 
- Определена секция Provider ,которая позволяет тераформу управлять ресурсами GCP через API. Для загрузки провайдера выполнено ```terraform init```
- Добавлен resource для создания VM 
- ```terraform plan``` в директории тераформа проверяет валидность шаблона и показывает какие он принесет действия 
- ```terraform apply -auto-approve=true``` создание инстанса . Так же создается terraform.tfstate , в котором хранится состояние ресурсов
- ```terraform show``` для просмотра .tfstate файла 
- Добавлен ресурс ssh ключей в метаданные 
- Создан output.tf ,с записыными перменными IP адресов,которые он будет выводить после удачного создания инстанса. ```terraform refresh``` обновление статусов и вывод аутпута. ```terraform output```  вывод аутпута ```terraform output app_extental_ip``` вывод значения конкретной переменной 
- Определен ресурс с правилом фаервола для доступа к приложению
- Определены секции провиженеров , которые копируют systemd unit и выполняют скрипт дэплоя в инстансе ,при создании
- Для работы провиженеров определена секция connection ,в которой описан способ подлкючения провижинеров к VM
- Параметизирован конфиг тераформа , дэфолтные переменные вынесены в variables.tf 
- Создан terraform.tfvars из которого тераформ берет переменные 

### Самостоятельное задания
- Определена переменная для приватного ключа
- Определена переменная для зоны ресурса
- ```terraform fmt``` отформатирована конфигурация ,приведена в приятный внешний вид
- Создан terraform.tfvars.example ,который комитится в репу

### Доп задание *
Добавление ключей для проекта ,для нескольких пользователей
```
resource "google_compute_project_metadata_item" "default" {
  key   = "ssh-keys"
  value = "op:${file(var.public_key_path)}appuser:${file(var.public_key_path)}appuser1:${file(var.public_key_path)}"
}
```
- Все ключи перезаписываются, если в вебе добавлять какие то ключи , то при след terraform apply они будут удалены .

### Доп задание ** не выполнено 

</p></details>

## HW7

<details><summary>terraform-2 Принципы организации инфраструктурного кода и работа над инфраструктурой в команде на примере Terraform.</summary><p>

- ```gcloud compute firewall-rules list``` просмотр установленных правил фаервола
- В конфигурацию тераформа добавлен ресурс создания правила фаервола для доступа по ssh. Если ранее было создано правило в вебе ,тераформ может не знать о нем . ```terraform import google_compute_firewall.firewall_ssh default-allow-ssh``` импорт правила из правил GCP в тераформ
- Создана неявная зависимость с ссылкой на IP
- Конфиг паккера ,так же как и конфиг тераформа разделен на два отдельных ,для приложения и для базы данных. Общие правила фаервола вынесены в отдельный файл
- Конфигурации тераформа приведены к модульной структуре
- ```terraform get``` чтобы загрузить модули и начать использовать
- Параметизирован конфиг для тераформа 
- Созданы два окружения stage и prod
- Добавлен модуль storage-bucket для удаленного хранилища

### Доп задание *
- Созданы бакеты.Перенесены стейт файлы прода и стейджа в удаленные бакеты. При паральном применении конфигурации тераформ говорит что локнут стейт :
"Error: Error locking state: Error acquiring the state lock: writing "gs://marbax-infra-bucket2/stage/default.tflock" failed: googleapi: Error 412: Precondition Failed, conditionNotMet"

### Доп задание **
Не выполнено


</p></details>

## HW8

<details><summary>Ansible-1 Управление конфигурацией.</summary><p>

### Установлен Ansible
- Установлен Python 2.7
- Установлен pip либо easy_isntall
- ```pip install ansible>=2.4``` установка ансибла версии больше 2.4
### Познакомился с базовыми функциями и инвентори 
### Выполнял различные модули на подготовленной в прошлых ДЗ инфраструктуре
### Написан просто плейбук
- Так как папка редит существует ,то плейбук не вносит никаких изменений , если ее удалить коммандой ansible app -m command -a 'rm -rf ~/reddit' , то применения плейбука вносит изменения .

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

### Задание со *
не выполнено :С

</p></details>

## HW10

<details><summary>Ansible-3 Принципы организации кода для управления конфигурацией</summary><p>

- Созданные плейбуки перенесены в раздельные роли.
- Описаны два окружения stage и prod.
- Установлена комьюнити роль nginx (ansible-galaxy).
- Использован Ansible Vault для шифровки данных дополнительно добавленых пользователей.

### Задания со * 
не выполнены :с

</p></details>


## HW11

### Локальная разработка при помощи Vagrant,доработка ролей для провижининга в Vagrant
### Переключение сбора образов пакером на использование ролей
### Подключение Travis CI для автоматического прогона тестов - не выполнено

- Скачан Vagrant и VirtualBox с офф сайтов

<details><summary>Добавлено в .gitignore</summary><p>

```
# Vagrant & molecule
.vagrant/
*.log
*.pyc
.molecule
.cache
.pytest_cache
```
</p></details>

<details><summary>Создан Vagrantfile с определением двух VM</summary><p>

```
Vagrant.configure("2") do |config|

  config.vm.provider :virtualbox do |v|
    v.memory = 512
  end

  config.vm.define "dbserver" do |db|
    db.vm.box = "ubuntu/xenial64"
    db.vm.hostname = "dbserver"
    db.vm.network :private_network, ip: "10.10.10.10"
  end
  
  config.vm.define "appserver" do |app|
    app.vm.box = "ubuntu/xenial64"
    app.vm.hostname = "appserver"
    app.vm.network :private_network, ip: "10.10.10.20"
  end
end
```
</p></details>

- Подняты виртуалки ```vagrant up```. Проверен скачаные боксы ```vagrant box list```. Проверен статус VMs ```vagrant status```
- Выполнено подключение к VM ```vagrant ssh appserver```
- Добавлен провиженер ansible для db. ```vagrant provision dbserver``` применение провиженера к уже созданой VM 
- Создан плейбук base.yml для установки питона ,т.к. ансибл работает на питоне ,плейбук исполняется как shell скрипт
- Создан install_mongo.yml для установки базовой монги и config_mongo.yml для копирования конфига
- С помощью ```telnet 10.10.10.10 27017``` с хоста приложения проверена доступность порта монги
- Добавлен плейбук ruby.yml ,который устанавливает зависимости приложения и puma.yml ,который копирует сервис и конфиг на хост приложения
- Добавлен провиженер ansible для app.
- ```cat .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory``` посмотерть инвентори файл провиженеров
- Параметизирован пользователь для appserver в ansible/roles/app/defaults и все его упоминания , в ansible/playbooks/deploy.yml и Vagrantfile в том числе
- ```vagrant destroy -f``` машини удалены , потом ```vagrant up``` созданы заново

### Доп задание с * 
Не выполнено :С

### Тестирование ролей при помощи Molecule и Testinfra
- Установлен virtualenv ```pip install virtualenv```. Создана директория для виртуального окружения ```mkdir .infra_python_en```. Создано виртуальное окружение```virtualenv venv```. Активировано окружение ```source .infra_python_env/venv/bin/activate```.

<details><summary>В виртуальном окружении питона установлено</summary><p>

```
ansible>=2.4
molecule>=2.6
testinfra>=1.10
python-vagrant>=0.5.15
```
</p></details>

- В директории ansible/roles/db/ выполнено ```molecule init scenario --scenario-name default -r db -d vagrant```  для создания заготовки тестов 

<details><summary>В db/molecule/default/tests/test_default.py добавлено несколько Testinfra модулей </summary><p>

```
import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')

# check if MongoDB is enabled and running
def test_mongo_running_and_enabled(host):
    mongo = host.service("mongod")
    assert mongo.is_running
    assert mongo.is_enabled

# check if configuration file contains the required line
def test_config_file(host):
    config_file = host.file('/etc/mongod.conf')
    assert config_file.contains('bindIp: 0.0.0.0')
    assert config_file.is_file
```
</p></details>

<details><summary>В db/molecule/default/molecule.yml добавлено описание тестовой машины (хоть оно и дэфолтное норм) </summary><p>

```
---
...
driver:
 name: vagrant
 provider:
 name: virtualbox
lint:
 name: yamllint
platforms:
 - name: instance
 box: ubuntu/xenial64
provisioner:
 name: ansible
 lint:
 name: ansible-lint
 ```

</p></details>

- В nasible/roles/db выполнено ```molecule create``` для создания VM . ```molecule list``` просмотр  инстансов молекулы. ```molecule login -h instance``` подключение к VM
- ansible/roles/db/molecule/default/playbook.yml плейбук молекулы .```molecule converge``` применение плейбука .  ```molecule verify``` запуск тестов
- Добавлен тест на прослушку порта для монги
- Роли из app.yml и db.yml закинуты в packer_app.yml и packer_db.yml соответсвенно
### Починил проверки тревиса , убрав пустые строки везде и между строк и в конце ,оставил одну строку в конце . Ансибл линту не нравятся однострочники 
