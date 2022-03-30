all: build

build:
	docker build --tag 1point3acres:latest .

run:
	docker run -d 1point3acres:latest

run_it:
	docker run -it 1point3acres:latest

dev: dev_build dev_run

dev_build:
	docker build --build-arg ENV=DEV --tag 1point3acres:dev .

dev_run: dev_build
	docker run -it --rm 1point3acres:dev