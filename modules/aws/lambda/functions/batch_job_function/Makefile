default: | help

format: ## Format codes by yapf 
	yapf -r -i --style pep8 src

format-check: ## Format check by yapf
	yapf -r -d --style pep8 src

mypy: ## Check static typing by mypy 
	mypy --ignore-missing-imports --python-version 3.6 --disallow-untyped-defs \
		--no-implicit-optional --allow-redefinition --show-error-context --pretty \
		src

flake8: ## Check PEP8 style by flake8
	flake8 --max-line-length=119 \
		--ignore=E121,E123,E126,E133,E226,E241,E242,E704,W503,W504,W505,E127,E266,E402,W605,W391,E701,E731 \
    src/

# This help command is cited from https://ktrysmt.github.io/blog/write-useful-help-command-by-shell/
help: ## print this message
	@grep -E '^[/a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | perl -pe 's%^([/a-zA-Z_-]+):.*?(##)%$$1 $$2%' | awk -F " *?## *?" '{printf "\033[36m%-30s\033[0m %-50s %s\n", $$1, $$2, $$3}'	
