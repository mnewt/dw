DOCKER		:=$(shell which docker)

all: build create start

build:
	$(DOCKER) build --no-cache -t $(NAME) .

rebuild:
	$(DOCKER) build -t $(NAME) .

create:
	# add IP address to host if necessary
	[ -z "$(IPADDR)" ] || ip addr show | grep "$(IPADDR)" || sudo ip addr add "$(IPADDR)/$(CIDR)" dev $(NIC)
	# format PORTS specified above into docker syntax
	$(eval docker_ports:=$(foreach port,$(PORTS),-p $(IPADDR):$(shell echo -n $(port) | cut -d "/" -f1):$(port)))
	$(DOCKER) create $(VOLUMES) $(OPTS) $(docker_ports) --name $(NAME) $(NAME)

start:
	sudo systemctl start $(NAME)

stop:
	sudo systemctl stop $(NAME)

logs:
	$(DOCKER) logs $(NAME)

shell:
	$(DOCKER) exec -it $(NAME) /bin/bash

run-shell:
	$(DOCKER) run -it $(VOLUMES) $(OPTS) --name $(NAME) $(NAME) /bin/bash

rm:
	$(DOCKER) rm -f $(NAME)
	$(DOCKER) rmi -f $(NAME)

firewall:
	sudo ufw allow $(PORTS)

install:
	sudo cp $(NAME).service /usr/lib/systemd/system/
	sudo systemctl enable $(NAME)

uninstall:
	sudo systemctl disable $(NAME)
	sudo rm /usr/lib/systemd/system/$(NAME).service


.PHONY: build rebuild create start stop logs shell rm firewall install uninstall
