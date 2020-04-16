#STEPS TO REMOVE EXISTING DOCKER COMPONENTS FROM A NODE

docker node update --availability=drain <node-name> #for workers running user workloads
docker node demote <node-name> #for managers (except last one) to demote it to worker 
docker swarm leave #run directly on a given node to bring it to DOWN state
#node left swarm but we need to remove the metadata too
docker node rm <node-name> #run this from manager to remove metadata of node in DOWN state
docker container rm -f $(docker container ls -q) #remove any running containers before reinstall UCP/DTR
docker volume rm $(docker volume ls -q) #remove any volumes that might conflict with reinstall 
yum remove docker-ee docker-ee-cli containerd #in case you want to remove docker from node
rm /etc/yum.repos.d/docker*.repo #remove the docker repo
