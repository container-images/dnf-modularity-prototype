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
