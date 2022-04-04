DOCKER_RUN=docker run --name 1point3acres

all: build

build: submodule
	docker build --tag 1point3acres:latest .

run:
	$(DOCKER_RUN) -d 1point3acres:latest

run_it:
	$(DOCKER_RUN) -it 1point3acres:latest

dev: dev_build dev_run

dev_build: submodule
	docker build --build-arg ENV=DEV --tag 1point3acres:dev .

dev_run: dev_build
	$(DOCKER_RUN) -it --rm 1point3acres:dev

submodule:
	git submodule update
