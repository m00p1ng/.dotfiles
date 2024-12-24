.PHONY: pre-build post-build update-flake build-flake build build.update
.SILENT: pre-build post-build

INC_FILE=./override.nix

pre-build:
ifeq ($(profile),)
	echo "Please provide profile=..."
	exit 1
endif

	git update-index --no-skip-worktree $(INC_FILE)

	# gwip
	git add -A
	git rm $$(git ls-files --deleted) 2> /dev/null || true
	git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]" 1> /dev/null

post-build:
	# gunwip
	git log -n 1 | grep -q -c -e "--wip--" && git reset HEAD~1 1> /dev/null || true

	git update-index --skip-worktree $(INC_FILE)

update-flake:
	nix flake update

build-flake:
	darwin-rebuild switch --flake .#$(profile)

build: pre-build build-flake post-build

build.update: pre-build update-flake build-flake post-build
