include .env

all: rebuild_infra

init_infra:
	@cd terraform;\
	terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY" -reconfigure

rebuild_infra:
	@cd terraform;\
		export TF_VAR_MY_IP="$$(curl -s https://ident.me)/32";\
		terraform apply -auto-approve
