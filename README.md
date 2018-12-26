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




