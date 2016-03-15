# Helper for get npm package release notes for Github
# usage:
#     make current - show current version
#     make version <patch | minor | major | 3.4.5> — increase npm package version

REPO_LINK := https://github.com/user/repo

### Get current version from package.json
current:
	$(eval LAST_VERSION := $(shell npm ls --depth=0 2>/dev/null | head -n 1 | awk 'match($$0, /@([0-9.]+)/, arr) { print arr[1]; }'))
	@echo Current version is $(LAST_VERSION)

### Save new version number/string
ifeq (version,$(firstword $(MAKECMDGOALS)))
  NEW_VERSION := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(NEW_VERSION):;@:)
endif

### Update version
version:: current
	$(eval NEW_VERSION_TAG := $(shell npm version $(NEW_VERSION)))
	@echo
	@echo "[Full diff]($(REPO_LINK)/compare/v$(LAST_VERSION)...$(NEW_VERSION_TAG))"
	@git log --skip=1 --format='%h %s @%an' v$(LAST_VERSION)..$(NEW_VERSION_TAG)
