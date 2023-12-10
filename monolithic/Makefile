SHELL=/bin/bash

.PHONY: clean
clean:
	# Remove containers and images; avoid failure if the image doesn't exist
	for i in arc arc_db arc_node1 arc_node2 arc_node3 arc-tests arc-migrate-block; do \
		docker rm -f $$i || true ; \
		docker rmi $$i || true ; \
		docker volume rm monolithic_$$i-data || true ; \
	done

.PHONY: startup
startup:
	docker-compose up

.PHONY: startup-bg
startup-bg:
	docker-compose up -d


