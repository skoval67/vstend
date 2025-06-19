Traefik
=========

Установка Traefik

Example Playbook
----------------
```
ansible-playbook -b playbook.yml -t traefik
```

Requirements
------------
```
yc iam key create --service-account-name my-robot --output key.json --description "This key is for DNS-01 challenge"
cat key.json | base64 > roles/traefik/files/yc-iam-token.txt
```
