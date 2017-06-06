SYSTEMD_CONTAINER_NAME := boltron

help:
		@echo "make build - Build a new docker image."
		@echo "make run - Run the new image"
		@echo "make push-james - Push the new build to jamesantill/flat-modules-dnf."

build:
		@docker build . -t flat-modules-dnf

run:
		@docker run --rm -it flat-modules-dnf bash

push-james:
		@docker tag flat-modules-dnf jamesantill/flat-modules-dnf
		@docker push jamesantill/flat-modules-dnf

update:
		@docker build --pull . -t flat-modules-dnf

run-systemd:
	docker start $(SYSTEMD_CONTAINER_NAME) || \
	docker run -e container=docker -d \
		-v $(CURDIR)/machine-id:/etc/machine-id:Z \
		--stop-signal="SIGRTMIN+3" \
		--tmpfs /tmp --tmpfs /run \
		--security-opt=seccomp:unconfined \
		-v /sys/fs/cgroup/systemd:/sys/fs/cgroup/systemd \
		--name $(SYSTEMD_CONTAINER_NAME) \
		flat-modules-dnf /sbin/init
	@echo -e "\nContainer '$(SYSTEMD_CONTAINER_NAME)' with systemd is running.\n"
	docker exec -ti $(SYSTEMD_CONTAINER_NAME) bash
