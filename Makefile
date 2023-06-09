##@ Help

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


##@ Lint

.PHONY: install
install: ## Install npm dependencies.
	npm install

.PHONY: lint
lint: prettier links ## Run linters.

.PHONY: prettier
prettier: ## Lint code.
	npx prettier --write .
	npx markdown-table-formatter README.md */README.md

.PHONY: links
links: ## Check for broken links. Note: dune links have been deactivated because they return a 403 status.
	npx linkinator "README.md" "*/README.md" --skip "https://dune.com" --skip "https://etherscan.io"
