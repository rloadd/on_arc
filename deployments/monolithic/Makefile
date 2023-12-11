SHELL=/bin/bash

.PHONY: clean
clean:
	# Remove containers and images; avoid failure if the image doesn't exist
	for i in arc arc_db arc_node1 arc_node2 arc_node3 arc_migrate arc_tests ; do \
		docker rm -f $$i || true ; \
	done

	for i in arc arc_migrate arc_tests ; do \
		docker rmi $$i || true ; \
	done

	for i in arc arc_db arc_node1 arc_node2 arc_node3 ; do \
		docker volume rm monolithic_$$i-data || true ; \
	done

.PHONY: clean_full
clean_full:	clean
	docker builder prune
	docker system prune -f

.PHONY: startup
startup:
	docker-compose up

.PHONY: startup-bg
startup-bg:
	docker-compose up -d


