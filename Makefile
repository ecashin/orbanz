.PHONY: gpytorch probtorch pyslds

pyslds: stamps/pyslds-build
	docker run -it \
	  --rm \
	  -p 8000:8000 \
	  -v $$PWD:/mnt/host \
	  ecashin/pyslds tmux -c "su - `awk -F= '$$1==\"mk_LOGNAME\"{print $$NF}' .userinfo.sh`"

gpytorch: stamps/gpytorch-build
	docker run -it \
	  --rm \
	  -p 8000:8000 \
	  ecashin/gpytorch tmux -c "su - `awk -F= '$$1==\"mk_LOGNAME\"{print $$NF}' .userinfo.sh`"

probtorch: stamps/probtorch-build
	docker run -it \
	  --rm \
	  -p 8000:8000 \
	  ecashin/probtorch tmux -c "su - `awk -F= '$$1==\"mk_LOGNAME\"{print $$NF}' .userinfo.sh`"

stamps/gpytorch-build: gpytorch.Dockerfile .userinfo.sh scripts/create-user.sh
	docker build -t ecashin/gpytorch -f $< .
	touch $@

stamps/probtorch-build: probtorch.Dockerfile .userinfo.sh scripts/create-user.sh stamps/gpytorch-build
	docker build -t ecashin/probtorch -f $< .
	touch $@

stamps/pyslds-build: pyslds.Dockerfile .userinfo.sh scripts/create-user.sh
	docker build -t ecashin/pyslds -f $< .
	touch $@

.userinfo.sh:
	{ \
	  echo mk_UID=`id -u`; \
	  echo mk_LOGNAME=`id -un`; \
	  echo mk_GID=`id -g`; \
	} > $@
