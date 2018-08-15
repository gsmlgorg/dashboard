default:
	@echo "========================================"
	@echo " release: create otp package            "
	@echo " page: update to github pages           "
	@echo "========================================"

release: build copy

page: web subtree

web:
	@cd assets; \
		rm -rf node_modules; \
		./yarn ; \
		./yarn run build 

build:
	@docker run --rm -v $$(pwd):/app -v $$(pwd)/build.sh:/build.sh --entrypoint /build.sh gsmlg/phoenix:alpine

copy:
	@export VER=$$(grep version mix.exs |awk -F'["]' '{print $$2}') ; \
		export APP=$$(grep 'app:' mix.exs |awk -F'[:,]' '{print $$3}') ; \
		\cp _build/prod/rel/$${APP}/releases/$${VER}/$${APP}.tar.gz . ; \
		\cp $${APP}.tar.gz $${APP}-v$${VER}.tar.gz

subtree:
	@BRANCH=$(shell git rev-parse --abbrev-ref HEAD) echo $$BRANCH \
	git checkout -b __tmp \
	git add -f priv/static \
	git commit -m 'publish ghpage' \
	git push origin `git subtree split --prefix priv/static `:master --force \
	git checkout $$BRANCH \
	git branch -D __tmp

