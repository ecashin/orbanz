stamps/gpytorch-build: gpytorch.Dockerfile .userinfo.sh scripts/create-user.sh
	docker build -t ecashin/gpytorch -f $< .
	touch $@

.userinfo.sh:
	{ \
	  echo mk_UID=`id -u`; \
	  echo mk_LOGNAME=`id -un`; \
	  echo mk_GID=`id -g`; \
	} > $@
