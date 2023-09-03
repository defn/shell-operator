build:
	docker build -t quay.io/defn/dev:latest-shell-operator .

ppush:
	docker push quay.io/defn/dev:latest-shell-operator
