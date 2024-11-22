pods:
	kubectl get pods --namespace ${env}

# generate ready to use commands
pods-exec:
	kubectl get pods --namespace ${env} | grep Running | awk '{print $$1}' | xargs -I {} echo kubectl exec -ti --namespace ${env} {} -- bash
