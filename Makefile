SYSTEMD_CONTAINER_NAME := boltron
DOCKER_FNAME := Dockerfile
# DOCKER_FNAME := Dockerfile-with-local-dnf

help:
		@echo "make build - Build a new docker image."
		@echo "make update - Build a new docker image, updating baseruntime."
		@echo "make update-force - Build a new docker image, from scratch."
		@echo "make run - Run the new image with bash."
		@echo "make run - Run the new image with systemd."
		@echo "make push-james - Push the new build to jamesantill/flat-modules-dnf."

build:
		@docker build --file=$(DOCKER_FNAME) . -t flat-modules-dnf

run:
		@docker run --rm -it flat-modules-dnf bash

push-james:
		@docker tag flat-modules-dnf jamesantill/flat-modules-dnf
		@docker push jamesantill/flat-modules-dnf

update:
		@docker build --file=$(DOCKER_FNAME) --pull . -t flat-modules-dnf
update-force:
		@docker build --file=$(DOCKER_FNAME) --pull --no-cache . -t flat-modules-dnf

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
