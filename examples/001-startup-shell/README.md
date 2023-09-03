## onStartup shell example

Example of a hook written as bash script.

### run

Build Shell-operator image with custom scripts:

```
make build push
```

Edit image in shell-operator-pod.yaml and apply manifests:

```
make deploy
```

See in logs that shell-hook.sh was run:

```
make log
```
