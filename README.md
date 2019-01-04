# Marbax_infra
Marbax Infra repository

ssh -i ~/.ssh/nikita_lessons -A op@35.207.72.229 ssh op@10.156.0.3

Host internal
	Hostname 10.156.0.3
	User op
	ProxyCommand ssh 35.207.72.229 -W %h:%p
	IdentityFile ~/.ssh/nikita_lessons
Host bastion
	Hostname 35.207.72.229
	User op
	IdentityFile ~/.ssh/nikita_lessons

bastion_IP = 35.207.72.229
someinternalhost_IP = 10.156.0.3

gcloud compute instances create reddit-app-test\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=/home/op/Documents/Marbax_infra/startup_script.sh 

gcloud compute --project=infra-226316 firewall-rules create default-puma-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server

testapp_IP = 35.204.135.240
testapp_port = 9292



