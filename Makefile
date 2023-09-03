build:
	docker build -t quay.io/defn/dev:latest-shell-operator .

push:
	docker push quay.io/defn/dev:latest-shell-operator
