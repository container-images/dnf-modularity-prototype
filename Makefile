IMAGE_NAME := jamesantill/flat-modules-dnf
SYSTEMD_CONTAINER_NAME := boltron

help:
		@echo "make build - Build a new docker image."
		@echo "make run - Run the new image"
		@echo "make push-james - Push the new build to jamesantill/flat-modules-dnf."

build:
		@docker build . -t $(IMAGE_NAME)

run:
		@docker run --rm -it $(IMAGE_NAME) bash

push-james:
		@docker push $(IMAGE_NAME)

update:
		@docker build --pull . -t $(IMAGE_NAME)
update-force:
		@docker build --pull --no-cache . -t $(IMAGE_NAME)

run-systemd:
	docker start $(SYSTEMD_CONTAINER_NAME) || \
	docker run -e container=docker -d \
		-v $(CURDIR)/machine-id:/etc/machine-id:Z \
		--stop-signal="SIGRTMIN+3" \
		--tmpfs /tmp --tmpfs /run \
		--security-opt=seccomp:unconfined \
		-v /sys/fs/cgroup/systemd:/sys/fs/cgroup/systemd \
		--name $(SYSTEMD_CONTAINER_NAME) \
		$(IMAGE_NAME) /sbin/init
	@echo -e "\nContainer '$(SYSTEMD_CONTAINER_NAME)' with systemd is running.\n"
	docker exec -ti $(SYSTEMD_CONTAINER_NAME) bash
