build:
	docker build -t quay.io/defn/dev:latest-shell-operator-example .

push:
	docker push quay.io/defn/dev:latest-shell-operator-example

deploy:
	-kubectl delete pod shell-operator
	kubectl apply -f shell-operator-pod.yaml

log:
	stern shell-operator