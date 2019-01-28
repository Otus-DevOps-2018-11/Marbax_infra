# Marbax_infra

Marbax Infra repository

#connect with one line command

ssh -i ~/.ssh/nikita_lessons -A op@35.207.72.229 ssh op@10.156.0.3

#rule for connection throught another host in ~/.ssh/config

Host internal
	Hostname 10.156.0.3
	User op
	ProxyCommand ssh 35.207.72.229 -W %h:%p
	IdentityFile ~/.ssh/nikita_lessons
Host bastion
	Hostname 35.207.72.229
	User op
	IdentityFile ~/.ssh/nikita_lessons

#ip of hosts for homework with vpn

bastion_IP = 35.207.72.229
someinternalhost_IP = 10.156.0.3

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

#HW7 created "fry" image and create "bake" image with additional tasks , aded puma.service which starts with machine and aded script to config-scripts which create instance from reddit-full image


#PR8 
Добавление ключей для проекта ,для нескольких пользователей

resource "google_compute_project_metadata_item" "default" {
  key   = "ssh-keys"
  value = "op:${file(var.public_key_path)}appuser:${file(var.public_key_path)}appuser1:${file(var.public_key_path)}"
}
Все ключи перезаписываются, если в вебе добавлять какие то ключи , то при след terraform apply они будут удалены .
#PR9
В терраформе все красивенько раскидано по модулям . 
1. Введите в source_ranges не ваш IP адрес, примените
правило и проверьте отсутствие соединения к обоим
хостам по ssh. Проконтролируйте, как изменилось правило
файрвола в веб консоли.
-Соеденение отсутствовало.В веб консоли меняется фильтр в правеле фаерваола.

-* Созданы бакеты.Перенесены стейт файлы прода и стейджа в удаленные бакеты. При паральном применении конфигурации тераформ говорит что локнут стейт :
"Error: Error locking state: Error acquiring the state lock: writing "gs://marbax-infra-bucket2/stage/default.tflock" failed: googleapi: Error 412: Precondition Failed, conditionNotMet"

-** Gровиженеры для деплоя приложения и юнита не осилил ,ошибка : * module.app.google_compute_instance.app: interrupted - last error: dial tcp 35.234.90.228:22: i/o timeout.
