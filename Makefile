all: build_dev

build_dev:
	docker build --build-arg ENV=DEV --tag 1point3acres:dev .

run_dev:
	docker run --rm 1point3acres:dev