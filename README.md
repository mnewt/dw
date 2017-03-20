# Docker wrapper (`dw`)

Shell script for managing docker containers on single host installations

The main point of `dw` is to capture the whole of a container's configuration
in a similar manner to (docker-compose)[https://docs.docker.com/compose/]. In
my opinion, `dw` is better because it is more flexible. You can run arbitrary
commands at any point and you can also use things like `pipework` to do fancy
things to your container before, during, or after its startup.

# Usage

```shell
dw [BUILD-DIR | BUILD-FILE] [function1] [function2] [...]
```

# Functions

```shell
exe
first
rest
contains
startswith
timeago
isrunning
containerexists
buildpre
buildpost
build
rebuild
publishports
createnetwork
create
startpre
startpost
stoppost
start
run
startservice
stop
stopservice
restart
restartservice
status
journal
cmd
logs
shell
runshell
remove
removeimage
clean
firewall
install
uninstall
ps
cleanuntagged
cleanall
isfn
```

If no arguments are specified, run: dw start


### DWfile

```shell
# The name of the container
name=sample

# A one line description
description="A sample docker container"

# The image label. If left blank, the container name is used
image=

# The hostname
hostname=--name--

# Volume options. Passed directly to `docker create`
# volumes="-v /etc/localtime:/etc/localtime:ro -v /opt/config/$name:/config -v /data:/data"
volumes="-v /etc/localtime:/etc/localtime:ro \
-v /opt/config/$name:/config \
-v /data:/data"

# Type of network setup
# Options are:
# - (blank): Defaults to bridge
# - bridge: Use a docker bridge network
# - host: Use the host network
# - container: Share an existing container's network stack
# - pipework: Create the container without networking, then use pipework to
#             give the container an interface and IP address on the host's
#             network adapter using macvlan
nettype=

# IP address to bind to the container
# - If `nettype=bridge`, use this host IP address to publish ports. If the host
#   doesn't have the IP address configured, then it will be added. Specify in
#   CIDR format.
#   hostip="192.168.0.89/24"
# - If `nettype=pipework`, give the container this IP address on the host's
#   local network using a macvlan interface. Use the format below.
#   hostip="192.168.0.89/24@192.168.0.1"
hostip=

# Host adapter to bind the container to if `nettype=pipework`. If unspecified,
# a guess is made
# adapter=eth0
adapter=

# The name of the docker network to connect to. It will be created if it doesn't
# already exist. Defaults to `bridge`
# network=netname
network=bridge

# The subnet of the docker network, in CIDR format
# subnet="172.20.0.0/16"
subnet=

# Set the default gateway of the container
gateway=

# Set a static IP address for the container
static_ip=

# Enable inter-container communication
# icc=true
icc=false

# IP ports to wire from container to host, using same port number on each side
# Specify ports in one of these formats
# - Port numbers optionally followed by "/udp", separated by space, e.g.:
#   ports="80 443 53/udp"
# - Host port, ":", container port, e.g.:
#   ports="80:8080 443:8443 8053:53/udp"
# - docker publish syntax, e.g.:
#   ports="-p $hostip:80:8080 -p $hostip:443:8443 -p $hostip:8053:53/udp"
ports=

# Additional options to pass to `docker create`
# options="--log-opt max-size=10m"
docker_options="--log-opt max-size=10m"

# Options to pass to docker run
run_options=

# Options to pass to the container entrypoint command
cmd_options=

# Adds a systemd unit as a service dependency when running `install` to install
# the container as a system service. Space separated list.
# depends=other_container
depends=

# Global directory to store persistent configuration data
config_dir=
```
