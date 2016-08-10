dw version 0.6 - 2016-08-10

Shell script for building and managing docker containers
Run each function in succession

USAGE: dw [BUILD-DIR | BUILD-FILE] [function1] [function2] [...]

  Possible commands:

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

If no arguments are specified, run: dw start
