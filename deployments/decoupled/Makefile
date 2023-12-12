SHELL=/bin/bash

.PHONY: cleanup
cleanup:
	# Remove containers and images; avoid failure if the image doesn't exist
	for i in arc decoupled_api_1 decoupled_api_2 arc_blocktx lb_metamorph decoupled_metamorph_1 decoupled_metamorph_2 decoupled_metamorph_3 arc_callbacker arc_db arc_node1 arc_node2 arc_node3 arc_migrate arc_tests ; do \
		docker rm -f $$i || true ; \
	done

	for i in arc arc_migrate arc_tests ; do \
		docker rmi $$i || true ; \
	done

	for i in arc_api arc_metamorph arc_blocktx arc_db arc_db arc_node1 arc_node2 arc_node3 ; do \
		docker volume rm decoupled_$$i-data || true ; \
	done

.PHONY: cleanup_full
cleanup_full:	cleanup
	# docker rm -f $(docker ps -q -a)
	docker system prune --force
	docker image prune -a -f
	docker builder prune -a -f 
	docker volume prune -a -f

.PHONY: startup
startup:
	docker-compose up

.PHONY: startup-replica
startup-replica:
	docker-compose -f docker-compose-replicas.yml up

.PHONY: startup-bg
startup-bg:
	docker-compose up -d

.PHONY: startup-replica-bg
startup-replica-bg:
	docker-compose -f docker-compose-replicas.yml up -d

