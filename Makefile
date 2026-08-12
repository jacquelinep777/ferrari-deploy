.PHONY: fmt init init-local validate plan policy policy-fixture check clean

ENV ?= dev
ROOT ?= jumphost
PLAN_JSON ?= $(ROOT)/tfplan.json

fmt:
	terraform fmt -check -recursive

init:
	terraform -chdir=$(ROOT) init -input=false -backend-config=../environments/$(ENV).tfbackend

init-local:
	terraform -chdir=$(ROOT) init -backend=false -input=false

validate: init-local
	terraform -chdir=$(ROOT) validate

plan: init
	terraform -chdir=$(ROOT) plan -input=false -var-file=../environments/$(ENV).tfvars -out=tfplan
	terraform -chdir=$(ROOT) show -json tfplan > $(PLAN_JSON)

policy:
	conftest test $(PLAN_JSON) --policy policies

policy-fixture:
	conftest test tests/fixtures/blast-radius-safe-create.json --policy policies
	@echo "Policy passed: blast-radius guard accepts the safe workload fixture."

check: fmt validate policy-fixture

clean:
	rm -f $(ROOT)/tfplan $(ROOT)/tfplan.json
