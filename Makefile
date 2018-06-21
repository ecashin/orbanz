.PHONY: gpytorch

gpytorch: stamps/gpytorch-build
	docker run -it \
	  --rm \
	  -p 8000:8000 \
	  ecashin/gpytorch tmux -c "su - `awk -F= '$$1==\"mk_LOGNAME\"{print $$NF}' .userinfo.sh`"

stamps/gpytorch-build: gpytorch.Dockerfile .userinfo.sh scripts/create-user.sh
	docker build -t ecashin/gpytorch -f $< .
	touch $@

.userinfo.sh:
	{ \
	  echo mk_UID=`id -u`; \
	  echo mk_LOGNAME=`id -un`; \
	  echo mk_GID=`id -g`; \
	} > $@
