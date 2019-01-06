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



